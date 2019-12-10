<form  class="verticalForm" action=<?=$action_form?> method="post">
    <label> Name
        <input type="text" name="name" value="<?=$name?>" required>
    </label>
    <!--          type             -->
    <label> Type
        <select name="types" value="<?=$type['idTipo']?>" required>
            <?php
            include_once('database/connection.php');
            include_once('database/habitations.php');
            $types = getTypes();

            foreach ($types as $type) {
                echo '<option value="' . $type['idTipo'] . '">' . $type['nome'] . '</option>';
            }
            ?>
        </select>
    </label>
    <!--          guests and numbers            -->
    <label> Maximum Number of Guests
        <input type="number" name="numberGuests" value="<?=$numberGuests?>" min="1" required>
    </label>
    <label> Number of Bedrooms
        <input type="number" name="numberBedrooms" value="<?=$numberBedrooms?>"min="1" required>
    </label>
    <!--          prices             -->
    <label class="currency"> Price per Night
        <input type="number" name="priceNight" value="<?=$priceNight?>" min="0" step="0.01" id="priceNight" />
    </label>
    <label class="currency"> Cleaning Tax
        <input type="number" name="cleaningTax" value="<?=$tax?>" min="0" step="0.01" id="cleaningTax" />
    </label>
    <label> Description
        <textarea name="description" rows="10"><?=$description?></textarea>
    </label>
    <!--         amenities           -->
    <script src="scripts/amenities.js" defer></script>
    <label>Amenity:
        <input type="text" id="amenities_input" name="amenity">
    </label>
    <input type="button" value="Add" id="amenities_button" class="submit">
    <table id="amenities_table">
    </table>
    <!--          agenda             -->
    <script src="scripts/agenda.js" defer></script>
    <label>From:
        <input id="agenda_input_from" type="date" name="date_from">
    </label>
    <label>To:
        <input id="agenda_input_to" type="date" name="date_to">
    </label>
    <input type="button" value="Add" id="agenda_button" class="submit">
    <table id="agenda">
    </table>
    <!--          coordinates             -->
    <label> Latitude (Format DD)
        <input type="number" value="<?=$latitude?>" min="-90" max="90" step="0.000001" id="latitude">
    </label>
    <label> Longitude (Format DD)
        <input type="number" value="<?=$longitude?>" min="-180" max="180" step="0.000001" id="longitude">
    </label>
    <label> Address
        <input type="text" name="address" value="<?=$address?>" required>
    </label>
    <label> City
        <input type="text" name="city" value="<?=$city?>" required>
    </label>
    <label> Country
        <select name="country"  value="<?=$country['idPais']?>" required>
            <?php
            include_once('database/connection.php');
            include_once('database/users.php');
            $countries = getCountries();

            foreach ($countries as $country) {
                echo '<option value="' . $country['idPais'] . '">' . $country['nome'] . '</option>';
            }
            ?>
        </select>
    </label>
    <!--          cancelation policy             -->
    <label> Cancellation Policy
        <select name="policies" value="<?=$policy['idPolitica']?> "required>
            <?php
            include_once('database/connection.php');
            include_once('database/habitations.php');
            $policys = getCancellationPolicys();

            foreach ($policys as $policy) {
                echo '<option value="' . $policy['idPolitica'] . '">' . $policy['nome'] . '</option>';
            }
            ?>
        </select>
    </label>
    <!--          pictures             -->
    <label> Upload Pictures (Select All Pictures At Once)
        <input type="file" name="pictures" accept="image/*" value=<?=$image?> multiple required>
    </label>
    <input class="submit" type="submit" value="Submit" onsubmit="return copyFromForm2Function()">
</form>