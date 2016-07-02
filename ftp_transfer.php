<?php 
/*Transfer file via FTP */
$server = 'IP Host FTP';
$ftp_user_name="FTP User";
$ftp_user_pass="FTP Password";
$connection = ftp_connect($server);
$login = ftp_login($connection, $ftp_user_name, $ftp_user_pass);



if (!$connection || !$login) { die('Connection attempt failed!'); }
$files_tar = glob("*.tar.gz");
foreach($files_tar as $file_tar) {
 $upload = ftp_put($connection, $file_tar,$file_tar, FTP_ASCII);
 if (!$upload) { echo 'FTP upload failed!'; }
  
}
ftp_close($connection);
//Delete file backup for security
$files_nen = glob("*.tar.gz");
foreach($files_nen as $file_nen) {
    if(is_file($file_nen)) { 
        unlink($file_nen);
    }
}
 ?>
