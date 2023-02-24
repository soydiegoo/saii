-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 04-02-2023 a las 19:19:19
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `login_test`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_usuario` (IN `_nombre` VARCHAR(255) CHARSET utf8, IN `_apellido_paterno` VARCHAR(255) CHARSET utf8, IN `_apellido_materno` VARCHAR(255) CHARSET utf8, IN `_email` VARCHAR(255) CHARSET utf8, IN `_password` VARCHAR(255) CHARSET utf8, IN `_perfil` VARCHAR(255) CHARSET utf8)   BEGIN

DECLARE _perfilId INT;
DECLARE _usuarioId INT;

DECLARE EXIT HANDLER FOR SQLEXCEPTION

    BEGIN
        SELECT 1 AS error, "Ha ocurrido un error en el sistema." AS msg;
        ROLLBACK;
    END;
 
	START TRANSACTION;
 
	SELECT id_perfil INTO _perfilId FROM tbl_perfil WHERE nombre = _perfil;

	INSERT INTO tbl_usuarios (nombre, apellido_paterno, apellido_materno, email, password, perfil) VALUES (_nombre, _apellido_paterno, _apellido_materno, _email, md5(_password), _perfilId);

    SET _usuarioId = LAST_INSERT_ID();
    
    INSERT INTO usuario_perfil (id_usuario, id_perfil) VALUES (_usuarioId, _perfilId);
    
    INSERT INTO tbl_bitacora (id_usuario, nombre, apellido_paterno, apellido_materno) VALUES (_usuarioId, _nombre, _apellido_paterno, _apellido_materno);
    
     SELECT 0 AS error, "Operación realizada con éxito." AS msg;
     
     COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sele` ()   BEGIN

DECLARE EXIT HANDLER FOR SQLEXCEPTION

    BEGIN
        SELECT true AS error, "Ha ocurrido un error en el sistema. " AS msg;
        ROLLBACK;
    END;
 
	START TRANSACTION;
 
	SELECT * FROM tbl_usuarios;

     SELECT false AS error, "Operación realizada con éxito." AS msg;
     
     COMMIT;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `perfil_recursos`
--

CREATE TABLE `perfil_recursos` (
  `id_recurso` int(11) NOT NULL,
  `id_perfil` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `perfil_recursos`
--

INSERT INTO `perfil_recursos` (`id_recurso`, `id_perfil`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(5, 2),
(6, 3),
(7, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_bitacora`
--

CREATE TABLE `tbl_bitacora` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `apellido_paterno` varchar(255) NOT NULL,
  `apellido_materno` varchar(255) NOT NULL,
  `fecha_actualizacion` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_bitacora`
--

INSERT INTO `tbl_bitacora` (`id_usuario`, `nombre`, `apellido_paterno`, `apellido_materno`, `fecha_actualizacion`) VALUES
(2, 'Roberto Carlos', 'Navarro', 'Rodríguez', '2022-10-21'),
(5, 'Karen', 'Navarro', 'Rodriguez', '2022-10-22'),
(19, 'Alejandra Guadalupe', 'Granados', 'Navarro', '2022-10-28'),
(20, 'Ana Paulina', 'Granados', 'Navarro', '2022-10-28'),
(22, 'Hugo Alberto', 'Navarro', 'Rodriguez', '2022-11-18'),
(24, 'Angel', 'Zada', 'Patero', '2022-11-19'),
(25, 'Edwin', 'Reyes', 'Morales', '2022-11-19'),
(26, 'Jaime', 'Labrada', 'Arteaga', '2022-11-19'),
(27, 'Salomon', 'Navarro', 'Murillo', '2022-12-08'),
(31, 'Francisco Javier', 'Granados', 'Hernandez', '2022-12-08'),
(33, 'Fortino', 'Buustamante', 'Villafuerte', '2022-12-10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_perfil`
--

CREATE TABLE `tbl_perfil` (
  `id_perfil` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_perfil`
--

INSERT INTO `tbl_perfil` (`id_perfil`, `nombre`) VALUES
(1, 'ADMIN'),
(2, 'MAESTRO'),
(3, 'ALUMNO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_recursos`
--

CREATE TABLE `tbl_recursos` (
  `id_recurso` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `pagina` varchar(100) NOT NULL,
  `icono` varchar(100) NOT NULL,
  `orden` int(11) NOT NULL,
  `activo` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_recursos`
--

INSERT INTO `tbl_recursos` (`id_recurso`, `nombre`, `pagina`, `icono`, `orden`, `activo`) VALUES
(1, 'Maestros', 'crud_maestros.html', 'mdi-human-male-board', 1, 1),
(2, 'Alumnos', 'crud_alumnos.html', 'mdi-account-school', 2, 1),
(3, 'Materias', 'crud_materias.html', 'mdi-book-education', 3, 1),
(4, 'Calificaciones', 'calificaciones.html', 'mdi-book', 1, 1),
(5, 'Horarios', 'horarios_maestros.html', 'mdi-clock', 2, 1),
(6, 'Calificaciones', 'calificaciones_alumno.html', 'mdi-book', 1, 1),
(7, 'Horarios', 'horarios_alumno.html', 'mdi-clock', 2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_usuarios`
--

CREATE TABLE `tbl_usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido_paterno` varchar(255) NOT NULL,
  `apellido_materno` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(45) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `perfil` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_usuarios`
--

INSERT INTO `tbl_usuarios` (`id_usuario`, `nombre`, `apellido_paterno`, `apellido_materno`, `email`, `password`, `activo`, `perfil`) VALUES
(2, 'Roberto Carlos', 'Navarro', 'Rodríguez', 'robcocps77@gmail.com', 'd346852c660bc38f2d8639e7f530a320', 1, 3),
(5, 'Karen', 'Navarro', 'Rodriguez', 'robbobnavarro11@gmail.com', '9f80f70e627ea6b87cea100407d83962', 1, 3),
(19, 'Alejandra Guadalupe', 'Granados', 'Navarro', 'alejandra123@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', 1, 3),
(20, 'Ana Paulina', 'Granados', 'Navarro', 'anapau123@gmail.com', '9f80f70e627ea6b87cea100407d83962', 1, 3),
(22, 'Hugo Alberto', 'Navarro', 'Rodriguez', 'ellingopelon2@gmail.com', 'ffd1a0a5858d5a4e3178c11db53c49a9', 1, 2),
(24, 'Angel', 'Zada', 'Patero', 'angel123@gmail.com', '8275f1e052d8d847384a736ccfb07b4b', 1, 3),
(25, 'Edwin', 'Reyes', 'Morales', 'edwin123@gmail.com', 'dccd397d963acca03d47145cfb2a1d9b', 1, 3),
(26, 'Jaime', 'Labrada', 'Arteaga', 'jaime123@gmail.com', '8d1b07bd13acf84614662e4bcf781c22', 1, 3),
(27, 'Salomon', 'Navarro', 'Murillo', 'robbobdev@outlook.es', '8ebffa898357c383e1f8183687ad22e6', 1, 1),
(30, 'Ramon', 'Robles', 'Camarena', 'paco321@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', 0, 2),
(31, 'Francisco Javier', 'Granados', 'Hernandez', 'saulrikolino2@gmail.com', '944cc23adab7feb7d1ffa9818afa6a44', 1, 2),
(33, 'Fortino', 'Buustamante', 'Villafuerte', 'm.fortino.bustamante@itses.edu.mx', '2933ae31d64c704c1d6f74cd2b39b6f5', 1, 1),
(36, 'Paco', 'Robles', 'Camargo', 'paco123@gmail.com', 'f39cb2fa4dabbe4827d4b9f60e279262', 1, 1),
(39, 'hola_2', 'body_test_2', 'lopez', 'test_curl@gmail.com', '25d55ad283aa400af464c76d713c07ad', 1, 1),
(40, 'El Freddy', 'perez_2', 'govea', 'test_curl_2_2@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', 0, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_perfil`
--

CREATE TABLE `usuario_perfil` (
  `id_usuario` int(11) NOT NULL,
  `id_perfil` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuario_perfil`
--

INSERT INTO `usuario_perfil` (`id_usuario`, `id_perfil`) VALUES
(2, 3),
(5, 3),
(19, 3),
(20, 3),
(22, 2),
(24, 3),
(25, 3),
(26, 3),
(27, 1),
(31, 2),
(33, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `perfil_recursos`
--
ALTER TABLE `perfil_recursos`
  ADD KEY `id_perfil` (`id_perfil`),
  ADD KEY `id_recurso` (`id_recurso`);

--
-- Indices de la tabla `tbl_perfil`
--
ALTER TABLE `tbl_perfil`
  ADD PRIMARY KEY (`id_perfil`);

--
-- Indices de la tabla `tbl_recursos`
--
ALTER TABLE `tbl_recursos`
  ADD PRIMARY KEY (`id_recurso`);

--
-- Indices de la tabla `tbl_usuarios`
--
ALTER TABLE `tbl_usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `nombre` (`nombre`,`apellido_paterno`,`apellido_materno`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `perfil` (`perfil`);

--
-- Indices de la tabla `usuario_perfil`
--
ALTER TABLE `usuario_perfil`
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_perfil` (`id_perfil`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tbl_perfil`
--
ALTER TABLE `tbl_perfil`
  MODIFY `id_perfil` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tbl_recursos`
--
ALTER TABLE `tbl_recursos`
  MODIFY `id_recurso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `tbl_usuarios`
--
ALTER TABLE `tbl_usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `perfil_recursos`
--
ALTER TABLE `perfil_recursos`
  ADD CONSTRAINT `perfil_recursos_ibfk_1` FOREIGN KEY (`id_perfil`) REFERENCES `tbl_perfil` (`id_perfil`),
  ADD CONSTRAINT `perfil_recursos_ibfk_2` FOREIGN KEY (`id_recurso`) REFERENCES `tbl_recursos` (`id_recurso`);

--
-- Filtros para la tabla `tbl_usuarios`
--
ALTER TABLE `tbl_usuarios`
  ADD CONSTRAINT `tbl_usuarios_ibfk_1` FOREIGN KEY (`perfil`) REFERENCES `tbl_perfil` (`id_perfil`);

--
-- Filtros para la tabla `usuario_perfil`
--
ALTER TABLE `usuario_perfil`
  ADD CONSTRAINT `usuario_perfil_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_usuarios` (`id_usuario`),
  ADD CONSTRAINT `usuario_perfil_ibfk_2` FOREIGN KEY (`id_perfil`) REFERENCES `tbl_perfil` (`id_perfil`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
