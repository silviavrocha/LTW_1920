<?php
    session_start();
    $db = new PDO('sqlite:../../database/database.db');
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $db->setAttribute  (PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    include_once('../../database/users.php');
    $id=$_SESSION['user'];
    modifyUser($id, $_POST['password'], $_POST['primeiroNome'], $_POST['ultimoNome'], $_POST['dateofbirth'], $_POST['email'], $_POST['phone'], $_POST['country']);
    
    if(is_uploaded_file($_POST['pictures']['tmp_name'])){
        $allowedExts = array("jpeg", "jpg", "png");
        $temp = explode(".", $_FILES["file"]["name"]);
        $extension = end($temp);
        if ((($_FILES["file"]["type"] == "image/jpeg")
                || ($_FILES["file"]["type"] == "image/jpg")
                || ($_FILES["file"]["type"] == "image/pjpeg")
                || ($_FILES["file"]["type"] == "image/x-png")
                || ($_FILES["file"]["type"] == "image/png"))
            && ($_FILES["file"]["size"] < 500000)
            && in_array($extension, $allowedExts)) {
            if ($_FILES["file"]["error"] > 0) {
                echo "Return Code: " . $_FILES["file"]["error"] . "<br>";
            }
            else {
                $ext = end(explode(".", $_FILES["file"]["name"]));
                $fileName = "images" . $user['id'] . $ext;
                if(move_uploaded_file($_FILES['pictures']['tmp_name'], $fileName)){
                    addPhotoProfile($user['idUtilizador'], $fileName, $_POST['primeiroNome'] . "'s Photo");
                }
            }   
        } 
        else {
            echo "<div class='alert alert-success'>Image type or size is not valid.</div>";
        }
    }

    header( 'Location: ../../homepage.php' ) ;
?>