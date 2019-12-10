<?php
  include('database/connection.php');
  include('database/habitations.php');
  
  session_start();
  $logedin=true;
  if (!isset($_SESSION['user']))
    header( 'Location: homepage.php' );
  $owner = getOwner($_GET['id'])['idUtilizador'];
  if ($_SESSION['user']!=$owner)
    header( 'Location: homepage.php' );
  
  include('templates/common/header.php');
  $action_form="templates/forms/editProperty_action.php";

  $property=getHabitationById($_GET['id']);
  $name=$property['nome'];
  $type=getNameType($property['idTipo']);
  $numberGuests=$property['maxHospedes'];
  $numberBedrooms=$property['numQuartos'];
  $priceNight=$property['precoNoite'];
  $tax=$property['taxaLimpeza'];
  $description=$property['descricao'];
  $latitude=$property['latitude'];
  $longitude=$property['longitude'];
  $address=$property['morada'];
  $city=getNameCity($property['idCidade']);
  $country=getCountryCity($property['idCidade']);
  $policy=$property['idPolitica'];
  $image="";
?>
  <section id="editProperty">
  <header>
        <h1> Edit Property </h1>
  </header>
<?php
  include('templates/forms/property.php');
?>
  </section>
<?php
  include('templates/common/footer.php');
?>