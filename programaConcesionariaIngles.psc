Proceso Principal	
	Definir option Como Entero;
	Escribir "Welcome to Fast & Will!";
	Escribir "Choise your languaje";
	Escribir "0: Español";
	escribir "1: English";
	Escribir Sin Saltar 'Opción/Option : '; 
	leer option;
	Segun option Hacer
		0:
			espaniol();
		1:
			english();
		De Otro Modo: 
			escribir "Invalid option!";
	FinSegun
	
FinProceso


SubProceso  english
	definir auto, empleado, repuestos, cliente, venta, planesDePago como cadena;
	definir option como entero;
	dimension auto[100,8], empleado[100,7], repuestos[100,6];
	dimension cliente[100,2],venta[100,6],planesDePago[100,3];
	
	
	//Llena con ceros todas la matrices 
	preChargeCar(auto);
	preChargeEmployee(empleado);
	preChargeSpares(repuestos);
	preChargePaymentPlan(planesDePago);
	preSetSales(venta);
	preChargeCustomers(cliente);
	
	//Carga con datos de ejemplo las matrices 
	cargaMatrizAuto(auto);
	cargaMatrizEmpleado(empleado);
	cargaMatrizRepuestos(repuestos);
	cargaMatrizPlanesDePago(planesDePago);
	cargaClientes(cliente);
	cargaVentas(venta);
	
	
	//Programa principal____________________________________________________________________________________________________________________
	Repetir
		Limpiar Pantalla;
		baner();
		escribir " ";
		escribir "                    Welcome to Fast & will - Dealership management software";
		escribir "*****************************************************************************************************";
		Escribir '';
		escribir "Choose an option to work: ";
		Escribir '------------------------------';
		escribir "Option 0: Seals";
		escribir "Option 1: Search";
		escribir "Option 2: Rental services";
		escribir "Option 3: Load data";
		escribir "Option 4: Shopping";
		escribir "Option 5: Exit";
		Escribir '';
		Escribir Sin Saltar 'Choose an option: '; 
		leer option;
		Segun option Hacer
			0:
				realizarVenta(cliente,auto,empleado,venta,planesDePago, repuestos);
			1:
				menuBusqueda(empleado, auto, cliente, repuestos, venta, planesDePago);
			2:
				realizarServiciosAlquiler(cliente, auto, empleado);
			3:
				menuCargaDeDatos(auto,empleado,repuestos,cliente,planesDePago);
			4:
				realizarCompra(cliente,auto);
			5:	
			De Otro Modo: 
				escribir "Invalid choise!";
		FinSegun
	Hasta Que option = 5;
	escribir "Thanks for using our software, come back soon.";
FinSubProceso


//SubProcesos ____________________________________________________________________________________________________________________

subproceso realizarVenta(cliente,auto,empleado,venta,planesDePago, repuesto) //0
	definir option, i como entero;
	Repetir
		Limpiar Pantalla;
		Escribir '         SALES OPTIONS';
		Escribir '___________________________________';
		escribir "0-Vehicles by brand.";
		escribir "1-Payment plans.";
		escribir "2-Car sale.";
		escribir "3-Sale Spare.";
		escribir "4-Exit.";
		leer option;
		Segun option Hacer
			0:
				vehiculoPorMarca(auto);
			1:
				planesPago(planesDePago);
				Esperar Tecla;
			2: 
				concretarVenta(cliente,auto,empleado,venta,planesDePago); 
			3:
				ventaRepuesto(repuesto, cliente, empleado);
			4:
			De Otro Modo:
				escribir "Invalid data, Please try again.";
		FinSegun
		Hasta Que	option = 4;
		limpiar pantalla;
FinSubProceso

subproceso realizarVenta(cliente,auto,empleado,venta,planesDePago, repuesto) //0
	definir option, i como entero;
	Repetir
		Limpiar Pantalla;
		Escribir '         SALES OPTIONS';
		Escribir '___________________________________';
		escribir "0-Vehicle by brand.";
		escribir "1-Payment plans.";
		escribir "2-Auto Sales.";
		escribir "3-Sale Spare Parts.";
		escribir "4-Exit.";
		leer option;
		Segun option Hacer
			0:
				vehiculoPorMarca(auto);
			1:
				planesPago(planesDePago);
				Esperar Tecla;
			2: 
				concretarVenta(cliente,auto,empleado,venta,planesDePago); 
			3:
				ventaRepuesto(repuesto, cliente, empleado);
			4:
			De Otro Modo:
				escribir "Invalid data, please try again.";
		FinSegun
		Hasta Que	option = 4;
		limpiar pantalla;
FinSubProceso


subproceso menuBusqueda(empleado, auto, cliente, repuesto, venta, planes) //1
	definir option como entero;
	
	Repetir
		Limpiar Pantalla;
		Escribir '       PERFORM A SEARCH';
		Escribir '____________________________________';
		escribir "0-Vehicles";
		escribir "1-Employees.";
		escribir "2-Spare parts .";
		escribir "3-Customer";
		Escribir "4-Sales";
		escribir "5-Exit";
		leer option;
		Segun option Hacer
			0:
				menuVehiculos(auto);
			1:
				menuBusquedaEmpleados(empleado);
			2:
				menuRepuestos(repuesto);
			3:
				busquedaCliente(cliente);
			4:
				menuVentas(venta, planes, empleado);
			5:
			De Otro Modo:
				escribir "Invalid data, please try again.";
		FinSegun
		
	Hasta Que option = 5;
	limpiar pantalla;
FinSubProceso


subproceso realizarServiciosAlquiler(cliente, auto, empleado)
	
	Definir dniCliente, idAuto, precioHora, numLegajo, fechaActual,rta,autoDisponible como cadena;
	Definir indiceCliente, indiceAuto, indiceEmpleado Como Entero;
	Definir existeCliente Como Logico;
	
	//Bandera que controla la existencia del cliente en la matriz
	existeCliente <- falso;
	Limpiar Pantalla;
	
	//Ingresamos los datos de un cliente existenete o uno nuevo
	Repetir
		Escribir '_____________________________________________________________________';
		escribir "Enter the customer´s ID number: ";
		leer dniCliente;     
		indiceCliente <- busquedaPorId(cliente,dniCliente);
		si indiceCliente <> -1 entonces
			existeCliente <- verdadero;
			Escribir 'Customer found with id: ', dniCliente;
		FinSi
	Hasta Que indiceCliente = -1 o existeCliente;
	
	// Sino encuentra al cliente ingresado, Cargamos un nuevo cliente..
	si no existeCliente entonces
		Escribir '_____________________________________________________________________';
		escribir "Customer not found ";
		//Llamamis a l subproceso que carga un nuevo cliente
		cargarNuevoCliente(dniCliente,cliente);
		//obtenemos la posicion que ocupa este nuevo cliente en la matriz: para recuperar el nombre y apellido
		indiceCliente <- busquedaPorId(cliente,dniCliente);
	FinSi
	
	
	// Seleccionamos el auto a alquilar
	Escribir '_____________________________________________________________________';
	escribir sin saltar "Enter the car id: ";
	leer idAuto;   
	
	//Bandera que controla si el auto solicitado esta disponible
	autoDisponible <- 'true';
	//Obtenemos la posicion que ocupa en la matrize el auto solicitado 
	indiceAuto <- busquedaPorId(auto, idAuto);
	
	si indiceAuto <> -1 Entonces
		autoDisponible <- auto[indiceAuto, 7];
	FinSi
	
	rta  <- '1';
	
	Mientras indiceAuto = -1 o (autoDisponible = 'false' y rta = '1') Hacer
		Si autoDisponible = 'false' y indiceAuto <> -1 Entonces
			Escribir 'Auto not available';
		FinSI
		sI indiceAuto = -1  o rta = '1' Entonces
			Escribir Sin Saltar 'Please try again. Enter the car id: ';
			leer idAuto;
			indiceAuto <- busquedaPorId(auto, idAuto);
			si indiceAuto <> -1 Entonces
				autoDisponible <- auto[indiceAuto, 7];
			FinSi
		FinSi
		Repetir
			Escribir '¿Wants to find another car?';
			Escribir '1. Yes';
			Escribir '2. No';
			Escribir sin saltar 'Enter option: ';
			Leer rta;
		Hasta Que rta = '1' o rta = '2'
	FinMientras
	
	//	Cargamos El vendedor
	
	
	Escribir '_____________________________________________________________________';
	escribir sin saltar "Enter your file number : ";
	leer numLegajo;
	//Obtenemos la posicion que ocupa el empleado en la matriz, si no lo encuentra retorna -1.
	indiceEmpleado <- busquedaPorId(empleado, numLegajo);
	Mientras indiceEmpleado = -1 Hacer
		Escribir 'Employee not found. Please try again.';
		escribir sin saltar "Enter your file number: ";
		leer numLegajo;   
		indiceEmpleado <- busquedaPorId(empleado,numLegajo);
	FinMientras
	
	
	//	Fecha Actual
	Escribir '_____________________________________________________________________';
	escribir sin saltar "Enter current date: ";
	leer fechaActual;
	
	//Obtenemos el precio por hora del auto solicitado
	precioHora <- auto[indiceAuto, 6];
	
	
	//Cambio el estado del auto a false / no disponible
	auto[indiceAuto,7] <- 'false'; 
	
	
	barra('Alquiler');
	
	
	Escribir '_____________________________________________________________________';
	Escribir '| Salesperson |  Auto Id |    ID CARD   | Hourly Rate |  Withdrawal Date  | ';
	Escribir '_____________________________________________________________________';
	Escribir '|    ', numLegajo , '   |  ', idAuto , '   |  ', dniCliente ,' |      $', precioHora , '       |   ', fechaActual, '   |';  
	Escribir '_____________________________________________________________________';
	
	
	Esperar Tecla;
	
	
FinSubProceso

subproceso menuCargaDeDatos(auto,empleado,repuestos,cliente,planesDePago) //3
	Definir option como entero;
	Definir dni como cadena; 
	Repetir 
		Limpiar Pantalla;
		Escribir '      CARRY OUT LOADING';
		Escribir '_______________________________';
		escribir "1- Employees.";
		escribir "2- Spare parts.";
		escribir "3- New Customer.";
		escribir "4- Load new payment plan.";
		escribir "5- Load Auto";
		escribir "6- Exit.";
		leer option;
		Segun option Hacer
			0:
				cargaAuto(auto); 
			1:
				cargaEmpleados(empleado); 
			2:
				cargaRepuestos(repuestos); 
			3:
				cargaCliente(cliente); 
			4: 
				cargarNuevoPlan(planesDePago); 
			5:	
				cargaAuto(auto);
			6:
			De Otro Modo:
				escribir "Invalid data, please try again.";
		FinSegun
	Hasta Que option = 6;
FinSubProceso


subproceso realizarCompra(cliente, auto) //4
	//Para realizar una compra necesitamos un cliente/proveedor al que le vamos a comprar
	//y la informacion del auto que compramos 
	definir ok como cadena;
	//Cargamos el cliente, si existe tomamos sus datos
	cargaCliente(cliente);
	//Cargamos un nuevo auto
	cargaAuto(auto);
	escribir "Purchase successfully registered.";
	leer ok;
FinSubProceso


Subproceso vehiculoPorMarca(auto)
	
	Definir marca, marcaAuto,resultados como cadena;
	Definir i,j , contador, indice Como Entero;
	
	Dimension resultados[100, 8];
	preChargeCar(resultados);
	contador <- 0;
	
	Limpiar Pantalla;
	
	Escribir Sin Saltar'Enter brand to search: ';
	Leer marca;
	marca <- Minusculas(marca);
	
	Para i<-0 Hasta 99 Hacer
		
		marcaAuto <- auto[i,2];
		marcaAuto <- Minusculas(marcaAuto);
		
		si auto[i,2] <> '0' y marcaAuto = marca Entonces
			
			Para j <- 0 Hasta 7 Hacer
				resultados[contador, j] <- auto[i,j];
			FinPara
			contador <- contador + 1;
		FinSi
		
	FinPara
	Si contador <> 0 Entonces
		Limpiar Pantalla;
		Escribir 'Results found: ', contador, '.';
		Escribir '-----------------------------------------------------------------------------------------';
		mostrarAutos(resultados);
	SiNo
		Escribir 'No results were found with brand: ' , marca;
	FinSi
	
	Leer marca;
	
FinSubProceso


subproceso planesPago(planesDePago)
	Limpiar Pantalla;
	mostrarPlanesDePago(planesDePago);
FinSubProceso

subproceso concretarVenta(cliente, auto, empleado, venta, planesDePago)
	
	// Para realizar una venta necesitamos:
	
	// Numero de DNI del cliente, tambien su nombre y apellido
	// Id del Auto a vender
	// Numero de legajo del vendedor
	// Fecha actual
	// Identificador del plan de pago, si es necesario.
	
	// Finalmente con todos los datos guardamos la venta en la matriz
	
	
	definir dniCliente, numLegajo, idAuto, fechaActual, rtaPlan, rtaConfirmacion, planId, estadoAuto,dni como cadena;
	definir indiceCliente, indiceAuto, indiceEmpleado, ultimaVenta, planPago como entero;
	
	
	//Banderas
	definir existeCliente, autoDisponible como logica;
	
	Limpiar Pantalla;
	
	existeCliente <- falso;
	
	//cargamos cliente
	Repetir
		Escribir '_____________________________________________';
		escribir "Enter the customer´s ID number: ";
		leer dniCliente;     
		indiceCliente <- busquedaPorId(cliente,dniCliente);
		si indiceCliente <> -1 entonces
			existeCliente <- verdadero;
			Escribir 'Customer found with id: ', dniCliente;
		FinSi
	Hasta Que indiceCliente = -1 o existeCliente;
	
	// Sino encuentra al cliente ingresado, Cargamos un nuevo cliente..
	si no existeCliente entonces
		Escribir '_____________________________________________';
		escribir "Customer not found ";
		cargarNuevoCliente(dniCliente,cliente);
		indiceCliente <- busquedaPorId(cliente,dniCliente);
	FinSi
	
	//cargamos el auto
	Escribir '_____________________________________________';
	escribir sin saltar "Enter the car´s id: ";
	leer idAuto;     
	indiceAuto <- busquedaPorId(auto, idAuto);
	autoDisponible <- falso;
	Mientras indiceAuto = -1 o no(autoDisponible) Hacer
		sI indiceAuto = -1 Entonces
			Escribir 'Auto not found. Please try again.';
			escribir sin saltar "Enter the car´s id: ";
			leer idAuto;
			indiceAuto <- busquedaPorId(auto, idAuto);
		FinSi
		sI indiceAuto <> -1 Entonces
			estadoAuto <- auto[indiceAuto,7];
			// Un estado igual a 'false' quiere decir que el auto se vendio o esta alquilado
			si estadoAuto = 'false' Entonces
				Escribir  Sin Saltar'The car is not available. Enter Other.';
				leer idAuto;  
				indiceAuto <- busquedaPorId(auto, idAuto);
			SiNo
				autoDisponible <- Verdadero;
			FinSi
		FinSi
	FinMientras
	
	//cargamos legajo de vendedor
	Escribir '_____________________________________________';
	escribir sin saltar "Enter your file number: ";
	leer numLegajo;     
	indiceEmpleado <- busquedaPorId(empleado, numLegajo);
	Mientras indiceEmpleado = -1 Hacer
		Escribir 'Employee not found. Please try again.';
		escribir sin saltar "Enter your file number: ";
		leer numLegajo;   
		indiceEmpleado <- busquedaPorId(empleado,numLegajo);
	FinMientras
	
	Escribir '_____________________________________________';
	escribir sin saltar "Enter current date: ";
	leer fechaActual;
	Escribir '_____________________________________________';
	
	// Plan de Pago
	
	rtaPlan <- '0';
	Repetir
		Escribir '¿Do you want to include a payment plan? yes/no';
		Escribir '1 . Yes';
		Escribir '2 . No';
		Leer rtaPlan;
		rtaPlan <- Minusculas(rtaPlan);
	Hasta Que rtaPlan = '1' o rtaPlan = '0'
	
	planId<-'0';
	Si rtaPlan = '1' Entonces
		planPago <- incluirPlan(planesDePago);
		planId <- planesDePago[planPago,0];
	FinSi
	Escribir '---------------------------------------';
	Escribir '¿Confirm the Sale?';
	Escribir  '1. Yes';
	Escribir  '2. No';
	Leer rtaConfirmacion;
	
	Si rtaConfirmacion = '1' Entonces
		// Buscamos el inidice posterior a la ultima venta realizada para poder ingresar la nueva venta.
		ultimaVenta <- obtenerUltimoIndice(venta);
		Si no (ultimaVenta = -1) Entonces
			// Guardamos la venta: N° Legajo, Dni, Nombre y Apellido, fecha,  Id (Auto), planPago.
			cargarVenta(auto, venta,cliente,ultimaVenta, numLegajo,dniCliente, indiceCliente,fechaActual,indiceAuto, planId);
			Escribir '_____________________________________________';
			Escribir 'Successful sale.... ';
			mostrarVentaporId(venta, cliente, planesDePago, ultimaVenta);
		SiNo
			Escribir 'The sale could not be completed, the Sale array is full.';
		FinSi
		
	SiNo
		Escribir 'Sale cancelled. Press any key to exit ... ';
		Leer rtaConfirmacion;
	FinSi
FinSubProceso

SubProceso ventaRepuesto(repuesto, cliente, empleado)
	
	Limpiar Pantalla;
	definir dniCliente, numLegajo, fechaActual, dni, IdRepuesto, stock, nombreYapellido como cadena;
	definir indiceCliente, indiceEmpleado, indiceRepuesto, cantidadRepuesto, stockNumero como entero;
	Definir precioUnitario, total Como Real;
	Definir existeRepuesto, existeCliente como logico;
	
	existeCliente <- falso;
	
	//cargamos cliente
	
	Escribir '';
	Escribir '       SPARE PARTS SALES:';
	Escribir '';
	Escribir '';
	
	
	Repetir
		Escribir '_____________________________________________';
		escribir  Sin Saltar"Enter the customer´s ID number: ";
		leer dniCliente;     
		indiceCliente <- busquedaPorId(cliente,dniCliente);
		si indiceCliente <> -1 entonces
			existeCliente <- verdadero;
			Escribir 'Customer found with id: ', dniCliente;
		FinSi
	Hasta Que indiceCliente = -1 o existeCliente;
	
	// Sino encuentra al cliente ingresado, Cargamos un nuevo cliente..
	si no existeCliente entonces
		Escribir '_____________________________________________';
		escribir "Customer not found ";
		cargarNuevoCliente(dniCliente,cliente);
		indiceCliente <- busquedaPorId(cliente,dniCliente);
	FinSi
	
	nombreYapellido <- cliente[indiceCliente, 1];
	
	
	//elegir repuesto 
	Escribir '_____________________________________________';
	Escribir Sin Saltar'Enter Spare part Id: ';
	leer IdRepuesto;  
	
	indiceRepuesto <- busquedaPorId(repuesto, IdRepuesto);
	
	Mientras indiceRepuesto = -1 Hacer
		Escribir 'Spare part not found. Please try again.';
		escribir sin saltar "Enter Spare part Id: ";
		leer IdRepuesto;   
		indiceRepuesto <- busquedaPorId(repuesto,IdRepuesto);
	FinMientras
	
	mostrarRepuestoPorId(repuesto,IdRepuesto);
	
	//Ingresmos cantidad repuesto..
	
	Escribir Sin Saltar'Enter spare parts units: '; 
	Leer cantidadRepuesto; 
	
	stock <- repuesto[indiceRepuesto, 5]; 
	stockNumero <- ConvertirANumero(stock); 
	stockNumero <- stockNumero - cantidadRepuesto;
	
	precioUnitario <- ConvertirANumero(repuesto[indiceRepuesto, 4]);
	
	Si stockNumero < 0 Entonces
		Escribir 'No stock.';
		Escribir 'Current stock: ', repuesto[indiceRepuesto, 5]; 
	FinSi
	Mientras stockNumero < 0 Hacer
		Escribir 'Enter spare parts units: '; 
		Leer cantidadRepuesto;   
		stockNumero <- stockNumero - cantidadRepuesto; 
	FinMientras
	
	repuesto[indiceRepuesto, 5] <- ConvertirATexto(stockNumero); 
	Escribir 'Remaining stock: ', repuesto[indiceRepuesto, 5]; 
	
	
	
    //Leer cantidadRepuesto;
	
	//Cargamos legajo de vendedor
	
	Escribir '_____________________________________________';
	escribir sin saltar "Enter your file number: ";
	leer numLegajo;     
	indiceEmpleado <- busquedaPorId(empleado, numLegajo);
	Mientras indiceEmpleado = -1 Hacer
		Escribir 'Employee not found. Please try again.';
		escribir sin saltar "Enter your file number: ";
		leer numLegajo;   
		indiceEmpleado <- busquedaPorId(empleado,numLegajo);
	FinMientras
	
	Escribir '_____________________________________________';
	escribir sin saltar "Enter current date: ";
	leer fechaActual;
	
	total <- precioUnitario * cantidadRepuesto;
	
	Escribir '______________________________________________________________________________________________________________________';
	
	Escribir ' | Num File |     ID CARD    | First and last name |  Id Spare part  | Unit Price | Amount |     Date     |  Total  |';
	Escribir '_______________________________________________________________________________________________________________________';
	Escribir '|     ', numLegajo , '     |  ', dniCliente, '  |   ', nombreYapellido, '    |   ' ,IdRepuesto , '   |      $',precioUnitario, '      |     ', cantidadRepuesto, '    |   ', fechaActual, '  |  $', total, '  |' ;
	Escribir '_______________________________________________________________________________________________________________________';
	Leer numLegajo;
	
FinSubProceso

// Funciones Comunes___________________________________________________________________________________

SubProceso posicionId <- busquedaPorId(matriz, id)  //Busca por la columna 0
	definir i, posicionId como entero;
	definir idEncontrado Como Logico;
	i<-0;
	idEncontrado<-falso;
	Mientras i<=99 y no(idEncontrado) Hacer
		Si no(matriz[i,0] = "0") y (matriz[i,0] = id) Entonces
			posicionId <- i;
			idEncontrado<-Verdadero;
		FinSi
		i<-i+1;
	FinMientras
	Si no idEncontrado Entonces
		posicionId <- -1;
	FinSi
FinSubProceso

subproceso indice <- obtenerUltimoIndice(matriz)
	definir i,indice como entero;
	definir matrizLlena Como Logico;
	matrizLlena <- Verdadero;
	Para i<-0 Hasta 99 Hacer
		Si (matriz[i,0] = '0') Entonces
			indice <- i;
			matrizLlena <- Falso;
		FinSi
	FinPara
	Si matrizLlena Entonces
		indice <- -1;
	FinSi
FinSubProceso
// ___________________________________________________________________________________________________


SubProceso posicionPlan <- incluirPlan(planesDePago)
	Definir posicionPlan Como Entero;
	Definir idPlan como Cadena;
	
	mostrarPlanesDePago(planesDePago);
	
	Escribir Sin Saltar'Enter Payment Plan: ';
	Leer idPlan;
	posicionPlan <- busquedaPorId(planesDePago, idPlan);
	Mientras posicionPlan = -1 Hacer
		Escribir '____________________________________________'; 
		Escribir 'Plan not found.try again. ';
		Escribir Sin Saltar'Enter Payment Plan: ';
		Leer idPlan;
		posicionPlan <- busquedaPorId(planesDePago, idPlan);
	FinMientras
	
	Escribir 'Plan found with id: ', idPlan;
	Escribir 'Plan description, Delivery: ', planesDePago[posicionPlan,1], ' , Dues: ',planesDePago[posicionPlan,2]; 
FinSubProceso

subproceso menuBusquedaEmpleados(empleado)
	definir option como entero;
	Limpiar Pantalla;
	Escribir '           SEARCH EMPLOYEES';
	Escribir '_______________________________________';
	Repetir 
		escribir "0-Show all employees.";
		escribir "1-Search for employees by file number.";
		escribir "2-Exit.";
		leer option;
		Segun option Hacer
			0:
				mostrarAllempleados(empleado);
			1:
				buscarEmpleadosLegajo(empleado);
			2:
				
			De Otro Modo:
				escribir "Invalid data, please try again.";
		FinSegun
	Hasta Que option = 2;
	limpiar pantalla;
FinSubProceso

// Busqueda por Id ___________________________________________________________________________________________________

subproceso buscarRepuestoId(repuestos)
	definir idRepuesto como cadena;
	definir posicion como entero;
	Limpiar Pantalla;
	escribir "Enter the spare part id you wish to search for.";
	leer idRepuesto;
	posicion <- busquedaPorId(repuestos,idRepuesto );
	Escribir '__________________________________________________________________________';
	escribir '| Spare part ID | Category |     Brand     |   Model | Price | Stock |';
	Escribir '__________________________________________________________________________';
	si posicion <> -1 entonces 
		escribir '|   ',repuestos[posicion,0], '    |    ', repuestos[posicion,1] ,'   |      ',repuestos[posicion,2],'     |   ',repuestos[posicion,3],'  |  ',repuestos[posicion,4], '  |   ',repuestos[posicion,5],'  | ';
	SiNo
		Escribir 'Spare part not found';
	FinSi
	leer posicion;
FinSubProceso

SubProceso buscarVehiculoPorId(auto)
	definir idVehiculo como cadena;
	definir posicion como entero;
	Limpiar Pantalla;
	escribir "Enter the id of the vehicle you wish to search for.";
	leer idVehiculo;
	posicion <- busquedaPorId(auto,idVehiculo );
	Escribir '---------------------------------------------------------------------------------------';
	Escribir '|   Id   |   Year  |  Brand  |  Model  |   Km   |  Price  | Rental Price | Status |'; 
	Escribir '---------------------------------------------------------------------------------------';
	si posicion <> -1 entonces 
		Escribir '|  ',auto[posicion,0], ' |  ',auto[posicion,1], '  |  ', auto[posicion,2], '  |   ', auto[posicion,3], '  |  ', auto[posicion,4], ' |  ', auto[posicion,5], ' |       $', auto[posicion,6], '      |  ' , auto[posicion,7],'  |' ; 
		Escribir '---------------------------------------------------------------------------------------';
	SiNo
		
		Escribir 'Vehicle not found';
		Escribir '---------------------------------------------------------------------------------------';
	FinSi
	leer posicion;
FinSubProceso

SubProceso buscarVentaPorVendedor(venta, empleado, planesDePago)
	
	Definir i, j, posPlan, posicion Como Entero;
	Definir idPlan, entrega, cuotas, idVendedor,  nombreVendedor, nombre, apellido como cadena;
	Limpiar Pantalla;
	
	Escribir sin saltar 'Enter Seller Id: ';
	Leer idVendedor;
	posicion <- busquedaPorId(empleado, idVendedor);
	
	nombre <- Concatenar(empleado[posicion,1], ' ');
	
	apellido <- empleado[posicion,3];
	
	nombreVendedor <- Concatenar(nombre,apellido);
	
	Si posicion <> -1 Entonces
		Escribir '_______________________________';
		Escribir '| File Number | Seller´s Name |';
		Escribir '-------------------------------';
		Escribir  '|    ', idVendedor,  '    |   ',  nombreVendedor, '  |';
		Escribir '-------------------------------';
		Escribir '_____________________________________________________________________________';
		Escribir '|    ID CARD   |  First and Last Name |     Date    | Id Auto | Delivery | Dues |';
		Para i<-0 Hasta 99 Hacer
			
			Si No(venta[i,0] = '0')  y venta[i, 0] = idVendedor Entonces
				idPlan <- venta[i,5];
				Si idPlan <> '0' Entonces
					posPlan <- busquedaPorId(planesDePago, idPlan);
					entrega <- planesDePago[posPlan, 1];
					cuotas <- planesDePago[posPlan, 2];
					Escribir '_____________________________________________________________________________';
					Escribir  '| ', venta[i,1] , ' |     ', venta[i,2] , '    |   ', venta[i,3], ' |  ', venta[i,4] , '  | ', entrega, '   |   ', cuotas, '   |';
				SiNo
					Escribir '_____________________________________________________________________________';
					Escribir  '| ', venta[i,1] , ' |   ', venta[i,2] , '      |  ', venta[i,3], ' |  ', venta[i,4] , '  | No Plan';
				FinSi
				
			FinSi
		FinPara
		Escribir '_____________________________________________________________________________';
	SiNo
		Escribir 'Seller not found';
	FinSi
	leer i;
	
FinSubProceso

subproceso buscarEmpleadosLegajo(empleado)
	definir numLegajo como cadena;
	definir posicion como entero;
	Limpiar Pantalla;
	escribir Sin Saltar"Enter the file number you wish to search for.";
	leer numlegajo;
	posicion <- busquedaPorId(empleado, numLegajo);
	Escribir '______________________________________________________________________________________';
	escribir "| File number | Name | Name 2 | Last name |    Address   | Age | Nationality |";
	Escribir '______________________________________________________________________________________';
	si posicion <> -1 entonces 
		Si empleado[posicion,2]  = '' Entonces
			escribir '|      ',empleado[posicion,0], '     |  ', empleado[posicion,1] ,' |  ------- |  ',empleado[posicion,3],'  | ',empleado[posicion,4], ' |  ',empleado[posicion,5],'  |   ',empleado[posicion,6], '  |';
		SiNo
			escribir '|      ',empleado[posicion,0], '     |  ', empleado[posicion,1] ,' |  ',empleado[posicion,2],'  | ',empleado[posicion,3],' | ',empleado[posicion,4], ' | ',empleado[posicion,5],' | ',empleado[posicion,6], ' |';
		FinSi
		Escribir '______________________________________________________________________________________';
	Sino
		Escribir 'Employee not found';
	FinSi
	Leer numlegajo;
FinSubProceso

SubProceso menuVehiculos(auto)
	definir option como entero;
	Repetir
		Limpiar Pantalla;
		Escribir '         SEARCH VEHICLE';
		Escribir '___________________________________';
		escribir "0-See available vehicles.";
		escribir "1-Search vehicle by id.";
		escribir "2-Exit.";
		leer option;
		Segun option Hacer
			0:
				vehiculosDisponibles(auto);
			1:
				buscarVehiculoPorId(auto);
			2:
				
			De Otro Modo:
				escribir "Invalid data, please try again.";
		FinSegun
		Hasta Que	option = 2;
		limpiar pantalla;
		
FinSubProceso

subproceso menuRepuestos(repuestos)
	definir option como entero;
	Repetir
		Limpiar Pantalla;
		Escribir '         SEARCH FOR SPARE PARTS';
		Escribir '___________________________________';
		escribir "0-See all the spare parts.";
		escribir "1-Search for spare parts by id.";
		escribir "2-Exit.";
		leer option;
		Segun option Hacer
			0:
				mostrarMatrizRepuestos(repuestos);
			1:
				buscarRepuestoId(repuestos); //LISTO
			2:
				
			De Otro Modo:
				escribir "Invalid data, please try again.";
		FinSegun
		Hasta Que	option = 2;
		limpiar pantalla;
FinSubProceso


SubProceso menuVentas(venta, planes, empleado)
	definir option como entero;
	Repetir
		Limpiar Pantalla;
		Escribir '         SEARCH FOR SALE';
		Escribir '___________________________________';
		escribir "0-See all sales.";
		escribir "1-Search for sale by seller.";
		escribir "2-Exit.";
		leer option;
		Segun option Hacer
			0:
				mostrarMatrizVentas(venta,planes);
			1:
				buscarVentaPorVendedor(venta, empleado, planes);
			2:
				
			De Otro Modo:
				escribir "Invalid data, please try again.";
		FinSegun
		Hasta Que	option = 2;
		limpiar pantalla;
FinSubProceso


subproceso busquedaCliente(cliente)
	
	definir idCliente como cadena;
	definir posicion como entero;
	
	Limpiar Pantalla;
	escribir "Enter the customer id you wish to search for.";
	leer idCliente;
	posicion <- busquedaPorId(cliente,idCliente );
	si posicion <> -1 entonces 
		Escribir "___________________________";
		Escribir "| ID CARD | First and Last Name |";
		Escribir "___________________________";
		Escribir '| ',cliente[posicion,0], ' |  ', cliente[posicion,1] ,' | ';
	SiNo
		Escribir 'Customer not found';
	FinSi
	leer posicion;
FinSubProceso

// Carga Individual___________________________________________________________________________________________________

subproceso cargaAuto(auto)
	definir id, year, marca,modelo, km,precio, precioHora como cadena;
	definir indice como entero;
	Limpiar Pantalla;
	Escribir '      New Car Registration';
	Escribir '________________________________';
	escribir sin saltar"Enter car id: ";
	leer id;
	escribir sin saltar"Enter year of manufacture: ";
	leer year;
	escribir sin saltar"Enter brand: ";
	leer marca;
	escribir sin saltar"Enter model: ";
	leer modelo;
	escribir sin saltar"Enter km: ";
	leer km;
	escribir sin saltar"Enter price: ";
	leer precio;
	escribir sin saltar"Enter hourly rental rate: ";
	leer precioHora;
	
	indice <- obtenerUltimoIndice(auto);
	auto[indice,0] <- id;
	auto[indice,1] <- year;
	auto[indice,2] <- marca;
	auto[indice,3] <- modelo;
	auto[indice,4] <- km;
	auto[indice,5] <- precio;
	auto[indice,6] <- precioHora;
	// Te ponemeos la disponibilidad a true / disponible 
	auto[indice,7] <- "true";
	escribir "A new car was added.";
	leer id;
FinSubProceso

subproceso  cargaCliente(cliente Por Referencia)
	definir j,i,indice,posicion como entero;
	definir nombreYapellido, dni como cadena;
	Limpiar Pantalla;
	escribir "Enter new customer´s ID: ";
	leer dni;
	posicion <- busquedaPorId(cliente, dni);
	Si posicion = -1  entonces
		indice <- obtenerUltimoIndice(cliente);
		escribir "Enter first and last name of new Customer: ";
		leer nombreYapellido;
		cliente[indice,0] <- dni;
		cliente[indice,1] <- nombreYapellido;
		mostrarClientePorId(cliente, dni);
	sino
		escribir "The customer already exists.";	
	FinSi
	
	leer dni;
FinSubProceso

subproceso cargarVenta(auto,venta,cliente, ultimaVenta, numLegajo,dniCliente,indiceCliente, fechaActual,indiceAuto, planPago)
	definir nombreYapellido, idAuto como cadena;
	//Cambiamnos el estado del auto vendido a 'false' -- Vendido
	auto[indiceAuto, 7] <- 'false';
	nombreYapellido <- cliente[indiceCliente,1];
	venta[ultimaVenta,0] <- numLegajo;
	venta[ultimaVenta,1] <- dniCliente;
	venta[ultimaVenta,2] <- nombreYapellido;
	venta[ultimaVenta,3] <- fechaActual;
	idAuto <- auto[indiceAuto,0];
	venta[ultimaVenta,4] <- idAuto;
	venta[ultimaVenta,5] <- planPago;
FinSubProceso

subproceso cargarNuevoCliente(dniCliente,cliente)
	definir j,i,indice como entero;
	definir nombreYapellido como cadena;
	Limpiar Pantalla;
	indice <- obtenerUltimoIndice(cliente);
	escribir "Enter first and last name of new Customer: ";
	leer nombreYapellido;
	cliente[indice,0] <- dniCliente;
	cliente[indice,1] <- nombreYapellido;
	mostrarClientePorId(cliente, dniCliente);
FinSubProceso

subproceso cargaEmpleados(empleado)
	definir indice como entero;
	limpiar pantalla;
	definir legajo,nombre,nombre2,apellido,direccion,edad,nacionalidad como cadena;
	Escribir '           LOAD EMPLOYEE';
	Escribir '___________________________________';
	escribir "Enter the file number: ";
	leer legajo;
	escribir "Enter the name: ";
	leer nombre;
	escribir "Enter the middle name: ";
	leer nombre2;
	escribir "Enter last name: ";
	leer apellido;
	escribir "Enter your address: ";
	leer direccion;
	escribir "Enter age: ";
	leer edad;
	escribir "Enter your nationality: ";
	leer nacionalidad;
	indice <- obtenerUltimoIndice(empleado);
	empleado[indice,0] <- legajo;
	empleado[indice,1] <- nombre;
	empleado[indice,2] <- nombre2;
	empleado[indice,3] <- apellido;
	empleado[indice,4] <- direccion;
	empleado[indice,5] <- edad;
	empleado[indice,6] <- nacionalidad;
	escribir "A new employee has been successfully uploaded.";
	leer legajo;
FinSubProceso

SubProceso cargaRepuestos(repuestos)
	Definir id, categoria, marca, modelo, precio, stock Como Cadena;
	Definir indice Como Entero;
	Limpiar Pantalla;
	Escribir Sin Saltar "Enter id: ";
	Leer id;
	Escribir Sin Saltar "Enter category: ";
	Leer categoria;
	Escribir Sin Saltar "Enter brand: ";
	Leer marca;
	Escribir Sin Saltar "Enter model: ";
	Leer modelo;
	Escribir Sin Saltar "Enter price: ";
	Leer precio;
	Escribir Sin Saltar "Enter stock: ";
	Leer stock;
	indice <- obtenerUltimoIndice(repuestos);
	repuestos[indice,0] <- id;
	repuestos[indice,1] <- categoria;
	repuestos[indice,2] <- marca;
	repuestos[indice,3] <- modelo;
	repuestos[indice,4] <- precio;
	repuestos[indice,5] <- stock;
	escribir "A new spare part has been successfully loaded.";
	leer id;
FinSubProceso

Subproceso cargarNuevoPlan(planesDePago)
	definir idPlan,entrega,cuotas como cadena;
	definir indice como entero;
	Limpiar Pantalla;
	Escribir '          LOAD NEW PLAN ';
	Escribir '_____________________________________';
	escribir sin saltar "Enter new plan id: ";
	leer idPlan;
	escribir sin saltar "Enter amount of delivery: $";
	leer entrega;
	escribir sin saltar "enter number of dues: ";
	leer cuotas;
	indice <- obtenerUltimoIndice(planesDePago);
	planesDePago[indice,0] <- idPlan;
	planesDePago[indice,1] <- entrega;
	planesDePago[indice,2] <- cuotas;
	escribir sin saltar "A new plan was successfully uploaded.";
	leer idPlan;
FinSubProceso

//Mostrar por ID___________________________________________________________________________________________________


SubProceso mostrarVentaporId(ventas, cliente, planesDePago, idVenta)
	
	Definir legajo , dni , nombreYapellido , fecha, IdAuto, infoPlan, idPlan, rta Como Cadena;
	Definir entrega, cuotas Como Cadena;
	Definir posPlan, posCliente Como Entero;
	
	Limpiar Pantalla;
	
	legajo <- ventas[idVenta,0];
	dni <- ventas[idVenta,1];
	
	posCliente <- busquedaPorId(cliente, dni);
	nombreYapellido <- cliente[posCliente, 1];
	
	fecha <- ventas[idVenta,3];
	idAuto <- ventas[idVenta,4];
	
	idPlan <- ventas[idVenta,5];
	
	Si idPlan <> '0' Entonces
		posPlan <- busquedaPorId(planesDePago, idPlan);
		entrega <- planesDePago[posPlan, 1];
		cuotas <- planesDePago[posPlan, 2];
		Escribir '________________________________________________________________________________________';
		Escribir '| File Number |    ID CARD   | First and Last Name |    Date   |  Id Car  | Delivery | Dues |';
		
		Escribir '________________________________________________________________________________________';
		Escribir  '|    ',legajo, '    | ', dni , ' |    ', nombreYapellido , '     | ', fecha, ' |   ', idAuto , '   |   ', entrega, '  |    ', cuotas, ' |';
	SiNo
		Escribir '________________________________________________________________________________________';
		Escribir '| File Number | ID CARD | First and Last Name | Date | Id Car | Id Plan |';
		Escribir '__________________________________________________________________________________';
		Escribir  legajo, ' | ', dni , ' | ', nombreYapellido , ' | ', fecha, ' | ', idAuto , ' | No Plan';
	FinSi
	Escribir '________________________________________________________________________________________';
	
	Leer rta;
FinSubProceso

SubProceso mostrarClientePorId(cliente, idCliente)
	Definir indiceCliente  como entero;
	indiceCliente <- busquedaPorId(cliente, idCliente);
	Escribir '|  ID CARD | First and Last Name |';
	Escribir '|',cliente[indiceCliente,0],'|',cliente[indiceCliente,1],'|';
	
	Leer indiceCliente;
	
FinSubProceso

SubProceso mostrarRepuestoPorId(repuesto, idRepuesto)
	Definir indiceRepuesto  como entero;
	indiceRepuesto <- busquedaPorId(repuesto, idRepuesto);
	// Id, Categoría, Marca, Modelo, Precio, stock.
	Escribir '_______________________________________________________________';
	Escribir '|  Spare part Id | Category | Brand | Model | Price | Stock |';
	Escribir '_______________________________________________________________';
	Escribir '|   ',repuesto[indiceRepuesto,0],'   |    ',repuesto[indiceRepuesto,1],'   |  ',repuesto[indiceRepuesto,2],' |  ', repuesto[indiceRepuesto,3],'  |  ', repuesto[indiceRepuesto,4],' |   ',repuesto[indiceRepuesto,5],'  |';
	Escribir '_______________________________________________________________';	
FinSubProceso

//Mostrar Todos___________________________________________________________________________________________________

subproceso vehiculosDisponibles(auto)
	Definir i Como Entero;
	Limpiar Pantalla;
	Escribir '|   Id   |  Year  |  Brand |  Model |   Km   |  Price  | Rental Price |'; 
	Escribir '---------------------------------------------------------------------------';
	Para i<-0 Hasta 99 Hacer
		Si auto[i,7] = 'true' Entonces
			Escribir '| ',auto[i,0], ' | ',auto[i,1], ' | ', auto[i,2], ' | ', auto[i,3], ' | ', auto[i,4], ' | ', auto[i,5], ' | ', auto[i,6], ' |'; 
		FinSi
	FinPara
	Leer i;
FinSubProceso

subproceso mostrarAutos(auto)
	Definir i Como Entero;
	Escribir '|   Id   |   Year  |  Brand | Model |    Km     | Price  | Rental Price |  Status  |';
	Escribir '-----------------------------------------------------------------------------------------';
	Para i<-0 Hasta 99 Hacer
		Si auto[i,0] <> '0' Entonces
			Escribir '|  ',auto[i,0], '  | ',auto[i,1], ' |  ', auto[i,2], '  | ', auto[i,3], ' |  ', auto[i,4], '  | ', auto[i,5], '   |      ', auto[i,6], '     | ', auto[i,7], ' |'; 
		FinSi
	FinPara
FinSubProceso

subproceso mostrarAllempleados(empleado)
	definir i,j como entero;
	Limpiar Pantalla;
	escribir "| File number | Name | Name 2 | Last name | Address | Age | Nationality |";
	Para i <- 0 Hasta 99 Con Paso 1 Hacer
		Para j <- 0 Hasta 6 Con Paso 1 Hacer
			Si no (empleado[i,j]= '0') Entonces
				escribir sin saltar "| ",empleado[i,j];
			FinSi
		FinPara
		Si no (empleado[i,0]= '0') Entonces
			escribir " |";
		FinSi
	FinPara
	Escribir '_____________________________________________________________________________________';
FinSubProceso

SubProceso mostrarMatrizVentas(venta, planesDePago)
	
	Definir i, j, posPlan Como Entero;
	Definir idPlan, entrega, cuotas como cadena;
	Limpiar Pantalla;
	Escribir '______________________________________________________________________________________';
	Escribir '| File number |    ID Card   | Name and Last name |    Date   | Id Car | Delivery | Dues |';
	
	Para i<-0 Hasta 99 Hacer
		Si No(venta[i,0] = '0') Entonces
			idPlan <- venta[i,5];
			Escribir '______________________________________________________________________________________';
			Si idPlan <> '0' Entonces
				posPlan <- busquedaPorId(planesDePago, idPlan);
				entrega <- planesDePago[posPlan, 1];
				cuotas <- planesDePago[posPlan, 2];
				Escribir  '|    ',venta[i,0], '    | ', venta[i,1] , ' |    ', venta[i,2] , '    | ', venta[i,3], ' |   ', venta[i,4] , ' |  ', entrega, '  |    ', cuotas , '  |';
			SiNo
				Escribir  '|    ',venta[i,0], '    | ', venta[i,1] , ' |    ', venta[i,2] , '     | ', venta[i,3], ' |   ', venta[i,4] , ' | Sin Plan         |';
			FinSi
			
		FinSi
	FinPara
	Escribir '______________________________________________________________________________________';
	leer i;
	
FinSubProceso

SubProceso mostrarMatrizRepuestos(repuestos)
	Definir i, j Como Entero;
	Escribir '|  Id  | Category | Brand | Model | Price | Stock';
	Para i<-0 Hasta 99 Hacer
		Si No(repuestos[i,0] = '0') Entonces
			Para j<-0 Hasta 5 Hacer
				Escribir Sin Saltar '| ', repuestos[i,j], ' ';
			FinPara
			Escribir '|';
		FinSi
	FinPara
	leer i;
FinSubProceso

SubProceso mostrarClientes(cliente)
	Definir i,j Como Entero;
	Limpiar Pantalla;
	Para i<-0 Hasta 99 Hacer
		Si No(cliente[i,0] = '0') Entonces
			Para j<-0 Hasta 1 Hacer
				Escribir Sin Saltar '| ', cliente[i,j], ' ';
			FinPara
			Escribir '|';
		FinSi
	FinPara
	Leer i;
FinSubProceso

SubProceso mostrarPlanesDePago(planesDePago)
	Definir i, j Como Entero;
	Limpiar Pantalla;
	Escribir '| IdPlan | Delivery | Dues |';
	Escribir '______________________________';
	Para i<-0 Hasta 99 Hacer
		Si No(planesDePago[i,0] = '0') Entonces
			Para j<-0 Hasta 2 Hacer
				Escribir Sin Saltar '|   ', planesDePago[i,j], '  ';
			FinPara
			Escribir '  |';
		FinSi
	FinPara
	Escribir '______________________________';
FinSubProceso

subproceso mostrarVentas(venta)
	definir i, j como entero;
	Limpiar Pantalla;
	Para i<-0 Hasta 99 Hacer
		Si No(venta[i,0] = '0') Entonces
			Para j<-0 Hasta 4 Hacer
				Escribir Sin Saltar '| ', venta[i,j], ' ';
			FinPara
			Escribir '|';
		FinSi
    FinPara
	Leer i;
FinSubProceso

//Barra de carga______________________________________________________________________________________________
SubProceso barra(operacion)
	
	definir i Como Entero;
	operacion<- Mayusculas(operacion);
	
	Escribir '';	Escribir '';
	
	Escribir '                      CARGANDO ' , operacion ;
	Escribir '---------------------------------------------------------------------';
	
	Para i<- 0 Hasta 69  Hacer 
		Esperar 2*i Milisegundos;
		Escribir Sin Saltar '|';
	FinPara
	
	Escribir '';
	Escribir '---------------------------------------------------------------------';
	Escribir '';
	Escribir 'OPERACIÓN FINALIZADA';
	
FinSubProceso

// Baner ----------------------------------------------------------------------------------------------------

SubProceso baner()
	Esperar 1 Segundos;
	escribir "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXO------------OXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	esperar 200 milisegundos;
	escribir "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX|            |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	esperar 200 milisegundos;
	escribir "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX|Team pro_Utn|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	esperar 200 milisegundos;
	escribir "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX|            |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	esperar 200 milisegundos;
	escribir "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXO------------OXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	
	
	//escribir " ";
	esperar 100 milisegundos;
	Escribir "         		                                  _._";
	esperar 100 milisegundos;
	Escribir "           		                           _.-=´´_-         _";
	esperar 100 milisegundos;
	Escribir "            		                     _.-=´´   _-          | |´´´´´´´---._______     __..";
	esperar 100 milisegundos;
	Escribir "            		         ___.===¨¨¨¨-.______-,,,,,,,,,,,,`-¨ ¨----´¨¨ ¨¨¨¨       ¨¨¨¨  __¨¨";
	esperar 100 milisegundos;
	Escribir "            		  _.--¨¨¨     _        ,´                   o \           _        [_]|";
	esperar 100 milisegundos;
	Escribir "        		 __-´´=======.--¨¨  ¨¨--.=================================.--¨¨  ¨¨--.=======:";
	esperar 100 milisegundos;
	Escribir "        		]       [w] : /        \ : |========================|    : /        \ :  [w] :";
	esperar 100 milisegundos;
	Escribir "        		V___________:|          |: |========================|    :|          |:   _-´";
	esperar 100 milisegundos;
	Escribir "         		V__________: \        / :_|=======================/_____: \        / :__-´";
	esperar 100 milisegundos;
	Escribir "         		-----------´  ¨¨____¨¨  `-------------------------------´  ¨¨____¨¨";
FinSubProceso


//Pre carga___________________________________________________________________________________________________
subproceso preChargeEmployee(empleado)
	definir i,j como entero;
	Para i <- 0 Hasta 99 Hacer
		Para j<-0 Hasta 6 Hacer
			empleado[i,j] <- '0';
		FinPara
	FinPara
	
FinSubProceso
subproceso preChargeCar(auto)
	definir i,j como entero;
	Para i <- 0 Hasta 99 Hacer
		Para j <- 0 Hasta 7 Hacer
			auto[i,j] <- '0';
		FinPara
	FinPara
FinSubProceso

subproceso preChargeSpares(repuestos)
	definir i,j como entero;
	Para i<-0 Hasta 99 Hacer
		Para j<-0 Hasta 5 Hacer
			repuestos[i,j] <- '0';
		FinPara
	FinPara
	
FinSubProceso
subproceso preSetSales(venta)
	definir i,j como entero;
	Para i<-0 Hasta 99 Hacer
		Para j<-0 Hasta 5 Hacer
			venta[i,j] <- '0';
		FinPara
	FinPara
	
FinSubProceso
subproceso preChargeCustomers(cliente)
	definir i,j como entero;
	Para i <- 0 Hasta 99 Hacer
		Para j <- 0 Hasta 1 Hacer
			cliente[i,j] <- '0';
		FinPara
	FinPara
	
FinSubProceso

subproceso preChargePaymentPlan(planesDePago)
	definir i,j como entero;
	Para i <- 0 Hasta 99 Hacer
		Para j <- 0 Hasta 2 Hacer
			planesDePago[i,j] <- '0';
		FinPara
	FinPara
	
FinSubProceso

//fín pre carga


//Carga de matrizes y bases de datos.

// Carga de Matrices
// Auto
// Repuestos
// PlanesDePago


SubProceso cargaVentas(venta)
	
	Definir i Como Entero;
	
	//	0: N° Legajo
	//	1: DNI
	//	2: Nombre y Apellido
	//	3: Fecha
	//	4: Id (Auto)
	//	5: Id(plan).
	
	i<-0;
	venta[i,0] <- '100'; 
	venta[i,1] <- '12345678';
	venta[i,2] <- 'Mateo Russo';
	venta[i,3] <- '2022-05-04';
	venta[i,4] <- '38505';
	venta[i,5] <- '102';
	
	
	
	i<-i + 1;
	venta[i,0] <- '140'; 
	venta[i,1] <- '43290210';
	venta[i,2] <- 'Ana Franco';
	venta[i,3] <- '2022-07-16';
	venta[i,4] <- '22894';
	venta[i,5] <- '0';
	
	
FinSubProceso

subproceso cargaMatrizAuto(auto)
	
	
	Definir i Como Entero;
	
	i<-0;
	auto[i,0] <- '55555'; auto[i,1] <-'2011';auto[i,2] <-'Volkswagen';auto[i,3] <-'Trend';
	auto[i,4] <-'185664';auto[i,5] <-'1000000';auto[i,6] <-'300'; auto[i,7] <-'true';
	i<- i + 1;  // i = 1
	auto[i,0] <- '69125'; auto[i,1] <-'2000';auto[i,2] <-'Toyota';auto[i,3] <-'Corolla';
	auto[i,4] <-'186298';auto[i,5] <-'1400000';auto[i,6] <-'310'; auto[i,7] <-'true';
	i<- i + 1; // i = 2
	auto[i,0] <- '22894'; auto[i,1] <-'2017';auto[i,2] <-'Ford';auto[i,3] <-'Escort';
	auto[i,4] <-'237896';auto[i,5] <-'750000';auto[i,6] <-'310'; auto[i,7] <-'false';
	i<- i + 1; // i = 3
	auto[i,0] <- '79927'; auto[i,1] <-'2004';auto[i,2] <-'Fiat';auto[i,3] <-'Escort';
	auto[i,4] <-'207669';auto[i,5] <-'800000';auto[i,6] <-'310'; auto[i,7] <-'false';
	i<- i + 1; // i = 4
	auto[i,0] <- '25021'; auto[i,1] <-'2011';auto[i,2] <-'Volkswagen';auto[i,3] <-'Suram';
	auto[i,4] <-'163390';auto[i,5] <-'1000000';auto[i,6] <-'310'; auto[i,7] <-'false';
	i<- i + 1; // i = 5
	auto[i,0] <- '907401'; auto[i,1] <-'2007';auto[i,2] <-'Toyota';auto[i,3] <-'Hillux';
	auto[i,4] <-'171491';auto[i,5] <-'900000';auto[i,6] <-'310'; auto[i,7] <-'false';
	i<- i + 1; // i = 6	
	auto[i,0] <- '40799'; auto[i,1] <-'2017';auto[i,2] <-'Ford';auto[i,3] <-'Fiesta';
	auto[i,4] <-'47341';auto[i,5] <-'1400000';auto[i,6] <-'310'; auto[i,7] <-'true';
	i<- i + 1; // i = 7	
	auto[i,0] <- '38505'; auto[i,1] <-'2014';auto[i,2] <-'Fiat';auto[i,3] <-'Palio';
	auto[i,4] <-'182198';auto[i,5] <-'1000000';auto[i,6] <-'310'; auto[i,7] <-'false';
	i<- i + 1; // i = 8	
	auto[i,0] <- '47151'; auto[i,1] <-'2018';auto[i,2] <-'Chevrolet';auto[i,3] <-'Onix';
	auto[i,4] <-'205269';auto[i,5] <-'1600000';auto[i,6] <-'290'; auto[i,7] <-'false';
	i<- i + 1; // i = 9	
	auto[i,0] <- '97852'; auto[i,1] <-'2017';auto[i,2] <-'Volkswagen';auto[i,3] <-'Polo';
	auto[i,4] <-'133969';auto[i,5] <-'1400000';auto[i,6] <-'290'; auto[i,7] <-'false';
	i<- i + 1; // i = 10	
	auto[i,0] <- '33757'; auto[i,1] <-'2008';auto[i,2] <-'Toyota';auto[i,3] <-'Corolla';
	auto[i,4] <-'267319';auto[i,5] <-'900000';auto[i,6] <-'290'; auto[i,7] <-'false';
	i<- i + 1; // i = 11
	auto[i,0] <- '39335'; auto[i,1] <-'2001';auto[i,2] <-'Chevrolet';auto[i,3] <-'Corsa';
	auto[i,4] <-'99685';auto[i,5] <-'750000';auto[i,6] <-'290'; auto[i,7] <-'false';
	i<- i + 1; // i = 12
	auto[i,0] <- '39335'; auto[i,1] <-'2001';auto[i,2] <-'Chevrolet';auto[i,3] <-'Corsa';
	auto[i,4] <-'99685';auto[i,5] <-'750000';auto[i,6] <-'290'; auto[i,7] <-'false';
	i<- i + 1; // i = 13
	auto[i,0] <- '20854'; auto[i,1] <-'2016';auto[i,2] <-'Volkswagen';auto[i,3] <-'Trend';
	auto[i,4] <-'156950';auto[i,5] <-'1200000';auto[i,6] <-'290'; auto[i,7] <-'false';
	i<- i + 1; // i = 14
	auto[i,0] <- '77152'; auto[i,1] <-'2012';auto[i,2] <-'Toyota';auto[i,3] <-'Corolla';
	auto[i,4] <-'135710';auto[i,5] <-'1000000';auto[i,6] <-'290'; auto[i,7] <-'false';
	i<- i + 1; // i = 15
	auto[i,0] <- '59949'; auto[i,1] <-'2010';auto[i,2] <-'Chevrolet';auto[i,3] <-'Corsa';
	auto[i,4] <-'212238';auto[i,5] <-'1000000';auto[i,6] <-'290'; auto[i,7] <-'true';
	i<- i + 1; // i = 16
	auto[i,0] <- '20135'; auto[i,1] <-'2015';auto[i,2] <-'Ford';auto[i,3] <-'Ranger';
	auto[i,4] <-'173874';auto[i,5] <-'1100000';auto[i,6] <-'290'; auto[i,7] <-'true';
	i<- i + 1; // i = 17
	auto[i,0] <- '74221'; auto[i,1] <-'2009';auto[i,2] <-'Fiat';auto[i,3] <-'Palio';
	auto[i,4] <-'195244';auto[i,5] <-'900000';auto[i,6] <-'290'; auto[i,7] <-'true';
	i<- i + 1; // i = 18
	auto[i,0] <- '10879'; auto[i,1] <-'2000';auto[i,2] <-'Chevrolet';auto[i,3] <-'Corsa';
	auto[i,4] <-'296022';auto[i,5] <-'750000';auto[i,6] <-'310'; auto[i,7] <-'false';
	i<- i + 1; // i = 19
	auto[i,0] <- '10607'; auto[i,1] <-'2005';auto[i,2] <-'Volkswagen';auto[i,3] <-'Trend';
	auto[i,4] <-'55350';auto[i,5] <-'800000';auto[i,6] <-'310'; auto[i,7] <-'false';
	i<- i + 1; // i = 20
	auto[i,0] <- '39052'; auto[i,1] <-'2001';auto[i,2] <-'Toyota';auto[i,3] <-'Corolla';
	auto[i,4] <-'197730';auto[i,5] <-'750000';auto[i,6] <-'300'; auto[i,7] <-'false';
	i<- i + 1; // i = 21
	auto[i,0] <- '90838'; auto[i,1] <-'2001';auto[i,2] <-'Ford';auto[i,3] <-'Ka';
	auto[i,4] <-'227082';auto[i,5] <-'750000';auto[i,6] <-'300'; auto[i,7] <-'false';
	i<- i + 1; // i = 22
	auto[i,0] <- '32862'; auto[i,1] <-'2009';auto[i,2] <-'Fiat';auto[i,3] <-'Palio';
	auto[i,4] <-'22206';auto[i,5] <-'900000';auto[i,6] <-'300'; auto[i,7] <-'false';
	i<- i + 1; // i = 23
	auto[i,0] <- '59105'; auto[i,1] <-'2005';auto[i,2] <-'Chevrolet';auto[i,3] <-'Corsa';
	auto[i,4] <-'175897';auto[i,5] <-'800000';auto[i,6] <-'300'; auto[i,7] <-'false';
	i<- i + 1; // i = 24
	auto[i,0] <- '31279'; auto[i,1] <-'2011';auto[i,2] <-'Renault';auto[i,3] <-'Clio';
	auto[i,4] <-'73578';auto[i,5] <-'1000000';auto[i,6] <-'310'; auto[i,7] <-'false';
	i<- i + 1; // i = 25
	auto[i,0] <- '31804'; auto[i,1] <-'2009';auto[i,2] <-'Ford';auto[i,3] <-'Ka';
	auto[i,4] <-'259413';auto[i,5] <-'900000';auto[i,6] <-'310'; auto[i,7] <-'false';
	i<- i + 1; // i = 26
	auto[i,0] <- '64158'; auto[i,1] <-'2002';auto[i,2] <-'Fiat';auto[i,3] <-'Uno';
	auto[i,4] <-'166585';auto[i,5] <-'750000';auto[i,6] <-'310'; auto[i,7] <-'true';
	i<- i + 1; // i = 27
	auto[i,0] <- '93059'; auto[i,1] <-'2001';auto[i,2] <-'Chevrolet';auto[i,3] <-'Aveo';
	auto[i,4] <-'20574';auto[i,5] <-'750000';auto[i,6] <-'300'; auto[i,7] <-'true';
	i<- i + 1; // i = 28
	auto[i,0] <- '34695'; auto[i,1] <-'2014';auto[i,2] <-'Renault';auto[i,3] <-'Sandero';
	auto[i,4] <-'225457';auto[i,5] <-'1000000';auto[i,6] <-'300'; auto[i,7] <-'false';
	i<- i + 1; // i = 29
	auto[i,0] <- '36179'; auto[i,1] <-'2012';auto[i,2] <-'Peugeot';auto[i,3] <-'206';
	auto[i,4] <-'292098';auto[i,5] <-'800000';auto[i,6] <-'300'; auto[i,7] <-'false';
	i<- i + 1; // i = 30
	auto[i,0] <- '82071'; auto[i,1] <-'2004';auto[i,2] <-'Ford';auto[i,3] <-'Fiesta';
	auto[i,4] <-'10696';auto[i,5] <-'1000000';auto[i,6] <-'300'; auto[i,7] <-'false';
	i<- i + 1; // i = 31
	auto[i,0] <- '95244'; auto[i,1] <-'2003';auto[i,2] <-'Citroen';auto[i,3] <-'C3';
	auto[i,4] <-'255092';auto[i,5] <-'800000';auto[i,6] <-'300'; auto[i,7] <-'false';
	i<- i + 1; // i = 32
	auto[i,0] <- '43914'; auto[i,1] <-'2013';auto[i,2] <-'Renault';auto[i,3] <-'Sandero';
	auto[i,4] <-'54346';auto[i,5] <-'1000000';auto[i,6] <-'310'; auto[i,7] <-'false';
	i<- i + 1; // i = 33
	auto[i,0] <- '36624'; auto[i,1] <-'2017';auto[i,2] <-'Peugeot';auto[i,3] <-'307';
	auto[i,4] <-'210908';auto[i,5] <-'900000';auto[i,6] <-'300'; auto[i,7] <-'true';
	i<- i + 1; // i = 34
	auto[i,0] <- '18349'; auto[i,1] <-'2009';auto[i,2] <-'Ford';auto[i,3] <-'Ranger';
	auto[i,4] <-'295379';auto[i,5] <-'1400000';auto[i,6] <-'300'; auto[i,7] <-'true';
	i<- i + 1; // i = 35
	auto[i,0] <- '90858'; auto[i,1] <-'2009';auto[i,2] <-'Citroen';auto[i,3] <-'C4';
	auto[i,4] <-'200926';auto[i,5] <-'900000';auto[i,6] <-'300'; auto[i,7] <-'false';
	i<- i + 1; // i = 36
	auto[i,0] <- '87377'; auto[i,1] <-'2017';auto[i,2] <-'Toyota';auto[i,3] <-'Hillux';
	auto[i,4] <-'34942';auto[i,5] <-'1400000';auto[i,6] <-'300'; auto[i,7] <-'false';
	i<- i + 1; // i = 37
	auto[i,0] <- '66375'; auto[i,1] <-'2017';auto[i,2] <-'Ford';auto[i,3] <-'Ranger';
	auto[i,4] <-'57459';auto[i,5] <-'1400000';auto[i,6] <-'300'; auto[i,7] <-'false';
	i<- i + 1; // i = 38
	auto[i,0] <- '24056'; auto[i,1] <-'2021';auto[i,2] <-'Fiat';auto[i,3] <-'Cronos';
	auto[i,4] <-'65000';auto[i,5] <-'2500000';auto[i,6] <-'300'; auto[i,7] <-'false';
	i<- i + 1; // i = 39
	auto[i,0] <- '82155'; auto[i,1] <-'2011';auto[i,2] <-'Chevrolet';auto[i,3] <-'Celta';
	auto[i,4] <-'88250';auto[i,5] <-'1000000';auto[i,6] <-'300'; auto[i,7] <-'false';
	i<- i + 1; // i = 40
	auto[i,0] <- '92865'; auto[i,1] <-'2022';auto[i,2] <-'Renault';auto[i,3] <-'Koleos';
	auto[i,4] <-'0';auto[i,5] <-'3000000';auto[i,6] <-'300'; auto[i,7] <-'false';
	i<- i + 1; // i = 41
	auto[i,0] <- '28525'; auto[i,1] <-'2004';auto[i,2] <-'Ford';auto[i,3] <-'Ka';
	auto[i,4] <-'238771';auto[i,5] <-'800000';auto[i,6] <-'290'; auto[i,7] <-'false';
	i<- i + 1; // i = 42
	auto[i,0] <- '95062'; auto[i,1] <-'2007';auto[i,2] <-'Fiat';auto[i,3] <-'Uno';
	auto[i,4] <-'2168';auto[i,5] <-'900000';auto[i,6] <-'290'; auto[i,7] <-'false';
	i<- i + 1; // i = 43	
	auto[i,0] <- '84885'; auto[i,1] <-'2002';auto[i,2] <-'Chevrolet';auto[i,3] <-'Aveo';
	auto[i,4] <-'68598';auto[i,5] <-'760000';auto[i,6] <-'290'; auto[i,7] <-'false';
	i<- i + 1; // i = 44
	auto[i,0] <- '61556'; auto[i,1] <-'2004';auto[i,2] <-'Renault';auto[i,3] <-'Clio';
	auto[i,4] <-'218679';auto[i,5] <-'800000';auto[i,6] <-'290'; auto[i,7] <-'false';
	i<- i + 1; // i = 45
	auto[i,0] <- '48078'; auto[i,1] <-'2009';auto[i,2] <-'Ford	';auto[i,3] <-'Focus';
	auto[i,4] <-'0';auto[i,5] <-'6000000';auto[i,6] <-'310'; auto[i,7] <-'true';
	i<- i + 1; // i = 46	
	auto[i,0] <- '81821'; auto[i,1] <-'2004';auto[i,2] <-'Peugeot';auto[i,3] <-'307';
	auto[i,4] <-'0';auto[i,5] <-'5000000';auto[i,6] <-'310'; auto[i,7] <-'true';
	i<- i + 1; // i = 47
	auto[i,0] <- '45835'; auto[i,1] <-'2017';auto[i,2] <-'Citroen';auto[i,3] <-'C4';
	auto[i,4] <-'295795';auto[i,5] <-'1400000';auto[i,6] <-'300'; auto[i,7] <-'false';
	i<- i + 1; // i = 48
	auto[i,0] <- '59579'; auto[i,1] <-'2011';auto[i,2] <-'BMW';auto[i,3] <-'Serie 1';
	auto[i,4] <-'21052';auto[i,5] <-'1000000';auto[i,6] <-'300'; auto[i,7] <-'false';
	i<- i + 1; // i = 49
	auto[i,0] <- '32104'; auto[i,1] <-'2004';auto[i,2] <-'Ford';auto[i,3] <-'Ecosport';
	auto[i,4] <-'0';auto[i,5] <-'800000';auto[i,6] <-'300'; auto[i,7] <-'false';
	i<- i + 1; // i = 50
	auto[i,0] <- '20815'; auto[i,1] <-'2001';auto[i,2] <-'Peugeot';auto[i,3] <-'406';
	auto[i,4] <-'25275';auto[i,5] <-'900000';auto[i,6] <-'300'; auto[i,7] <-'true';
	i<- i + 1; // i = 51	
	auto[i,0] <- '20815'; auto[i,1] <-'2020';auto[i,2] <-'Citroen';auto[i,3] <-'C4';
	auto[i,4] <-'70000';auto[i,5] <-'2000000';auto[i,6] <-'300'; auto[i,7] <-'true';
	i<- i + 1; // i = 52	
	auto[i,0] <- '82792'; auto[i,1] <-'2005';auto[i,2] <-'BMW';auto[i,3] <-'Serie 1';
	auto[i,4] <-'34232';auto[i,5] <-'800000';auto[i,6] <-'300'; auto[i,7] <-'true';
	i<- i + 1; // i = 53
	auto[i,0] <- '29883'; auto[i,1] <-'2022';auto[i,2] <-'Ford';auto[i,3] <-'Focus';
	auto[i,4] <-'0';auto[i,5] <-'3000000';auto[i,6] <-'310'; auto[i,7] <-'true';
	i<- i + 1; // i = 54
	auto[i,0] <- '79185'; auto[i,1] <-'2004';auto[i,2] <-'Peugeot';auto[i,3] <-'206';
	auto[i,4] <-'11737';auto[i,5] <-'800000';auto[i,6] <-'310'; auto[i,7] <-'true';
	i<- i + 1; // i = 55
	auto[i,0] <- '45294'; auto[i,1] <-'2002';auto[i,2] <-'Mercedes Benz';auto[i,3] <-'Clase C';
	auto[i,4] <-'212365';auto[i,5] <-'750000';auto[i,6] <-'310'; auto[i,7] <-'true';
	i<- i + 1; // i = 56
	auto[i,0] <- '44666'; auto[i,1] <-'2016';auto[i,2] <-'Honda';auto[i,3] <-'Civic';
	auto[i,4] <-'59215';auto[i,5] <-'1200000';auto[i,6] <-'300'; auto[i,7] <-'true';
	i<- i + 1; // i = 57
	auto[i,0] <- '74992'; auto[i,1] <-'2000';auto[i,2] <-'Hiundai';auto[i,3] <-'Accent';
	auto[i,4] <-'76590';auto[i,5] <-'750000';auto[i,6] <-'310'; auto[i,7] <-'true';
	i<- i + 1; // i = 58	
	auto[i,0] <- '36023'; auto[i,1] <-'2005';auto[i,2] <-'Peugeot';auto[i,3] <-'307';
	auto[i,4] <-'84930';auto[i,5] <-'800000';auto[i,6] <-'310'; auto[i,7] <-'true';
	i<- i + 1; // i = 59	
	auto[i,0] <- '95382'; auto[i,1] <-'2002';auto[i,2] <-'Mercedes Benz';auto[i,3] <-'Clase 1';
	auto[i,4] <-'161533';auto[i,5] <-'750000';auto[i,6] <-'310'; auto[i,7] <-'true';
	i<- i + 1; // i = 60	
	auto[i,0] <- '55079'; auto[i,1] <-'2019';auto[i,2] <-'Honda';auto[i,3] <-'Fit';
	auto[i,4] <-'247693';auto[i,5] <-'1800000';auto[i,6] <-'300'; auto[i,7] <-'false';
	i<- i + 1; // i = 61
	auto[i,0] <- '90078'; auto[i,1] <-'2006';auto[i,2] <-'Hiundai';auto[i,3] <-'Tucson';
	auto[i,4] <-'74024';auto[i,5] <-'900000';auto[i,6] <-'300'; auto[i,7] <-'true';
	i<- i + 1; // i = 62
	auto[i,0] <- '17179'; auto[i,1] <-'2022';auto[i,2] <-'Renault';auto[i,3] <-'Sandero';
	auto[i,4] <-'0';auto[i,5] <-'300000';auto[i,6] <-'300'; auto[i,7] <-'false';
	i<- i + 1; // i = 63
	auto[i,0] <- '99202'; auto[i,1] <-'2014';auto[i,2] <-'Ford';auto[i,3] <-'Fiesta';
	auto[i,4] <-'17571';auto[i,5] <-'100000';auto[i,6] <-'300'; auto[i,7] <-'true';
	i<- i + 1; // i = 64
	auto[i,0] <- '88142'; auto[i,1] <-'2007';auto[i,2] <-'Peugeot';auto[i,3] <-'207';
	auto[i,4] <-'32178';auto[i,5] <-'900000';auto[i,6] <-'290'; auto[i,7] <-'true';
	i<- i + 1; // i = 65
	auto[i,0] <- '33001'; auto[i,1] <-'2009';auto[i,2] <-'Citroen';auto[i,3] <-'C3';
	auto[i,4] <-'199763';auto[i,5] <-'900000';auto[i,6] <-'290'; auto[i,7] <-'false';
	i<- i + 1; // i = 66
	auto[i,0] <- '36954'; auto[i,1] <-'2022';auto[i,2] <-'BMW';auto[i,3] <-'Serie 4';
	auto[i,4] <-'0';auto[i,5] <-'2600000';auto[i,6] <-'290'; auto[i,7] <-'false';
	i<- i + 1; // i = 67
	auto[i,0] <- '37964'; auto[i,1] <-'2000';auto[i,2] <-'Ford';auto[i,3] <-'Escort';
	auto[i,4] <-'84709';auto[i,5] <-'750000';auto[i,6] <-'300'; auto[i,7] <-'true';
	i<- i + 1; // i = 68
	auto[i,0] <- '46095'; auto[i,1] <-'2002';auto[i,2] <-'Citroen';auto[i,3] <-'C3';
	auto[i,4] <-'221309';auto[i,5] <-'750000';auto[i,6] <-'300'; auto[i,7] <-'false';
	i<- i + 1; // i = 69
	auto[i,0] <- '61093'; auto[i,1] <-'2018';auto[i,2] <-'Peugeot';auto[i,3] <-'208';
	auto[i,4] <-'137223';auto[i,5] <-'1600000';auto[i,6] <-'300'; auto[i,7] <-'false';
	i<- i + 1; // i = 70
	auto[i,0] <- '12671'; auto[i,1] <-'2001';auto[i,2] <-'BMW';auto[i,3] <-'Serie 1';
	auto[i,4] <-'261278';auto[i,5] <-'750000';auto[i,6] <-'310'; auto[i,7] <-'true';
	i<- i + 1; // i = 71
	auto[i,0] <- '53953'; auto[i,1] <-'2015';auto[i,2] <-'Ford';auto[i,3] <-'Ecosport';
	auto[i,4] <-'181816';auto[i,5] <-'1100000';auto[i,6] <-'310'; auto[i,7] <-'true';
	i<- i + 1; // i = 72
	auto[i,0] <- '32243'; auto[i,1] <-'2020';auto[i,2] <-'Peugeot';auto[i,3] <-'208';
	auto[i,4] <-'100000';auto[i,5] <-'2000000';auto[i,6] <-'310'; auto[i,7] <-'false';
	i<- i + 1; // i = 73
	auto[i,0] <- '14143'; auto[i,1] <-'2019';auto[i,2] <-'Mercedes Benz';auto[i,3] <-'Clase 4';
	auto[i,4] <-'3692';auto[i,5] <-'1800000';auto[i,6] <-'310'; auto[i,7] <-'false';
	i<- i + 1; // i = 74
	auto[i,0] <- '69799'; auto[i,1] <-'2017';auto[i,2] <-'Honda';auto[i,3] <-'Civic';
	auto[i,4] <-'91365';auto[i,5] <-'1400000';auto[i,6] <-'310'; auto[i,7] <-'true';
	i<- i + 1; // i = 75
	auto[i,0] <- '38539'; auto[i,1] <-'2021';auto[i,2] <-'Hiundai';auto[i,3] <-'Genesis';
	auto[i,4] <-'35000';auto[i,5] <-'2500000';auto[i,6] <-'300'; auto[i,7] <-'true';
	i<- i + 1; // i = 76
	auto[i,0] <- '54077'; auto[i,1] <-'2020';auto[i,2] <-'Peugeot';auto[i,3] <-'308';
	auto[i,4] <-'85000';auto[i,5] <-'2000000';auto[i,6] <-'300'; auto[i,7] <-'false';
	i<- i + 1; // i = 77
	auto[i,0] <- '29535'; auto[i,1] <-'2022';auto[i,2] <-'Honda';auto[i,3] <-'Tucson';
	auto[i,4] <-'16919';auto[i,5] <-'1100000';auto[i,6] <-'300'; auto[i,7] <-'false';
	i<- i + 1; // i = 78
	auto[i,0] <- '62223'; auto[i,1] <-'2015';auto[i,2] <-'Mercedes Benz';auto[i,3] <-'Clase 4';
	auto[i,4] <-'0';auto[i,5] <-'2600000';auto[i,6] <-'300'; auto[i,7] <-'false';
	i<- i + 1; // i = 79
	auto[i,0] <- '33287'; auto[i,1] <-'2006';auto[i,2] <-'Hiundai';auto[i,3] <-'Veloster';
	auto[i,4] <-'249825';auto[i,5] <-'900000';auto[i,6] <-'310'; auto[i,7] <-'true';
	i<- i + 1; // i = 80
	auto[i,0] <- '31031'; auto[i,1] <-'2005';auto[i,2] <-'Peugeot';auto[i,3] <-'206';
	auto[i,4] <-'265718';auto[i,5] <-'800000';auto[i,6] <-'310'; auto[i,7] <-'true';
	i<- i + 1; // i = 81
	auto[i,0] <- '61646'; auto[i,1] <-'2022';auto[i,2] <-'Citroen';auto[i,3] <-'C4';
	auto[i,4] <-'0';auto[i,5] <-'300000';auto[i,6] <-'310'; auto[i,7] <-'true';
	i<- i + 1; // i = 82
	auto[i,0] <- '11680'; auto[i,1] <-'2000';auto[i,2] <-'Toyota';auto[i,3] <-'Corolla';
	auto[i,4] <-'23128';auto[i,5] <-'750000';auto[i,6] <-'290'; auto[i,7] <-'false';
	i<- i + 1; // i = 83
	auto[i,0] <- '11812'; auto[i,1] <-'2016';auto[i,2] <-'Ford';auto[i,3] <-'Ranger';
	auto[i,4] <-'227480';auto[i,5] <-'1200000';auto[i,6] <-'290'; auto[i,7] <-'true';
	i<- i + 1; // i = 84
	auto[i,0] <- '53661'; auto[i,1] <-'2020';auto[i,2] <-'Fiat';auto[i,3] <-'Argo';
	auto[i,4] <-'120000';auto[i,5] <-'2000000';auto[i,6] <-'290'; auto[i,7] <-'false';
	i<- i + 1; // i = 85
	auto[i,0] <- '58928'; auto[i,1] <-'2014';auto[i,2] <-'Chevrolet';auto[i,3] <-'Cruze';
	auto[i,4] <-'139131';auto[i,5] <-'1000000';auto[i,6] <-'290'; auto[i,7] <-'true';
	i<- i + 1; // i = 86
	auto[i,0] <- '91877'; auto[i,1] <-'2022';auto[i,2] <-'Renault';auto[i,3] <-'Sandero';
	auto[i,4] <-'0';auto[i,5] <-'3000000';auto[i,6] <-'290'; auto[i,7] <-'false';
	i<- i + 1; // i = 87
	auto[i,0] <- '55367'; auto[i,1] <-'2007';auto[i,2] <-'Ford';auto[i,3] <-'Ecosport';
	auto[i,4] <-'24092';auto[i,5] <-'900000';auto[i,6] <-'300'; auto[i,7] <-'false';
	i<- i + 1; // i = 88
	auto[i,0] <- '21620'; auto[i,1] <-'2002';auto[i,2] <-'Fiat';auto[i,3] <-'Uno';
	auto[i,4] <-'153338';auto[i,5] <-'750000';auto[i,6] <-'300'; auto[i,7] <-'false';
	i<- i + 1; // i = 89
	auto[i,0] <- '50554'; auto[i,1] <-'2020';auto[i,2] <-'Chevrolet';auto[i,3] <-'Uno';
	auto[i,4] <-'153338';auto[i,5] <-'750000';auto[i,6] <-'300'; auto[i,7] <-'true';
	
FinSubProceso


subproceso cargaMatrizEmpleado(empleado)
	Definir i Como Entero;
	
	i<-0;        // i = 0
	empleado[i,0] <- '100'; empleado[i,1] <-'Pablo';empleado[i,2] <-'';empleado[i,3] <-'Novara';
	empleado[i,4] <-'San Martín 132';empleado[i,5] <-'49';empleado[i,6] <-'Argentina';
	i<- i + 1; // i = 1
	empleado[i,0] <- '101'; empleado[i,1] <-'Charles';empleado[i,2] <-'';empleado[i,3] <-'Babbage';
	empleado[i,4] <-'España 131';empleado[i,5] <-'32';empleado[i,6] <-'Británica';
	i<- i + 1; // i = 2
	empleado[i,0] <- '102'; empleado[i,1] <-'Ángela';empleado[i,2] <-'';empleado[i,3] <-'Ruiz Robles';
	empleado[i,4] <-'';empleado[i,5] <-'54';empleado[i,6] <-'Española';
	i<- i + 1; // i = 3
	empleado[i,0] <- '103'; empleado[i,1] <-'Grace';empleado[i,2] <-'';empleado[i,3] <-'Murray Hopper';
	empleado[i,4] <-'Catamarca 6585';empleado[i,5] <-'65';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 4
	empleado[i,0] <- '104'; empleado[i,1] <-'Niklaus';empleado[i,2] <-'';empleado[i,3] <-'Wirth Emil';
	empleado[i,4] <-'Carcarañá 328';empleado[i,5] <-'54';empleado[i,6] <-'Suiza';
	i<- i + 1; // i = 5
	empleado[i,0] <- '105'; empleado[i,1] <-'James';empleado[i,2] <-'Arthur';empleado[i,3] <-'Gosling';
	empleado[i,4] <-'Canadá 6754';empleado[i,5] <-'50';empleado[i,6] <-'Canadiense';
	i<- i + 1; // i = 6
	empleado[i,0] <- '106'; empleado[i,1] <-'Guido';empleado[i,2] <-'';empleado[i,3] <-'Van Rossum';
	empleado[i,4] <-'Sarmiento 185';empleado[i,5] <-'54';empleado[i,6] <-'Holandesa';
	i<- i + 1; // i = 7
	empleado[i,0] <- '107'; empleado[i,1] <-'Kenneth';empleado[i,2] <-'Lane';empleado[i,3] <-'Thompson';
	empleado[i,4] <-'Córdoba 927';empleado[i,5] <-'32';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 8
	empleado[i,0] <- '108'; empleado[i,1] <-'William';empleado[i,2] <-'Henry';empleado[i,3] <-'Gates III';
	empleado[i,4] <-'Rivadavia 932';empleado[i,5] <-'54';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 9
	empleado[i,0] <- '109'; empleado[i,1] <-'Stephen';empleado[i,2] <-'Gary';empleado[i,3] <-'Wozniak';
	empleado[i,4] <-'Chubut 594';empleado[i,5] <-'32';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 10
	empleado[i,0] <- '110'; empleado[i,1] <-'Margaret';empleado[i,2] <-'';empleado[i,3] <-'Hamilton';
	empleado[i,4] <-'Jujuy 385';empleado[i,5] <-'54';empleado[i,6] <-'Británica';
	i<- i + 1; // i = 11
	empleado[i,0] <- '111'; empleado[i,1] <-'Mark';empleado[i,2] <-'Elliot';empleado[i,3] <-'Zuckerberg';
	empleado[i,4] <-'Perú 674';empleado[i,5] <-'32';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 12
	empleado[i,0] <- '112'; empleado[i,1] <-'Louis';empleado[i,2] <-'';empleado[i,3] <-'Pouzin';
	empleado[i,4] <-'Rioja 376';empleado[i,5] <-'60';empleado[i,6] <-'Francesa';
	i<- i + 1; // i = 13
	empleado[i,0] <- '113'; empleado[i,1] <-'Isis';empleado[i,2] <-'';empleado[i,3] <-'Anchalee';
	empleado[i,4] <-'Patagonia 931';empleado[i,5] <-'32';empleado[i,6] <-'Canadiense';
	i<- i + 1; // i = 14
	empleado[i,0] <- '114'; empleado[i,1] <-'Lawrence';empleado[i,2] <-'Edward';empleado[i,3] <-'Page';
	empleado[i,4] <-'Tierra del Fuego 317';empleado[i,5] <-'49';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 15
	empleado[i,0] <- '115'; empleado[i,1] <-'Serguéi';empleado[i,2] <-'';empleado[i,3] <-'Brin';
	empleado[i,4] <-'';empleado[i,5] <-'32';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 16
	empleado[i,0] <- '116'; empleado[i,1] <-'Karen';empleado[i,2] <-'';empleado[i,3] <-'Jones';
	empleado[i,4] <-'Santa Fe 971';empleado[i,5] <-'54';empleado[i,6] <-'Británica';
	i<- i + 1; // i = 17
	empleado[i,0] <- '117'; empleado[i,1] <-'Hedwig';empleado[i,2] <-'Eva Maria';empleado[i,3] <-'Kiesler';
	empleado[i,4] <-'Paraguay 1975';empleado[i,5] <-'32';empleado[i,6] <-'Austríaca';
	i<- i + 1; // i = 18
	empleado[i,0] <- '118'; empleado[i,1] <-'George';empleado[i,2] <-'Carl Johann';empleado[i,3] <-'Antheil';
	empleado[i,4] <-'Río Negro 495';empleado[i,5] <-'54';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 19
	empleado[i,0] <- '119'; empleado[i,1] <-'Creola';empleado[i,2] <-'Katherine';empleado[i,3] <-'Johnson';
	empleado[i,4] <-'Croacia 674';empleado[i,5] <-'32';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 20
	empleado[i,0] <- '120'; empleado[i,1] <-'Evelyn';empleado[i,2] <-'';empleado[i,3] <-'Berezin';
	empleado[i,4] <-'Corrientes 674';empleado[i,5] <-'54';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 21
	empleado[i,0] <- '121'; empleado[i,1] <-'Stephanie';empleado[i,2] <-'Steve';empleado[i,3] <-'Shirley';
	empleado[i,4] <-'Formosa 3846';empleado[i,5] <-'32';empleado[i,6] <-'Británica';
	i<- i + 1; // i = 22
	empleado[i,0] <- '122'; empleado[i,1] <-'Mary';empleado[i,2] <-'Allen';empleado[i,3] <-'Wilkes';
	empleado[i,4] <-'San Lorenzo 495';empleado[i,5] <-'62';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 23
	empleado[i,0] <- '123'; empleado[i,1] <-'Alan';empleado[i,2] <-'Mathison';empleado[i,3] <-'Turing';
	empleado[i,4] <-'Santa Fe 685';empleado[i,5] <-'32';empleado[i,6] <-'Británica';
	i<- i + 1; // i = 24
	empleado[i,0] <- '124'; empleado[i,1] <-'James';empleado[i,2] <-'';empleado[i,3] <-'Gosling';
	empleado[i,4] <-'Venezuela 576';empleado[i,5] <-'54';empleado[i,6] <-'Canadiense';
	i<- i + 1; // i = 25
	empleado[i,0] <- '125'; empleado[i,1] <-'Al';empleado[i,2] <-'-';empleado[i,3] <-'Juarismi';
	empleado[i,4] <-'Santa Fe 825';empleado[i,5] <-'32';empleado[i,6] <-'Iraquí';
	i<- i + 1; // i = 26
	empleado[i,0] <- '126'; empleado[i,1] <-'Gearge';empleado[i,2] <-'';empleado[i,3] <-'Boole';
	empleado[i,4] <-'Sarmiento 685';empleado[i,5] <-'49';empleado[i,6] <-'Británica';
	i<- i + 1; // i = 27
	empleado[i,0] <- '127'; empleado[i,1] <-'Maurice';empleado[i,2] <-'Vincent';empleado[i,3] <-'Wilkes';
	empleado[i,4] <-'Salta 586';empleado[i,5] <-'48';empleado[i,6] <-'Británica';
	i<- i + 1; // i = 28
	empleado[i,0] <- '128'; empleado[i,1] <-'John';empleado[i,2] <-'Warner';empleado[i,3] <-'Backus';
	empleado[i,4] <-'Salta 3825';empleado[i,5] <-'54';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 29
	empleado[i,0] <- '129'; empleado[i,1] <-'John';empleado[i,2] <-'';empleado[i,3] <-'McCarthy';
	empleado[i,4] <-'Urquiza 628';empleado[i,5] <-'32';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 30
	empleado[i,0] <- '130'; empleado[i,1] <-'Kenneth';empleado[i,2] <-'Eugene';empleado[i,3] <-'Iverson';
	empleado[i,4] <-'Rioja 825';empleado[i,5] <-'54';empleado[i,6] <-'Canadiense';
	i<- i + 1; // i = 31
	empleado[i,0] <- '131'; empleado[i,1] <-'Carol';empleado[i,2] <-'';empleado[i,3] <-'Shaw';
	empleado[i,4] <-'San Juan 396';empleado[i,5] <-'32';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 32
	empleado[i,0] <- '132'; empleado[i,1] <-'John';empleado[i,2] <-'George';empleado[i,3] <-'Kemeny';
	empleado[i,4] <-'Santa Fe 935';empleado[i,5] <-'54';empleado[i,6] <-'Húngara';
	i<- i + 1; // i = 33
	empleado[i,0] <- '133'; empleado[i,1] <-'Thomas';empleado[i,2] <-'Eugene';empleado[i,3] <-'Kurtz';
	empleado[i,4] <-'La Pampa 4682';empleado[i,5] <-'33';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 34
	empleado[i,0] <- '134'; empleado[i,1] <-'Seymour';empleado[i,2] <-'';empleado[i,3] <-'Papert';
	empleado[i,4] <-'Salta  546';empleado[i,5] <-'54';empleado[i,6] <-'Sudafricana';
	i<- i + 1; // i = 35
	empleado[i,0] <- '135'; empleado[i,1] <-'Niklaus';empleado[i,2] <-'Emil';empleado[i,3] <-'Wirth';
	empleado[i,4] <-'San Martín 1649';empleado[i,5] <-'32';empleado[i,6] <-'Suiza';
	i<- i + 1; // i = 36
	empleado[i,0] <- '136'; empleado[i,1] <-'Dennis';empleado[i,2] <-'Ritchie';empleado[i,3] <-'MacAlistair';
	empleado[i,4] <-'San Juan 825';empleado[i,5] <-'54';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 37
	empleado[i,0] <- '137'; empleado[i,1] <-'Alan';empleado[i,2] <-'Curtis';empleado[i,3] <-'Kay';
	empleado[i,4] <-'Jujuy 246';empleado[i,5] <-'81';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 38
	empleado[i,0] <- '138'; empleado[i,1] <-'Brian';empleado[i,2] <-'Wilson';empleado[i,3] <-'Kernighan';
	empleado[i,4] <-'Maipú 731';empleado[i,5] <-'54';empleado[i,6] <-'Canadiense';
	i<- i + 1; // i = 39
	empleado[i,0] <- '139'; empleado[i,1] <-'Jean';empleado[i,2] <-'David';empleado[i,3] <-'Ichbiah';
	empleado[i,4] <-'Francia 1764';empleado[i,5] <-'69';empleado[i,6] <-'Francesa';
	i<- i + 1; // i = 40
	empleado[i,0] <- '140'; empleado[i,1] <-'Bjarne';empleado[i,2] <-'';empleado[i,3] <-'Stroustrup';
	empleado[i,4] <-'Belgrano 297';empleado[i,5] <-'54';empleado[i,6] <-'Danesa';
	i<- i + 1; // i = 41
	empleado[i,0] <- '141'; empleado[i,1] <-'Konrad';empleado[i,2] <-'Ernst Otto';empleado[i,3] <-'Zuse';
	empleado[i,4] <-'Santa Cruz 4679';empleado[i,5] <-'32';empleado[i,6] <-'Alemana';
	i<- i + 1; // i = 42
	empleado[i,0] <- '142'; empleado[i,1] <-'Jack';empleado[i,2] <-'St. Clair';empleado[i,3] <-'Kilby';
	empleado[i,4] <-'Río Negro 946';empleado[i,5] <-'54';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 43
	empleado[i,0] <- '143'; empleado[i,1] <-'Claude';empleado[i,2] <-'Elwood';empleado[i,3] <-'Shannon';
	empleado[i,4] <-'Santa Fe 1679';empleado[i,5] <-'32';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 44
	empleado[i,0] <- '144'; empleado[i,1] <-'Betty';empleado[i,2] <-'Snyder';empleado[i,3] <-'Holberton';
	empleado[i,4] <-'Chaco 8256';empleado[i,5] <-'54';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 45
	empleado[i,0] <- '145'; empleado[i,1] <-'John';empleado[i,2] <-'William';empleado[i,3] <-'Mauchly';
	empleado[i,4] <-'Santa Fe 502';empleado[i,5] <-'71';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 46
	empleado[i,0] <- '146'; empleado[i,1] <-'Jean';empleado[i,2] <-'Jennings';empleado[i,3] <-'Bartik';
	empleado[i,4] <-'Catamarca 674';empleado[i,5] <-'54';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 47
	empleado[i,0] <- '147'; empleado[i,1] <-'John';empleado[i,2] <-'Presper';empleado[i,3] <-'Eckert ';
	empleado[i,4] <-'Islas Malvinas 685';empleado[i,5] <-'32';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 48
	empleado[i,0] <- '148'; empleado[i,1] <-'Kathleen';empleado[i,2] <-'Rita';empleado[i,3] <-'McNulty Mauchly Antonelli';
	empleado[i,4] <-'Mitre 823';empleado[i,5] <-'54';empleado[i,6] <-'Irlandesa';
	i<- i + 1; // i = 49
	empleado[i,0] <- '149'; empleado[i,1] <-'William';empleado[i,2] <-'Bradford';empleado[i,3] <-'Shockley';
	empleado[i,4] <-'Belgrano 7136';empleado[i,5] <-'52';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 50
	empleado[i,0] <- '150'; empleado[i,1] <-'Marlyn';empleado[i,2] <-'Wescoff';empleado[i,3] <-'Meltzer';
	empleado[i,4] <-'Roca 645';empleado[i,5] <-'54';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 51
	empleado[i,0] <- '151'; empleado[i,1] <-'Houser';empleado[i,2] <-'Houser';empleado[i,3] <-'Brattain';
	empleado[i,4] <-'Av. San Martín';empleado[i,5] <-'42';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 52
	empleado[i,0] <- '152'; empleado[i,1] <-'Ruth';empleado[i,2] <-'Lichterman';empleado[i,3] <-'Teitelbaum';
	empleado[i,4] <-'Belgrano 469';empleado[i,5] <-'54';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 53
	empleado[i,0] <- '153'; empleado[i,1] <-'John';empleado[i,2] <-'';empleado[i,3] <-'Bardeen';
	empleado[i,4] <-'25 de Mayo 2864';empleado[i,5] <-'61';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 54
	empleado[i,0] <- '154'; empleado[i,1] <-'Frances';empleado[i,2] <-'Bilas';empleado[i,3] <-'Spence';
	empleado[i,4] <-'9 de Julio 1764';empleado[i,5] <-'54';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 55
	empleado[i,0] <- '155'; empleado[i,1] <-'Tom';empleado[i,2] <-'';empleado[i,3] <-'Kilburn';
	empleado[i,4] <-'1 de Mayo 367';empleado[i,5] <-'27';empleado[i,6] <-'Británica';
	i<- i + 1; // i = 56
	empleado[i,0] <- '156'; empleado[i,1] <-'William';empleado[i,2] <-'William';empleado[i,3] <-'Mauchly';
	empleado[i,4] <-'25 de MAyo 546';empleado[i,5] <-'21';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 57
	empleado[i,0] <- '157'; empleado[i,1] <-'Wallace';empleado[i,2] <-'John';empleado[i,3] <-'Eckert';
	empleado[i,4] <-'9 de Julio 1346';empleado[i,5] <-'79';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 58
	empleado[i,0] <- '158'; empleado[i,1] <-'Maurice';empleado[i,2] <-'Vincent';empleado[i,3] <-'Wilkes';
	empleado[i,4] <-'25 de Mayo 2679';empleado[i,5] <-'54';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 59
	empleado[i,0] <- '159'; empleado[i,1] <-'Kenneth';empleado[i,2] <-'Harry';empleado[i,3] <-'Olsen';
	empleado[i,4] <-'San Lorenzo 7631';empleado[i,5] <-'71';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 60
	empleado[i,0] <- '160'; empleado[i,1] <-'Sergei';empleado[i,2] <-'Alexeevich';empleado[i,3] <-'Lebedev';
	empleado[i,4] <-'1 de Mayo 6479';empleado[i,5] <-'54';empleado[i,6] <-'Ucraniana';
	i<- i + 1; // i = 61
	empleado[i,0] <- '161'; empleado[i,1] <-'Eugene';empleado[i,2] <-'Myron';empleado[i,3] <-'Amdahl';
	empleado[i,4] <-'Salta 5679';empleado[i,5] <-'32';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 62
	empleado[i,0] <- '162'; empleado[i,1] <-'Brendan';empleado[i,2] <-'';empleado[i,3] <-'Eich';
	empleado[i,4] <-'Santa Fe 4698';empleado[i,5] <-'54';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 63
	empleado[i,0] <- '163'; empleado[i,1] <-'Yukihiro';empleado[i,2] <-'';empleado[i,3] <-'Matsumoto';
	empleado[i,4] <-'Rafael Obligado 648';empleado[i,5] <-'32';empleado[i,6] <-'Japonés';
	i<- i + 1; // i = 64
	empleado[i,0] <- '164'; empleado[i,1] <-'John';empleado[i,2] <-'';empleado[i,3] <-'Blankenbaker';
	empleado[i,4] <-'Entre Ríos 645';empleado[i,5] <-'54';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 65
	empleado[i,0] <- '165'; empleado[i,1] <-'Joan';empleado[i,2] <-'Elisabeth';empleado[i,3] <-'Lowther Murray';
	empleado[i,4] <-'San Martín 764';empleado[i,5] <-'32';empleado[i,6] <-'Británica';
	i<- i + 1; // i = 66
	empleado[i,0] <- '166'; empleado[i,1] <-'Pitágoras';empleado[i,2] <-'';empleado[i,3] <-'De Samos';
	empleado[i,4] <-'Rivadavia 9754';empleado[i,5] <-'54';empleado[i,6] <-'Griega';
	i<- i + 1; // i = 67
	empleado[i,0] <- '167'; empleado[i,1] <-'Andrew';empleado[i,2] <-'Johm';empleado[i,3] <-'Wiles';
	empleado[i,4] <-'Córdoba 925';empleado[i,5] <-'66';empleado[i,6] <-'Británica';
	i<- i + 1; // i = 68
	empleado[i,0] <- '168'; empleado[i,1] <-'Isaac';empleado[i,2] <-'';empleado[i,3] <-'Newton';
	empleado[i,4] <-'Salta 582';empleado[i,5] <-'54';empleado[i,6] <-'Británica';
	i<- i + 1; // i = 69
	empleado[i,0] <- '169'; empleado[i,1] <-'Gottfried';empleado[i,2] <-'Wilhelm';empleado[i,3] <-'Leibniz';
	empleado[i,4] <-'Urquiza 3164';empleado[i,5] <-'32';empleado[i,6] <-'Alemana';
	i<- i + 1; // i = 70
	empleado[i,0] <- '170'; empleado[i,1] <-'Leonardo';empleado[i,2] <-'';empleado[i,3] <-'Pisano Blgollo';
	empleado[i,4] <-'25 de Mayo 1810';empleado[i,5] <-'54';empleado[i,6] <-'Italiana';
	i<- i + 1; // i = 71
	empleado[i,0] <- '171'; empleado[i,1] <-'René';empleado[i,2] <-'';empleado[i,3] <-'Descartes';
	empleado[i,4] <-'9 de Julio 1816';empleado[i,5] <-'32';empleado[i,6] <-'Francesa';
	i<- i + 1; // i = 72
	empleado[i,0] <- '172'; empleado[i,1] <-'Euclides';empleado[i,2] <-'';empleado[i,3] <-'Neucrates';
	empleado[i,4] <-'Santa Fe 1985';empleado[i,5] <-'54';empleado[i,6] <-'Griega';
	i<- i + 1; // i = 73
	empleado[i,0] <- '173'; empleado[i,1] <-'Georg';empleado[i,2] <-'Friedrich Bernhard';empleado[i,3] <-'Riemann';
	empleado[i,4] <-'Martín Fierro 574';empleado[i,5] <-'48';empleado[i,6] <-'Alemana';
	i<- i + 1; // i = 74
	empleado[i,0] <- '174'; empleado[i,1] <-'Carl';empleado[i,2] <-'Friedrich';empleado[i,3] <-'Gauss';
	empleado[i,4] <-'1 de MAyo 582';empleado[i,5] <-'21';empleado[i,6] <-'Alemana';
	i<- i + 1; // i = 75
	empleado[i,0] <- '175'; empleado[i,1] <-'Leonhard';empleado[i,2] <-'Paul';empleado[i,3] <-'Euler';
	empleado[i,4] <-'Jujuy 485';empleado[i,5] <-'32';empleado[i,6] <-'Suiza';
	i<- i + 1; // i = 76
	empleado[i,0] <- '176'; empleado[i,1] <-'Linus';empleado[i,2] <-'Benedict';empleado[i,3] <-'Torvalds';
	empleado[i,4] <-'Alvear 162';empleado[i,5] <-'59';empleado[i,6] <-'Finlandesa';
	i<- i + 1; // i = 77
	empleado[i,0] <- '177'; empleado[i,1] <-'Anders';empleado[i,2] <-'';empleado[i,3] <-'Hejlsberg';
	empleado[i,4] <-'Belgrano 185';empleado[i,5] <-'57';empleado[i,6] <-'Danesa';
	i<- i + 1; // i = 78
	empleado[i,0] <- '178'; empleado[i,1] <-'Timothy';empleado[i,2] <-'John';empleado[i,3] <-'Berners-Lee';
	empleado[i,4] <-'Salta 685';empleado[i,5] <-'72';empleado[i,6] <-'Británica';
	i<- i + 1; // i = 79
	empleado[i,0] <- '179'; empleado[i,1] <-'Donald';empleado[i,2] <-'Ervin';empleado[i,3] <-'Knuth';
	empleado[i,4] <-'Santa Fe 384';empleado[i,5] <-'80';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 80
	empleado[i,0] <- '180'; empleado[i,1] <-'Paul';empleado[i,2] <-'Marie';empleado[i,3] <-'Ghislain Otlet';
	empleado[i,4] <-'Jacinta del Coro 387';empleado[i,5] <-'82';empleado[i,6] <-'Belga';
	i<- i + 1; // i = 81
	empleado[i,0] <- '181'; empleado[i,1] <-'Leonard';empleado[i,2] <-'';empleado[i,3] <-'Kleinrock';
	empleado[i,4] <-'San Lorenzo 831';empleado[i,5] <-'75';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 82
	empleado[i,0] <- '182'; empleado[i,1] <-'Joseph';empleado[i,2] <-'Carl';empleado[i,3] <-'Robnett Licklider';
	empleado[i,4] <-'Mendoza 685';empleado[i,5] <-'64';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 83
	empleado[i,0] <- '183'; empleado[i,1] <-'Robert';empleado[i,2] <-'William';empleado[i,3] <-'Taylor';
	empleado[i,4] <-'Mendoza 525';empleado[i,5] <-'85';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 84
	empleado[i,0] <- '184'; empleado[i,1] <-'Lawrence';empleado[i,2] <-'G.';empleado[i,3] <-'Roberts';
	empleado[i,4] <-'Catamarca 645';empleado[i,5] <-'54';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 85
	empleado[i,0] <- '185'; empleado[i,1] <-'Barry';empleado[i,2] <-'D.';empleado[i,3] <-'Wessler';
	empleado[i,4] <-'Juana Azurduy 121';empleado[i,5] <-'61';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 86
	empleado[i,0] <- '186'; empleado[i,1] <-'Raymond';empleado[i,2] <-'Samuel';empleado[i,3] <-'Tomlinson';
	empleado[i,4] <-'';empleado[i,5] <-'54';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 87
	empleado[i,0] <- '187'; empleado[i,1] <-'Augusta';empleado[i,2] <-'Ada';empleado[i,3] <-'Lovelace';
	empleado[i,4] <-'Belgrano 1323';empleado[i,5] <-'26';empleado[i,6] <-'Británica';
	i<- i + 1; // i = 88
	empleado[i,0] <- '188'; empleado[i,1] <-'Ronald';empleado[i,2] <-'Lewis';empleado[i,3] <-'Graham';
	empleado[i,4] <-'Güemes 425';empleado[i,5] <-'54';empleado[i,6] <-'Estadounidense';
	i<- i + 1; // i = 89
	empleado[i,0] <- '189'; empleado[i,1] <-'Oren';empleado[i,2] <-'';empleado[i,3] <-'Patashnik';
	empleado[i,4] <-'San MArtín 495';empleado[i,5] <-'62';empleado[i,6] <-'Estadounidense';
	
FinSubProceso

subproceso cargaMatrizPlanesDePago(planesDePago)
	
	Definir i Como Entero;
	i<-0;
	planesDePago[i,0] <- '101'; planesDePago[i,1] <-'5000';planesDePago[i,2] <-'18';
	i<-i+1;
	planesDePago[i,0] <- '102'; planesDePago[i,1] <-'10000';planesDePago[i,2] <-'10';
	i<-i+1;
	planesDePago[i,0] <- '103'; planesDePago[i,1] <-'8000';planesDePago[i,2] <-'16';
	
FinSubProceso	

// código grupo 2

SubProceso  cargaMatrizRepuestos(repuestos) //Subproceso para cargar los repuestos
	Definir i como Entero;
	i<-0;        // i = 0
	repuestos[i,0] <- '100123987'; repuestos[i,1] <-'optica';repuestos[i,2] <-'fiat';repuestos[i,3] <-'palio';
	repuestos[i,4] <-'15000';repuestos[i,5] <-'5';
	i<- i + 1;  // i = 1
	repuestos[i,0] <- '100034532'; repuestos[i,1] <-'bujia';repuestos[i,2] <-'bosch';repuestos[i,3] <-'bosch';
	repuestos[i,4] <-'1000';repuestos[i,5] <-'50';
	i<- i + 1; // i = 2
	repuestos[i,0] <- '132453644'; repuestos[i,1] <-'tasa';repuestos[i,2] <-'volkswagen';repuestos[i,3] <-'polo';
	repuestos[i,4] <-'1500';repuestos[i,5] <-'54';
	i<- i + 1; // i = 3	
	repuestos[i,0]	<- '132453646'; repuestos[i,1]<-'tasa';repuestos[i,2]<-'ford';repuestos[i,3]<-'focus';
	repuestos[i,4]	<- '1502'; repuestos[i,5]<-'54';
	i<- i + 1; // i = 4	
	repuestos[i,0]	<- '132453645'; repuestos[i,1]<-'optica';repuestos[i,2]<-'fiat';repuestos[i,3]<-'uno';
	repuestos[i,4]	<- '1501'; repuestos[i,5]<-'55';
	i<- i + 1; // i = 5	
	repuestos[i,0]	<- '132453644'; repuestos[i,1]<-'espejo';repuestos[i,2]<-'volkswagen';repuestos[i,3]<-'polo';
	repuestos[i,4]	<- '1502'; repuestos[i,5]<-'56';
	i<- i + 1; // i = 6	
	repuestos[i,0]	<- '132453647'; repuestos[i,1]<-'ruleman';repuestos[i,2]<-'toyota';repuestos[i,3]<-'corolla';
	repuestos[i,4]	<- '1503'; repuestos[i,5]<-'57'; 
	i<- i + 1; // i = 7	
	repuestos[i,0]	<- '132453648'; repuestos[i,1]<-'radiador';repuestos[i,2]<-'cheery';repuestos[i,3]<-'d2';
	repuestos[i,4]	<- '1504'; repuestos[i,5]<-'58';
	i<- i + 1; // i = 8	
	repuestos[i,0]	<- '132453649'; repuestos[i,1]<-'manguera de aire';repuestos[i,2]<-'renaul';repuestos[i,3]<-'clio';
	repuestos[i,4]	<- '1505'; repuestos[i,5]<-'59';
	i<- i + 1; // i = 9	
	repuestos[i,0]	<- '132453650'; repuestos[i,1]<-'bujia';repuestos[i,2]<-'peugeot';repuestos[i,3]<-'207 gti';
	repuestos[i,4]	<- '1506'; repuestos[i,5]<-'60';
	i<- i + 1; // i = 10	
	repuestos[i,0]	<- '132453651'; repuestos[i,1]<-'catalizador';repuestos[i,2]<-'citroen';repuestos[i,3]<-'13 v';
	repuestos[i,4]	<- '1507'; repuestos[i,5]<-'61';
	i<- i + 1; // i = 11	
	repuestos[i,0]	<- '132453652'; repuestos[i,1]<-'bomba de agua';repuestos[i,2]<-'honda';repuestos[i,3]<-'civic';
	repuestos[i,4]	<- '1508'; repuestos[i,5]<-'62';
	i<- i + 1; // i = 12	
	repuestos[i,0]	<- '132453653'; repuestos[i,1]<-'embriague';repuestos[i,2]<-'nissan';repuestos[i,3]<-'estrada';
	repuestos[i,4]	<- '1509'; repuestos[i,5]<-'63';
	i<- i + 1; // i = 13	
	repuestos[i,0]	<- '132453654'; repuestos[i,1]<-'luneta';repuestos[i,2]<-'mercedez benz';repuestos[i,3]<-'c200';
	repuestos[i,4]	<- '1510'; repuestos[i,5]<-'64';
	i<- i + 1; // i = 14	
	repuestos[i,0]	<- '132453655'; repuestos[i,1]<-'amortiguador';repuestos[i,2]<-'suzuki';repuestos[i,3]<-'fan';
	repuestos[i,4]	<- '1511'; repuestos[i,5]<-'65';
	i<- i + 1; // i = 15	
	repuestos[i,0]	<- '132453656'; repuestos[i,1]<-'extremo';repuestos[i,2]<-'audi';repuestos[i,3]<-'a4';
	repuestos[i,4]	<- '1512'; repuestos[i,5]<-'66';
	i<- i + 1; // i = 16	
	repuestos[i,0]	<- '132453657'; repuestos[i,1]<-'buje';repuestos[i,2]<-'tata';repuestos[i,3]<-'punch';
	repuestos[i,4]	<- '1513'; repuestos[i,5]<-'67';
	i<- i + 1; // i = 17	
	repuestos[i,0]	<- '132453658'; repuestos[i,1]<-'cable de bujia';repuestos[i,2]<-'volvo';repuestos[i,3]<-'xc 90';
	repuestos[i,4]	<- '1514'; repuestos[i,5]<-'68';
	i<- i + 1; // i = 18	
	repuestos[i,0]	<- '132453659'; repuestos[i,1]<-'alternador';repuestos[i,2]<-'iveco';repuestos[i,3]<-'camion';
	repuestos[i,4]	<- '1515'; repuestos[i,5]<-'69';
	i<- i + 1; // i = 19	
	repuestos[i,0]	<- '132453660'; repuestos[i,1]<-'llanta';repuestos[i,2]<-'bmw';repuestos[i,3]<-'328';
	repuestos[i,4]	<- '1516'; repuestos[i,5]<-'70';
	i<- i + 1; // i = 20	
	repuestos[i,0]	<- '132453661'; repuestos[i,1]<-'espiral';repuestos[i,2]<-'daewoo';repuestos[i,3]<-'poli';
	repuestos[i,4]	<- '1517'; repuestos[i,5]<-'71';
	i<- i + 1; // i = 21	
	repuestos[i,0]	<- '132453662'; repuestos[i,1]<-'casoleta';repuestos[i,2]<-'mazda';repuestos[i,3]<-'centra';
	repuestos[i,4]	<- '1518'; repuestos[i,5]<-'72';
	i<- i + 1; // i = 22	
	repuestos[i,0]	<- '132453663'; repuestos[i,1]<-'maza';repuestos[i,2]<-'mini cooper';repuestos[i,3]<-'mini cooper';
	repuestos[i,4]	<- '1519'; repuestos[i,5]<-'73';
	i<- i + 1; // i = 23	
	repuestos[i,0]	<- '132453664'; repuestos[i,1]<-'turbo';repuestos[i,2]<-'mitsubishi';repuestos[i,3]<-'eclipse';
	repuestos[i,4]	<- '1520'; repuestos[i,5]<-'74';
	i<- i + 1; // i = 24	
	repuestos[i,0]	<- '132453665'; repuestos[i,1]<-'piston';repuestos[i,2]<-'seat';repuestos[i,3]<-'ibiza';
	repuestos[i,4]	<- '1521'; repuestos[i,5]<-'75';
	i<- i + 1; // i = 25	
	repuestos[i,0]	<- '132453666'; repuestos[i,1]<-'metales';repuestos[i,2]<-'dacia';repuestos[i,3]<-'dacia';
	repuestos[i,4]	<- '1522'; repuestos[i,5]<-'76';
	i<- i + 1; // i = 26	
	repuestos[i,0]	<- '132453667'; repuestos[i,1]<-'block';repuestos[i,2]<-'ferrari';repuestos[i,3]<-'spider';
	repuestos[i,4]	<- '1523'; repuestos[i,5]<-'77';
	i<- i + 1; // i = 27	
	repuestos[i,0]	<- '132453668'; repuestos[i,1]<-'tapa de valvula';repuestos[i,2]<-'porche';repuestos[i,3]<-'carrera 911';
	repuestos[i,4]	<- '1524'; repuestos[i,5]<-'78';
	i<- i + 1; // i = 28	
	repuestos[i,0]	<- '132453669'; repuestos[i,1]<-'correa';repuestos[i,2]<-'hummer';repuestos[i,3]<-'c3';
	repuestos[i,4]	<- '1525'; repuestos[i,5]<-'79';
	i<- i + 1; // i = 29	
	repuestos[i,0]	<- '132453670'; repuestos[i,1]<-'termostato';repuestos[i,2]<-'jaguar';repuestos[i,3]<-'x3';
	repuestos[i,4]	<- '1526'; repuestos[i,5]<-'80';
	i<- i + 1; // i = 30	
	repuestos[i,0]	<- '132453671'; repuestos[i,1]<-'fusible';repuestos[i,2]<-'opel';repuestos[i,3]<-'tracker';
	repuestos[i,4]	<- '1527'; repuestos[i,5]<-'81';
	i<- i + 1; // i = 31	
	repuestos[i,0]	<- '132453672'; repuestos[i,1]<-'fusilera';repuestos[i,2]<-'rolls roys';repuestos[i,3]<-'phantom';
	repuestos[i,4]	<- '1528'; repuestos[i,5]<-'82';
	i<- i + 1; // i = 32	
	repuestos[i,0]	<- '132453673'; repuestos[i,1]<-'disco de freno';repuestos[i,2]<-'scania';repuestos[i,3]<-'x6';
	repuestos[i,4]	<- '1529'; repuestos[i,5]<-'83';
	i<- i + 1; // i = 33	
	repuestos[i,0]	<- '132453674'; repuestos[i,1]<-'diferencial';repuestos[i,2]<-'chevrolet';repuestos[i,3]<-'camaro';
	repuestos[i,4]	<- '1530'; repuestos[i,5]<-'84';
	i<- i + 1; // i = 34	
	repuestos[i,0]	<- '132453675'; repuestos[i,1]<-'engranajes';repuestos[i,2]<-'rover';repuestos[i,3]<-'rover';
	repuestos[i,4]	<- '1531'; repuestos[i,5]<-'85';
	i<- i + 1; // i = 35	
	repuestos[i,0]	<- '1324536123'; repuestos[i,1]<-'tasa';repuestos[i,2]<-'ford';repuestos[i,3]<-'focus';
	repuestos[i,4]	<- '1502'; repuestos[i,5]<-'54';
	i<- i + 1; // i = 36	
	repuestos[i,0]	<- '132453645'; repuestos[i,1]<-'optica';repuestos[i,2]<-'fiat';repuestos[i,3]<-'uno';
	repuestos[i,4]	<- '1502'; repuestos[i,5]<-'87';
	i<- i + 1; // i = 37	
	repuestos[i,0]	<- '132453647'; repuestos[i,1]<-'espejo';repuestos[i,2]<-'volkswagen';repuestos[i,3]<-'polo';
	repuestos[i,4]	<- '1503'; repuestos[i,5]<-'88';
	i<- i + 1; // i = 38	
	repuestos[i,0]	<- '132453648'; repuestos[i,1]<-'ruleman';repuestos[i,2]<-'toyota';repuestos[i,3]<-'corolla';
	repuestos[i,4]	<- '1504'; repuestos[i,5]<-'89';
	i<- i + 1; // i = 39	
	repuestos[i,0]	<- '132453649'; repuestos[i,1]<-'radiador';repuestos[i,2]<-'cheery';repuestos[i,3]<-'d3';
	repuestos[i,4]	<- '1505'; repuestos[i,5]<-'90';
	i<- i + 1; // i = 40	
	repuestos[i,0]	<- '132453650'; repuestos[i,1]<-'manguera de aire';repuestos[i,2]<-'renaul';repuestos[i,3]<-'clio';
	repuestos[i,4]	<- '1506'; repuestos[i,5]<-'91';
	i<- i + 1; // i = 41	
	repuestos[i,0]	<- '132453651'; repuestos[i,1]<-'bujia';repuestos[i,2]<-'peugeot';repuestos[i,3]<-'208 gti';
	repuestos[i,4]	<- '1507'; repuestos[i,5]<-'92';
	i<- i + 1; // i = 42	
	repuestos[i,0]	<- '132453652'; repuestos[i,1]<-'catalizador';repuestos[i,2]<-'citroen';repuestos[i,3]<-'14 v';
	repuestos[i,4]	<- '1508'; repuestos[i,5]<-'93';
	i<- i + 1; // i = 43	
	repuestos[i,0]	<- '132453653'; repuestos[i,1]<-'bomba de agua';repuestos[i,2]<-'honda';repuestos[i,3]<-'civic';
	repuestos[i,4]	<- '1509'; repuestos[i,5]<-'94';
	i<- i + 1; // i = 44	
	repuestos[i,0]	<- '132453654'; repuestos[i,1]<-'embriague';repuestos[i,2]<-'nissan';repuestos[i,3]<-'estrada';
	repuestos[i,4]	<- '1510'; repuestos[i,5]<-'95';
	i<- i + 1; // i = 45	
	repuestos[i,0]	<- '132453655'; repuestos[i,1]<-'luneta';repuestos[i,2]<-'mercedez benz';repuestos[i,3]<-'c201';
	repuestos[i,4]	<- '1511'; repuestos[i,5]<-'96';
	i<- i + 1; // i = 46	
	repuestos[i,0]	<- '132453656'; repuestos[i,1]<-'amortiguador';repuestos[i,2]<-'suzuki';repuestos[i,3]<-'fan';
	repuestos[i,4]	<- '1512'; repuestos[i,5]<-'97';
	i<- i + 1; // i = 47	
	repuestos[i,0]	<- '132453657'; repuestos[i,1]<-'extremo';repuestos[i,2]<-'audi';repuestos[i,3]<-'a5';
	repuestos[i,4]	<- '1513'; repuestos[i,5]<-'98';
	i<- i + 1; // i = 48	
	repuestos[i,0]	<- '132453658'; repuestos[i,1]<-'buje';repuestos[i,2]<-'tata';repuestos[i,3]<-'punch';
	repuestos[i,4]	<- '1514'; repuestos[i,5]<-'99';
	i<- i + 1; // i = 49	
	repuestos[i,0]	<- '132453659'; repuestos[i,1]<-'cable de bujia';repuestos[i,2]<-'volvo';repuestos[i,3]<-'xc 91';
	repuestos[i,4]	<- '1515'; repuestos[i,5]<-'100';
	i<- i + 1; // i = 50	
	repuestos[i,0]	<- '132453660'; repuestos[i,1]<-'alternador';repuestos[i,2]<-'iveco';repuestos[i,3]<-'camion';
	repuestos[i,4]	<- '1516'; repuestos[i,5]<-'101';
	i<- i + 1; // i = 51	
	repuestos[i,0]	<- '132453661'; repuestos[i,1]<-'llanta';repuestos[i,2]<-'bmw';repuestos[i,3]<-'329';
	repuestos[i,4]	<- '1517'; repuestos[i,5]<-'102';
	i<- i + 1; // i = 52	
	repuestos[i,0]	<- '132453662'; repuestos[i,1]<-'espiral';repuestos[i,2]<-'daewoo';repuestos[i,3]<-'poli';
	repuestos[i,4]	<- '1518'; repuestos[i,5]<-'103';
	i<- i + 1; // i = 53	
	repuestos[i,0]	<- '132453663'; repuestos[i,1]<-'casoleta';repuestos[i,2]<-'mazda';repuestos[i,3]<-'centra';
	repuestos[i,4]	<- '1519'; repuestos[i,5]<-'104';
	i<- i + 1; // i = 54	
	repuestos[i,0]	<- '132453664'; repuestos[i,1]<-'maza';repuestos[i,2]<-'mini cooper';repuestos[i,3]<-'mini cooper';
	repuestos[i,4]	<- '1520'; repuestos[i,5]<-'105';
	i<- i + 1; // i = 55	
	repuestos[i,0]	<- '132453665'; repuestos[i,1]<-'turbo';repuestos[i,2]<-'mitsubishi';repuestos[i,3]<-'eclipse';
	repuestos[i,4]	<- '1521'; repuestos[i,5]<-'106';
	i<- i + 1; // i = 56	
	repuestos[i,0]	<- '132453666'; repuestos[i,1]<-'piston';repuestos[i,2]<-'seat';repuestos[i,3]<-'ibiza';
	repuestos[i,4]	<- '1522'; repuestos[i,5]<-'107';
	i<- i + 1; // i = 57	
	repuestos[i,0]	<- '132453667'; repuestos[i,1]<-'metales';repuestos[i,2]<-'dacia';repuestos[i,3]<-'dacia';
	repuestos[i,4]	<- '1523'; repuestos[i,5]<-'108';
	i<- i + 1; // i = 58	
	repuestos[i,0]	<- '132453668'; repuestos[i,1]<-'block';repuestos[i,2]<-'ferrari';repuestos[i,3]<-'spider';
	repuestos[i,4]	<- '1524'; repuestos[i,5]<-'109';
	i<- i + 1; // i = 59	
	repuestos[i,0]	<- '132453669'; repuestos[i,1]<-'tapa de valvula';repuestos[i,2]<-'porche';repuestos[i,3]<-'carrera 912';
	repuestos[i,4]	<- '1525'; repuestos[i,5]<-'110';
	i<- i + 1; // i = 60	
	repuestos[i,0]	<- '132453670'; repuestos[i,1]<-'correa';repuestos[i,2]<-'hummer';repuestos[i,3]<-'c4';
	repuestos[i,4]	<- '1526'; repuestos[i,5]<-'111';
	i<- i + 1; // i = 61	
	repuestos[i,0]	<- '132453671'; repuestos[i,1]<-'termostato';repuestos[i,2]<-'jaguar';repuestos[i,3]<-'x4';
	repuestos[i,4]	<- '1527'; repuestos[i,5]<-'112';
	i<- i + 1; // i = 62	
	repuestos[i,0]	<- '132453672'; repuestos[i,1]<-'fusible';repuestos[i,2]<-'opel';repuestos[i,3]<-'tracker';
	repuestos[i,4]	<- '1528'; repuestos[i,5]<-'113';
	i<- i + 1; // i = 63	
	repuestos[i,0]	<- '132453673'; repuestos[i,1]<-'fusilera';repuestos[i,2]<-'rolls roys';repuestos[i,3]<-'phantom';
	repuestos[i,4]	<- '1529'; repuestos[i,5]<-'114';
	i<- i + 1; // i = 64	
	repuestos[i,0]	<- '132453674'; repuestos[i,1]<-'disco de freno';repuestos[i,2]<-'scania';repuestos[i,3]<-'x7';
	repuestos[i,4]	<- '1530'; repuestos[i,5]<-'115';
	i<- i + 1; // i = 65	
	repuestos[i,0]	<- '132453675'; repuestos[i,1]<-'diferencial';repuestos[i,2]<-'chevrolet';repuestos[i,3]<-'camaro';
	repuestos[i,4]	<- '1531'; repuestos[i,5]<-'116';
	i<- i + 1; // i = 66	
	repuestos[i,0]	<- '132453676'; repuestos[i,1]<-'engranajes';repuestos[i,2]<-'rover';repuestos[i,3]<-'rover';
	repuestos[i,4]	<- '1532'; repuestos[i,5]<-'117';
	i<- i + 1; // i = 67	
	repuestos[i,0]	<- '132453646'; repuestos[i,1]<-'tasa';repuestos[i,2]<-'ford';repuestos[i,3]<-'focus';
	repuestos[i,4]	<- '1502'; repuestos[i,5]<-'118';
	i<- i + 1; // i = 68	
	repuestos[i,0]	<- '132453647'; repuestos[i,1]<-'optica';repuestos[i,2]<-'fiat';repuestos[i,3]<-'uno';
	repuestos[i,4]	<- '1503'; repuestos[i,5]<-'119';
	i<- i + 1; // i = 69	
	repuestos[i,0]	<- '132453648'; repuestos[i,1]<-'espejo';repuestos[i,2]<-'volkswagen';repuestos[i,3]<-'polo';
	repuestos[i,4]	<- '1504'; repuestos[i,5]<-'120';
	i<- i + 1; // i = 70	
	repuestos[i,0]	<- '132453649'; repuestos[i,1]<-'ruleman';repuestos[i,2]<-'toyota';repuestos[i,3]<-'corolla';
	repuestos[i,4]	<- '1505'; repuestos[i,5]<-'121';
	i<- i + 1; // i = 71	
	repuestos[i,0]	<- '132453650'; repuestos[i,1]<-'radiador';repuestos[i,2]<-'cheery';repuestos[i,3]<-'d4';
	repuestos[i,4]	<- '1506'; repuestos[i,5]<-'122';
	i<- i + 1; // i = 72	
	repuestos[i,0]	<- '132453651'; repuestos[i,1]<-'manguera de aire';repuestos[i,2]<-'renaul';repuestos[i,3]<-'clio';
	repuestos[i,4]	<- '1507'; repuestos[i,5]<-'123';
	i<- i + 1; // i = 73	
	repuestos[i,0]	<- '132453652'; repuestos[i,1]<-'bujia';repuestos[i,2]<-'peugeot';repuestos[i,3]<-'209 gti';
	repuestos[i,4]	<- '1508'; repuestos[i,5]<-'124';
	i<- i + 1; // i = 74	
	repuestos[i,0]	<- '132453653'; repuestos[i,1]<-'catalizador';repuestos[i,2]<-'citroen';repuestos[i,3]<-'15 v';
	repuestos[i,4]	<- '1509'; repuestos[i,5]<-'125';
	i<- i + 1; // i = 75	
	repuestos[i,0]	<- '132453654'; repuestos[i,1]<-'bomba de agua';repuestos[i,2]<-'honda';repuestos[i,3]<-'civic';
	repuestos[i,4]	<- '1510'; repuestos[i,5]<-'126';
	i<- i + 1; // i = 76	
	repuestos[i,0]	<- '132453655'; repuestos[i,1]<-'embriague';repuestos[i,2]<-'nissan';repuestos[i,3]<-'estrada';
	repuestos[i,4]	<- '1511'; repuestos[i,5]<-'127';
	i<- i + 1; // i = 77	
	repuestos[i,0]	<- '132453656'; repuestos[i,1]<-'luneta';repuestos[i,2]<-'mercedez benz';repuestos[i,3]<-'c202';
	repuestos[i,4]	<- '1512'; repuestos[i,5]<-'128';
	i<- i + 1; // i = 78	
	repuestos[i,0]	<- '132453657'; repuestos[i,1]<-'amortiguador';repuestos[i,2]<-'suzuki';repuestos[i,3]<-'fan';
	repuestos[i,4]	<- '1513'; repuestos[i,5]<-'129';
	i<- i + 1; // i = 79	
	repuestos[i,0]	<- '132453658'; repuestos[i,1]<-'extremo';repuestos[i,2]<-'audi';repuestos[i,3]<-'a6';
	repuestos[i,4]	<- '1514'; repuestos[i,5]<-'130';
	i<- i + 1; // i = 80	
	repuestos[i,0]	<- '132453659'; repuestos[i,1]<-'buje';repuestos[i,2]<-'tata';repuestos[i,3]<-'punch';
	repuestos[i,4]	<- '1515'; repuestos[i,5]<-'131';
	i<- i + 1; // i = 81	
	repuestos[i,0]	<- '132453660'; repuestos[i,1]<-'cable de bujia';repuestos[i,2]<-'volvo';repuestos[i,3]<-'xc 92';
	repuestos[i,4]	<- '1516'; repuestos[i,5]<-'132';
	i<- i + 1; // i = 82	
	repuestos[i,0]	<- '132453661'; repuestos[i,1]<-'alternador';repuestos[i,2]<-'iveco';repuestos[i,3]<-'camion';
	repuestos[i,4]	<- '1517'; repuestos[i,5]<-'133';
	i<- i + 1; // i = 83	
	repuestos[i,0]	<- '132453662'; repuestos[i,1]<-'llanta';repuestos[i,2]<-'bmw';repuestos[i,3]<-'330';
	repuestos[i,4]	<- '1518'; repuestos[i,5]<-'134';
	i<- i + 1; // i = 84	
	repuestos[i,0]	<- '132453663'; repuestos[i,1]<-'espiral';repuestos[i,2]<-'daewoo';repuestos[i,3]<-'poli';
	repuestos[i,4]	<- '1519'; repuestos[i,5]<-'135';
	i<- i + 1; // i = 85	
	repuestos[i,0]	<- '132453664'; repuestos[i,1]<-'casoleta';repuestos[i,2]<-'mazda';repuestos[i,3]<-'centra';
	repuestos[i,4]	<- '1520'; repuestos[i,5]<-'136';
	i<- i + 1; // i = 86	
	repuestos[i,0]	<- '132453665'; repuestos[i,1]<-'maza';repuestos[i,2]<-'mini cooper';repuestos[i,3]<-'mini cooper';
	repuestos[i,4]	<- '1521'; repuestos[i,5]<-'137';
	i<- i + 1; // i = 87	
	repuestos[i,0]	<- '132453666'; repuestos[i,1]<-'turbo';repuestos[i,2]<-'mitsubishi';repuestos[i,3]<-'eclipse';
	repuestos[i,4]	<- '1522'; repuestos[i,5]<-'138';
	i<- i + 1; // i = 88	
	repuestos[i,0]	<- '132453667'; repuestos[i,1]<-'piston';repuestos[i,2]<-'seat';repuestos[i,3]<-'ibiza';
	repuestos[i,4]	<- '1523'; repuestos[i,5]<-'139';
	i<- i + 1; // i = 89	
	repuestos[i,0]	<- '132453668'; repuestos[i,1]<-'metales';repuestos[i,2]<-'dacia';repuestos[i,3]<-'dacia';
	repuestos[i,4]	<- '1524'; repuestos[i,5]<-'140';
	i<- i + 1; // i = 90	
	repuestos[i,0]	<- '132453669'; repuestos[i,1]<-'block';repuestos[i,2]<-'ferrari';repuestos[i,3]<-'spider';
	repuestos[i,4]	<- '1525'; repuestos[i,5]<-'141';
	i<- i + 1; // i = 91	
	repuestos[i,0]	<- '132453670'; repuestos[i,1]<-'tapa de valvula';repuestos[i,2]<-'porche';repuestos[i,3]<-'carrera 913';
	repuestos[i,4]	<- '1526'; repuestos[i,5]<-'142';
	i<- i + 1; // i = 92	
	repuestos[i,0]	<- '132453671'; repuestos[i,1]<-'correa';repuestos[i,2]<-'hummer';repuestos[i,3]<-'c5';
	repuestos[i,4]	<- '1527'; repuestos[i,5]<-'143';
	i<- i + 1; // i = 93	
	repuestos[i,0]	<- '132453672'; repuestos[i,1]<-'termostato';repuestos[i,2]<-'jaguar';repuestos[i,3]<-'x5';
	repuestos[i,4]	<- '1528'; repuestos[i,5]<-'144';
	i<- i + 1; // i = 94	
	repuestos[i,0]	<- '132453673'; repuestos[i,1]<-'fusible';repuestos[i,2]<-'opel';repuestos[i,3]<-'tracker';
	repuestos[i,4]	<- '1529'; repuestos[i,5]<-'145';
FinSubProceso

SubProceso cargaClientes(cliente Por Referencia)
	Definir i como  Entero;
	
	i<-0;
	cliente[i,0]	<- '12345678'; cliente[i,1]<-'Mateo Russo';
	
	i<- i + 1;
	cliente[i,0]	<- '43290210'; cliente[i,1]<-'Ana Franco';
	
	i<- i +1;
	cliente[i,0]	<- '39854121'; cliente[i,1]<-'Manuel Rosas';
	
	
FinSubProceso
// fín código grupo 2