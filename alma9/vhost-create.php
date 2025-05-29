<?php

const PUBLIC_IP = "206.189.116.241";

try {
    if (($domain = $argv[1] ?? '') == '') {
        throw new Exception("The domain parameter is required");
    }

    $dig = shell_exec("dig {$domain}");
    if (!str_contains($dig, PUBLIC_IP)) {
        throw new Exception("The domain does not point to this server");
    }

    $directory = str_replace('.', '-', $domain);
    $conf_filename = '/etc/httpd/vhosts/' . $directory . '.conf';
    $vhost_root = '/var/www/' . $directory;
    $document_root = $vhost_root . '/public_html';
    $logs_root = $vhost_root . '/logs';
    print "CREATING VHOST FOR {$domain}" . PHP_EOL . PHP_EOL;
    print "Vhost Config: {$conf_filename}" . PHP_EOL;
    print "Vhost Root: {$vhost_root}" . PHP_EOL;
    print "Document Root: {$document_root}" . PHP_EOL;
    print "Logs Root: {$logs_root}" . PHP_EOL;


    mkdir($vhost_root);
    mkdir($document_root);
    mkdir($logs_root);
    shell_exec("chown -R apache:apache {$vhost_root}");


    $conf = <<<EOT
    <Directory "{$document_root}">
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
    AddType text/html .php
    SetEnvIfNoCase ^Authorization$ "(.+)" HTTP_AUTHORIZATION=$1
    <FilesMatch \.(php|phar)$>
    <If "-f %{REQUEST_FILENAME}">
    SetHandler "proxy:unix:/var/opt/remi/php83/run/php-fpm/www.sock|fcgi://localhost"
    </If>
    </FilesMatch>
    </Directory>

    <VirtualHost _default_:80>
    ServerName {$domain}
    ServerAlias www.{$domain}
    DocumentRoot "{$document_root}"
    ErrorLog {$logs_root}/error_log
    TransferLog {$logs_root}/access_log
    LogLevel warn
    </VirtualHost>

    <VirtualHost _default_:443>
    ServerName {$domain}
    ServerAlias www.{$domain}
    DocumentRoot "{$document_root}"
    ErrorLog {$logs_root}/error_log
    TransferLog {$logs_root}/access_log
    LogLevel warn
    SSLEngine on
    SSLCertificateFile /etc/pki/tls/certs/localhost.crt
    SSLCertificateKeyFile /etc/pki/tls/private/localhost.key
    #SSLCertificateChainFile /etc/pki/tls/certs/server-chain.crt
    #SSLCACertificateFile /etc/pki/tls/certs/ca-bundle.crt
    <FilesMatch "\.(cgi|shtml|phtml|php)$">
    SSLOptions +StdEnvVars
    </FilesMatch>
    BrowserMatch "MSIE [2-5]" nokeepalive ssl-unclean-shutdown downgrade-1.0 force-response-1.0
    </VirtualHost>
    EOT;

    file_put_contents($conf_filename, $conf);

    print "Restarting Apache" . PHP_EOL;
    shell_exec("apachectl restart");
    print "Done." . PHP_EOL;

    print "Requesting Certificate" . PHP_EOL;
    shell_exec("certbot certonly --non-interactive --agree-tos --webroot -w {$document_root} -d  {$domain} -d www.{$domain}");
    print "Done." . PHP_EOL;

    $c_key = "/etc/letsencrypt/live/{$domain}/privkey.pem";
    $c_crt = "/etc/letsencrypt/live/{$domain}/fullchain.pem";

    if (!file_exists($c_key) || !file_exists($c_crt)) {
        throw new Exception("Certbot failed");
    }

    $conf = str_replace("/etc/pki/tls/private/localhost.key", $c_key, $conf);
    $conf = str_replace("/etc/pki/tls/certs/localhost.crt", $c_crt, $conf);

    file_put_contents($conf_filename, $conf);

    print "Restarting Apache" . PHP_EOL;
    shell_exec("apachectl restart");
    print "Done." . PHP_EOL;






} catch (Exception $exception) {
    print PHP_EOL . PHP_EOL . "SCRIPT ERROR" . PHP_EOL . PHP_EOL;
    print $exception->getMessage() . PHP_EOL . PHP_EOL;
    exit(1);
}
