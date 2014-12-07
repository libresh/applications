<?php
/**
 * The base configurations of the WordPress.
 *
 * This file has the following configurations: MySQL settings, Table Prefix,
 * Secret Keys, WordPress Language, and ABSPATH. You can find more information
 * by visiting {@link http://codex.wordpress.org/Editing_wp-config.php Editing
 * wp-config.php} Codex page. You can get the MySQL settings from your web host.
 *
 * This file is used by the wp-config.php creation script during the
 * installation. You don't have to use the web site, you can just copy this file
 * to "wp-config.php" and fill in the values.
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'wordpress');

/** MySQL database username */
define('DB_USER', 'root');

/** MySQL database password */
define('DB_PASSWORD', '');

/** MySQL hostname */
define('DB_HOST', 'localhost');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '*TaXkV>#(:I-Rda@IDj](7M_{}b1f:DuR3cE;bH6oyz|?]if;uldpQ7I>K>mKpD9');
define('SECURE_AUTH_KEY',  'qR:vVQV_0?11o6s$^A`3u|9e-&Ik+pHWJ|$H.OL$;j8-o:}d5X`JMg8Mm8y<n/!=');
define('LOGGED_IN_KEY',    'IT p*fjrfV-Lb{oc9,Qlmz<&0_yh49Il:[NW]lz+m{jq=`=H]Xn-tilH_@l.4x+f');
define('NONCE_KEY',        '(QEYo/EQ`% C6}cqcd{l-=udH)]Bh1-MdpE~|-lga>XYhfj5-+#Jbm6C;4qH$&E!');
define('AUTH_SALT',        'vfNlVb([)06eQ}I7B3t`GhDA3n${C3Y>+g*B@B&){n /*I<WrKmKCJ?8j=(}P!In');
define('SECURE_AUTH_SALT', 'a$g8dcpue-?`&mpP:@kx|Qnr|X96t+QnK!gmUGCvfn}m+m3:ubH;.WQ%w@Gs,GmY');
define('LOGGED_IN_SALT',   '~jd/ CZc%6/s9 Wpb_(~6,GG?V-a]<&Kbntr>JF.#%x>jjmt9+sO*.<]<X7-%TRD');
define('NONCE_SALT',       'eWA/u].l,j8jT[?}XuH{-EC)IZ.}.Hpd49C]$A-<uepkeG%5(_:AvQ.L@6D]FR87');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each a unique
 * prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wp_';

/**
 * WordPress Localized Language, defaults to English.
 *
 * Change this to localize WordPress. A corresponding MO file for the chosen
 * language must be installed to wp-content/languages. For example, install
 * de_DE.mo to wp-content/languages and set WPLANG to 'de_DE' to enable German
 * language support.
 */
define('WPLANG', '');

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 */
define('WP_DEBUG', false);

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');

/** change permisssions for plugin installation */
define("FS_METHOD","direct");
define("FS_CHMOD_DIR", 0777);
define("FS_CHMOD_FILE", 0777);
