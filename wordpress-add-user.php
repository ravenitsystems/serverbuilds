<?php
// Load WordPress environment
require_once 'wp-load.php';

$username = 'username';
$password = 'password';
$email = 'email@email.com';

$user = get_user_by('login', $username);

if (!$user) {
    // User doesn't exist, create them
    $user_id = wp_create_user($username, $password, $email);
    if (!is_wp_error($user_id)) {
        $user = new WP_User($user_id);
        $user->set_role('administrator');
        echo "✅ Admin user '$username' created successfully.";
    } else {
        echo "❌ Error creating user: " . $user_id->get_error_message();
    }
} else {
    // User exists, update password
    wp_set_password($password, $user->ID);
    echo "🔁 Password for existing user '$username' has been updated.";
}
