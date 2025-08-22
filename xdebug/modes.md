string xdebug.mode = develop #

This setting controls which Xdebug features are enabled.

This setting can only be set in php.ini or files like 99-xdebug.ini that are read when a PHP process starts (directly, or through php-fpm). You can not set this value in .htaccess and .user.ini files, which are read per-request, nor through php_admin_value as used in Apache VHOSTs and PHP-FPM pools.

The following values are accepted:

off
    Nothing is enabled. Xdebug does no work besides checking whether functionality is enabled. Use this setting if you want close to 0 overhead.
develop
    Enables Development Helpers including the overloaded var_dump().
coverage
    Enables Code Coverage Analysis to generate code coverage reports, mainly in combination with PHPUnit.
debug
    Enables Step Debugging. This can be used to step through your code while it is running, and analyse values of variables.
gcstats
    Enables Garbage Collection Statistics to collect statistics about PHP's Garbage Collection Mechanism.
profile
    Enables Profiling, with which you can analyse performance bottlenecks with tools like KCacheGrind.
trace
    Enables the Function Trace feature, which allows you record every function call, including arguments, variable assignment, and return value that is made during a request to a file.

You can enable multiple modes at the same time by comma separating their identifiers as value to xdebug.mode: xdebug.mode=develop,trace.
XDEBUG_MODE environment variable

You can also set Xdebug's mode by setting the XDEBUG_MODE environment variable on the command-line; this will take precedence over the xdebug.mode setting, but will not change the value of the xdebug.mode setting.
