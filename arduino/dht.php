<html>
<body>

<?php

$dbname = 'iot';
$dbuser = 'reda';  
$dbpass = 'password'; 
$dbhost = 'localhost'; 

$connect = @mysqli_connect($dbhost,$dbuser,$dbpass,$dbname);

if(!$connect){
	echo "Error: " . mysqli_connect_error();
	exit();
}

echo "Connection Success!<br><br>";

$temperature = $_GET["temperature"];
$humidity = $_GET["humidity"]; 
$ultraviolet = $_GET["ultraviolet"];
$precipitation = $_GET["precipitation"];
$luminosity = $_GET["luminosity"];
$carbonmonoxide = $_GET["carbonmonoxide"];


$query = "INSERT INTO arduino (temperature, humidity, ultraviolet, precipitation, luminosity, carbonmonoxide) VALUES ('$temperature', '$humidity', '$ultraviolet', '$precipitation', '$luminosity', '$carbonmonoxide')";
$result = mysqli_query($connect,$query);

echo "Insertion Success!<br>";

?>
</body>
</html>
