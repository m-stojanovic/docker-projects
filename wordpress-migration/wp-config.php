<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress_db');

/** MySQL database username */
define( 'DB_USER', 'root');

/** MySQL database password */
define( 'DB_PASSWORD', '');

/** MySQL hostname */
define( 'DB_HOST', 'db');

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'do^a@/&o8NSm<[{Z%J!*LK6S|sqczTvX==7`)%h^-F5VR$j4NU*jS<k|q5!Gg#D_' );
define( 'SECURE_AUTH_KEY',  'Japc@oW2i<x-N1I]AZX<4;:~KGc/a> D++Eq`5h9zWOsi2|ppX/}kDk,T`o?.Hsn' );
define( 'LOGGED_IN_KEY',    '$X?a+D:3?-?D(:MfO/XEH[<A m(Yc%OIZ8z[>ttM{kB$!;0,sSJ,8CiK)E;QYV0(' );
define( 'NONCE_KEY',        'NNjeS]Oo4*{P=+{p<__uP&q.X0H1f:woQ^%r|KHvGKPySa]Oh{q_&wr90-(,j`Qu' );
define( 'AUTH_SALT',        's_W5(WOY5G!bu<X6]3>Ya?)?@|GmkBpYInN>LZ*E3(`l}F6KrFRU|8vR-am[]|n!' );
define( 'SECURE_AUTH_SALT', 'UA, ap=@v4F-aoDJ%m}BVFr)::toDt?3Q2ojpO9L`nW`,$63 io]wP:Cqp3FlP`Z' );
define( 'LOGGED_IN_SALT',   'j3TtAh#1NC)U:@kiUUzW}_]+JYIZ4UQ8kMRvElAn;RYz*4ut,bqH5f`M`K]xw@T<' );
define( 'NONCE_SALT',       'FV,?cR(1!wdS}_s@M8[O]*F.!O(aBtAGJZCU34D?n!c$xDZ9}ASYxa088 N/`oE;' );

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );
@ini_set('upload_max_size' , '256M' );
/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
