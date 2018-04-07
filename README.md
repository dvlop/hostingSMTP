# PhpMailer - Jak wysłać e-mail z nazwa.pl
Przykład w php użycia PhpMailer do wysyłania wiadomości e-mail z hostingu w nazwa.pl

```php
<?php
// import class dla namespace
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require 'src/Exception.php';
require 'src/PHPMailer.php';
require 'src/SMTP.php';

$mail = new PHPMailer(true);                              // Passing `true` enables exceptions

try {
    // SMTP Server ustawienia
    // $mail->SMTPDebug = 2;                              // Enable verbose debug output Show Errors
    $mail->isSMTP();                                      // Set mailer to use SMTP
    $mail->Host = 'twoja.nazwa.pl';                       // Specify main and backup SMTP servers
    $mail->SMTPAuth = true;                               // Enable SMTP authentication
    $mail->Username = 'noreply@twojadomena.xx';           // SMTP username
    $mail->Password = 'HasłoDoEmail';                     // SMTP password
    $mail->SMTPSecure = 'tls';                            // Enable TLS encryption, `ssl` also accepted
    $mail->Port = 587;                                    // TCP port to connect to
    
    // Dodać gdy używamy twoja-domena.xx zamiast twojanazwa.nazwa.pl w $mail->Host
    $mail->SMTPOptions = array(
        'ssl' => array(
            'verify_peer' => false,
            'verify_peer_name' => false,
            'allow_self_signed' => true
        )
    );
    
    //Recipients
    $mail->setFrom('noreply@twojadomena.xx', 'Mailer');
    $mail->addAddress('hello@odbiorca.xx', 'Joe User');     // Add a recipient
    $mail->addReplyTo('noreply@twojadomena.xx', 'Information');
    
    //$mail->addCC('cc@example.com');
    //$mail->addBCC('bcc@example.com');
    
    //Attachments
    // $mail->addAttachment('/var/tmp/file.tar.gz');         // Add attachments
    // $mail->addAttachment('/tmp/image.jpg', 'new.jpg');    // Optional name
    
    //Content
    $mail->isHTML(true);                                  // Set email format to HTML
    $mail->Subject = 'Here is the subject';
    $mail->Body    = 'This is the HTML message body <b>in bold!</b>';
    $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';
    $mail->send();
    echo 'Message has been sent';
} catch (Exception $e) {
    echo 'Message could not be sent. Mailer Error: ', $mail->ErrorInfo;
}
?>
```

# Minus hostingu w nazwa.pl
#### Brak bezpiecznego połączenia tls/ssl dla serwera mysql/mariadb.
#### Dostęp z poza hostingu do serwera mysql/mariadb jest możliwy bez tls/ssl. 

```php
<?php
// session_start();
// error_reporting(0);
// echo __DIR__;
// SHOW VARIABLES LIKE '%ssl%'
// GRANT ALL PRIVILEGES ON *.* TO 'ssluser'@'localhost' IDENTIFIED BY 'ssluser' REQUIRE SSL;

try{
$pdo = new PDO('mysql:host=sql.twojanazwa.nazwa.pl;dbname=Dbname', 'Username', 'Password', array(
PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8",
//PDO::MYSQL_ATTR_SSL_KEY => '/home/folder/ftp/priv.key',
//PDO::MYSQL_ATTR_SSL_CERT => '/home/folder/ftp/crt.crt',
//PDO::MYSQL_ATTR_SSL_CA => '/home/folder/ftp/ca.crt',
PDO::MYSQL_ATTR_SSL_VERIFY_SERVER_CERT => false
    )
);

echo "<pre>";

// $pdo = new PDO('mysql:host=sql.nazwa.nazwa.pl;dbname=Dbname', 'Username', 'Password');
$statement = $pdo->query("SELECT * FROM demo");
$statement = $pdo->query("SHOW VARIABLES LIKE '%ssl%'");
$row = $statement->fetch(PDO::FETCH_ASSOC);
print_r($row);

$statement = $pdo->query("SHOW SESSION STATUS LIKE 'Ssl_version';");
$row = $statement->fetch(PDO::FETCH_ASSOC);
print_r($row);

$statement = $pdo->query("SHOW SESSION STATUS LIKE 'Ssl_cipher';");
$row = $statement->fetch(PDO::FETCH_ASSOC);
print_r($row);

$statement = $pdo->query("show global variables like 'have_ssl';");
$row = $statement->fetch(PDO::FETCH_ASSOC);
print_r($row);

$statement = $pdo->query("SHOW status LIKE '%ssl%'");
$row = $statement->fetch(PDO::FETCH_ASSOC);
print_r($row);

echo "Jak się połączyć za pomocą bezpiecznego połączenia ssl/tls ??? <br>" . htmlentities($row['id']);
// print_r($row);
}catch(\PDOException $e){
   echo $e->getMessage();
   echo $e->getCode();
   die('Failed connecting');
}

echo '+---------------------+----------------------------+
| Variable_name       | Value                      |
+---------------------+----------------------------+
| have_openssl        | YES                        |
| have_ssl            | DISABLED                   |
| ssl_ca              |                            |
| ssl_capath          |                            |
| ssl_cert            |                            |
| ssl_cipher          |                            |
| ssl_crl             |                            |
| ssl_crlpath         |                            |
| ssl_key             |                            |
| version_ssl_library | OpenSSL 1.0.2g  1 Mar 2016 |
+---------------------+----------------------------+';
?>
```
