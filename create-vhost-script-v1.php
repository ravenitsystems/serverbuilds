<?php
const APACHE_VHOST_DIRECTORY = '/etc/httpd/vhosts';
const WEB_APPLICATIONS_DIRECTORY = '/var/www';

try {

    print PHP_EOL;
    print str_repeat('#', 80) . PHP_EOL;
    print "# APACHE VHOST CREATION SCRIPT v1.0" . PHP_EOL;
    print str_repeat('#', 80) . PHP_EOL;
    print PHP_EOL;

    // Check if the current user is root as nothing will work otherwise
    if (posix_getuid() !== 0) {
        throw new Exception("Script must be ran as the root user");
    }

    // Check the configured directories exist
    if (!file_exists(APACHE_VHOST_DIRECTORY) || !is_dir(APACHE_VHOST_DIRECTORY)) {
        throw new Exception("The Apache vhost directory could not be found");
    }
    if (!file_exists(WEB_APPLICATIONS_DIRECTORY) || !is_dir(WEB_APPLICATIONS_DIRECTORY)) {
        throw new Exception("The web applications directory could not be found");
    }

    // Check that we have a primary domain as a parameter
    if (($domain = $argv[1] ?? '') == '') {
        throw new Exception("The primary domain is a required parameter");
    }

    // Collect any domain alias to be added to the vhost
    $alias_list = [];
    for($index = 2; $index < sizeof($argv); $index++) {
        $alias_list[] = $argv[$index] ?? '';
    }

    // Convert the primary domain into a username we can use for all referencing files
    $username = str_replace('-', '_', str_replace('.', '_', $domain));
    while($username != str_replace('__', '_', $username)) {
        $username = str_replace('__', '_', $username);
    }

    // Put together the file locations we need to create
    $conf_path = APACHE_VHOST_DIRECTORY . '/' . $username . '.conf';
    $root_path = WEB_APPLICATIONS_DIRECTORY . '/' . $username;
    $docs_path = WEB_APPLICATIONS_DIRECTORY . '/' . $username . '/webroot/public';
    $logs_path = WEB_APPLICATIONS_DIRECTORY . '/' . $username . '/logs';

    // Output the details gathered so far
    print "Primary Domain: {$domain}" . PHP_EOL;
    print "Alias Domains: " . implode(', ', $alias_list) . PHP_EOL;
    print "Generated Username: {$username}" . PHP_EOL;
    print "Vhost config file: {$conf_path}" . PHP_EOL;
    print "Application root: {$root_path}" . PHP_EOL;
    print "Logs directory: {$docs_path}" . PHP_EOL;
    print "Logs directory: {$logs_path}" . PHP_EOL;

    print PHP_EOL;

    // Check that the vhost we are trying to create does not exist already
    if (file_exists($conf_path)) {
      //  throw new Exception("The file {$conf_path} already exists");
    }

    // Create the directory structure for the application
    verifyDirectory($root_path);
    verifyDirectory($logs_path);
    verifyDirectory($root_path . '/webroot');
    verifyDirectory($docs_path);
    shell_exec("chown -R apache:apache {$root_path}");

    // Generate a component to put in the alias domains
    $alias = '';
    foreach ($alias_list as $alias_item) {
        $alias .= "ServerAlias $alias_item" . PHP_EOL;
    }
    $alias = ($alias != '') ? PHP_EOL . trim($alias): '';

    // Write the config file to the vhosts config folder
    $conf = <<<EOT
    <Directory "{$docs_path}">
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
    AddType text/html .php
    SetEnvIfNoCase ^Authorization$ "(.+)" HTTP_AUTHORIZATION=
    <FilesMatch \.(php|phar)$>
    <If "-f %{REQUEST_FILENAME}">
    SetHandler "proxy:unix:/var/opt/remi/php83/run/php-fpm/www.sock|fcgi://localhost"
    </If>
    </FilesMatch>
    </Directory>

    <VirtualHost _default_:80>
    ServerName {$domain}{$alias}
    DocumentRoot "{$docs_path}"
    ErrorLog "{$logs_path}/error_log"
    TransferLog "{$logs_path}/access_log"
    LogLevel warn
    </VirtualHost>

    <VirtualHost _default_:443>
    ServerName {$domain}{$alias}
    DocumentRoot "{$docs_path}"
    ErrorLog "{$logs_path}/error_log"
    TransferLog "{$logs_path}/access_log"
    LogLevel warn
    SSLEngine on
    SSLCertificateFile /etc/pki/tls/certs/localhost.crt
    SSLCertificateKeyFile /etc/pki/tls/private/localhost.key
    <FilesMatch "\.(cgi|shtml|phtml|php)$">
    SSLOptions +StdEnvVars
    </FilesMatch>
    BrowserMatch "MSIE [2-5]" nokeepalive ssl-unclean-shutdown downgrade-1.0 force-response-1.0
    </VirtualHost>
    EOT;

    file_put_contents($conf_path, $conf);

    // Restart Apache
    shell_exec("apachectl restart");

    $certbot = "certbot certonly --non-interactive --agree-tos --email support@avantiy.com --webroot -w {$docs_path} -d {$domain}";
    foreach($alias_list as $alias_item) {
        $certbot .= " -d {$alias_item}";
    }

    $certbot_response = shell_exec($certbot);
    if (str_contains($certbot_response, 'Successfully received certificate.') || str_contains($certbot_response, 'Certificate not yet due for renewal')) {

        $cert_pub_path = "/etc/letsencrypt/live/{$domain}/fullchain.pem";
        if (!file_exists($cert_pub_path)) {
            throw new Exception("Could not find certificate public key: {$cert_pub_path}");
        }
        $cert_key_path = "/etc/letsencrypt/live/{$domain}/privkey.pem";
        if (!file_exists($cert_key_path)) {
            throw new Exception("Could not find certificate private key: {$cert_key_path}");
        }

        $conf = file_get_contents($conf_path);
        $conf = str_replace('/etc/pki/tls/certs/localhost.crt', $cert_pub_path, $conf);
        $conf = str_replace('/etc/pki/tls/private/localhost.key', $cert_key_path, $conf);
        file_put_contents($conf_path, $conf);

        // Restart Apache
        shell_exec("apachectl restart");
    } else {
        print $certbot_response;
        throw new Exception("Could not receive certificate");
    }





} catch (Throwable $exception) {
    print PHP_EOL . PHP_EOL;
    print "SCRIPT ERROR - HALTING EXECUTION" . PHP_EOL . PHP_EOL;
    /** @var Throwable $exception_loop */
    $exception_loop = $exception;
    while ($exception_loop instanceof Throwable) {
        print "#{$exception_loop->getCode()} @ {$exception_loop->getFile()}:{$exception_loop->getLine()} {$exception_loop->getMessage()}" . PHP_EOL;
        $exception_loop = $exception_loop->getPrevious();
    }
    print PHP_EOL;
    print $exception->getTraceAsString() . PHP_EOL;
    print PHP_EOL;
    print "Exiting Script" . PHP_EOL . PHP_EOL;
    exit($exception->getCode());
}

function verifyDirectory(string $path): void
{
    if (!file_exists($path)) {
        @mkdir($path);
    }
    if (!file_exists($path) || !is_dir($path)) {
        throw new Exception("The directory '{$path}' does not exist and could not be created");
    }
}

