<?php
// Normally written by install/index.php. For the Base44 development
// environment the values come from the environment (see
// docker-compose.base44.yml) so no credentials live in the repository.
$mysql_hostname = getenv('TUBEAK_DB_HOST') ?: 'localhost';
$mysql_username = getenv('TUBEAK_DB_USER') ?: 'root';
$mysql_password = getenv('TUBEAK_DB_PASSWORD') ?: '';
$mysql_database = getenv('TUBEAK_DB_NAME') ?: 'tubeak';

$site_url = getenv('TUBEAK_SITE_URL') ?: ''; // e.g (http://example.com)
?>
