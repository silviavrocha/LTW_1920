<?php
  session_start();
  $logedin=true;
  include('templates/common/header.php');
?>
  <section id="property">
  <header>
        <h1> Add Property </h1>
  </header>
<?php
  include('templates/forms/property.php');
?>
  </section>
<?php
  include('templates/common/footer.php');
?>