<?php

class DBCon
{
    private $con;
    
    public function __construct()
    {
        $config = parse_ini_file("config.ini", TRUE);

        $this->con = new mysqli($config["database"]["host"], $config["database"]["username"], $config["database"]["passwd"], $config["database"]["dbname"], $config["database"]["port"]);

        if ($this->con->connect_errno) {
            throw new Exception("Error conexión a la BBDD", 201901);
        }

        if (!$this->con->set_charset("utf8")) {
            throw new Exception("Error conexión a la BBDD", 201901);
        }
    }

    public function __destruct()
    {
        $this->con->close();
    }
}