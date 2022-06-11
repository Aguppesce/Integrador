Proceso Main
	Definir auto, empleado, repuestos, cliente, venta, paymentsPlan Como Cadena;
	Definir option Como Entero;
	Dimension auto[100,8], empleado[100,7], repuestos[100,6];
	Dimension cliente[100,2],venta[100,6],paymentsPlan[100,3];	
	
	
	//Fill all lists with zeros
	preSetCarList(auto);
	preSetEmployeeList(empleado);
	preSetSpareList(repuestos);
	preSetPaymentPlanList(paymentsPlan);
	preSetSalesList(venta);
	preSetCustomerList(cliente);
	
	//Fill lists with examples dates
	setCarList(auto);
	setEmployeeList(empleado);
	setSparesList(repuestos);
	setPaymenPlanList(paymentsPlan);
	setCustomersList(cliente);
	setSalesList(venta);	
	
	
	//Main menu____________________________________________________________________________________________________________________
	Repetir
		Limpiar Pantalla;
		baner();
		Escribir " ";
		Escribir "                    Bienvenido a Fast&will - Software de gestión de concesionarias";
		Escribir "*****************************************************************************************************";
		Escribir '';
		Escribir "Elija una opción para operar: ";
		Escribir '------------------------------';
		Escribir "Opción 0: Ventas";
		Escribir "Opción 1: Buscar";
		Escribir "Opción 2: Servicios de alquiler";
		Escribir "Opción 3: Carga de datos";
		Escribir "Opción 4: Compras";
		Escribir "Opción 5: Salír";
		Escribir '';
		Escribir Sin Saltar 'Ingrese opcion: '; 
		Leer option;
		Segun option Hacer
			0:
				doSale(cliente,auto,empleado,venta,paymentsPlan, repuestos);
			1:
				searchMenu(empleado, auto, cliente, repuestos, venta, paymentsPlan);
			2:
				serviceRental(cliente, auto, empleado);
			3:
				loadDataMenu(auto,empleado,repuestos,cliente,paymentsPlan);
			4:
				doBuyout(cliente,auto);
			5:	
			De Otro Modo: 
				Escribir "Ingrese una opción válida.";
		FinSegun
	Hasta Que option = 5;
	Escribir "Gracias por usar el software, regrese pronto.";
FinProceso

//SubProcess's____________________________________________________________________________________________________________________


SubProceso doSale(cliente,auto,empleado,venta,paymentsPlan, repuesto) //0
	Definir option, i Como Entero;
	Repetir
		Limpiar Pantalla;
		Escribir '         OPCIONES DE VENTA';
		Escribir '___________________________________';
		Escribir "0-Vehículo por marca.";
		Escribir "1-Planes de pago.";
		Escribir "2-Venta Auto.";
		Escribir "3-Venta Repuesto.";
		Escribir "4-Salir.";
		Leer option;
		Segun option Hacer
			0:
				carByBrand(auto);
			1:
				paymentPlan(paymentsPlan);
				Esperar Tecla;
			2: 
				finishSale(cliente,auto,empleado,venta,paymentsPlan); 
			3:
				sellSpare(repuesto, cliente, empleado);
			4:
			De Otro Modo:
				escribir "Dato no válido, intente nuevamente.";
		FinSegun
		Hasta Que	option = 4;
		Limpiar Pantalla;
FinSubProceso


SubProceso searchMenu(empleado, auto, cliente, repuesto, venta, planes) //1
	Definir option Como Entero;
	
	Repetir
		Limpiar Pantalla;
		Escribir '       REALIZAR UNA BUSQUEDA';
		Escribir '____________________________________';
		Escribir "0-Vehículos";
		Escribir "1-Empleados.";
		Escribir "2-Repuestos.";
		Escribir "3-Cliente";
		Escribir "4-Ventas";
		Escribir "5-Salír";
		Leer option;
		Segun option Hacer
			0:
				carMenu(auto);
			1:
				searchEmployeeMenu(empleado);
			2:
				sparesMenu(repuesto);
			3:
				searchCustomer(cliente);
			4:
				salesMenu(venta, planes, empleado);
			5:
			De Otro Modo:
				Escribir "Dato no válido, intente nuevamente.";
		FinSegun
		
	Hasta Que option = 5;
	Limpiar Pantalla;
FinSubProceso


SubProceso serviceRental(cliente, auto, empleado)
	
	Definir customerDni, idCar, pricePerHour, fileNum, currentDare,answ,enableCar Como Cadena;
	Definir customerIndex, carIndex, employeeIndex Como Entero;
	Definir customerExist Como Logico;
	
	//Flag that controls if customer exist in the list/array
	customerExist <- falso;
	Limpiar Pantalla;
	
	//Put the data of one existent customer or a new customer 
	Repetir
		Escribir '_____________________________________________________________________';
		escribir "Ingrese el DNI del cliente: ";
		leer customerDni;     
		customerIndex <- findById(cliente,customerDni);
		si customerIndex <> -1 entonces
			customerExist <- verdadero;
			Escribir 'Se encontro el cliente con id: ', customerDni;
		FinSi
	Hasta Que customerIndex = -1 o customerExist;
	
	// If not find the customer that put in the system, we load a new customer....
	si no customerExist entonces
		Escribir '_____________________________________________________________________';
		escribir "No se encontro al Cliente ";
		// Call to the sub process that it allow load a new customer
		loadNewCustomer(customerDni,cliente);
		// Get the new position that the new client will fill in the array: to retrieve the name and last name
		customerIndex <- findById(cliente,customerDni);
	FinSi
	
	
	// Pick the car for rental
	Escribir '_____________________________________________________________________';
	Escribir Sin Saltar "Ingrese el id del auto: ";
	Leer idCar;   
	
	// Flag that controls if the car picked it's enable
	enableCar <- 'true';
	// Obtain the position that the requested car occupies in the array/list
	carIndex <- findById(auto, idCar);
	
	Si carIndex <> -1 Entonces
		enableCar <- auto[carIndex, 7];
	FinSi
	
	answ  <- '1';
	
	Mientras carIndex = -1 o (enableCar = 'false' y answ = '1') Hacer
		Si enableCar = 'false' y carIndex <> -1 Entonces
			Escribir 'Auto no disponible';
		FinSI
		Si carIndex = -1  O answ = '1' Entonces
			Escribir Sin Saltar 'Vuelva a intentarlo. Ingrese el id del auto: ';
			Leer idCar;
			carIndex <- findById(auto, idCar);
			Si carIndex <> -1 Entonces
				enableCar <- auto[carIndex, 7];
			FinSi
		FinSi
		Repetir
			Escribir '¿Quiere buscar otro auto?';
			Escribir '1. Si';
			Escribir '2. No';
			Escribir Sin Saltar 'Ingrese opcion: ';
			Leer answ;
		Hasta Que answ = '1' o answ = '2'
	FinMientras
	
	//	Load the employee	
	
	
	Escribir '_____________________________________________________________________';
	Escribir Sin Saltar "Ingrese su número de legajo : ";
	leer fileNum;
	// Obtain the position that the requested employee occupies in the list/array, if it doesn't find it, it returns -1.
	employeeIndex <- findById(empleado, fileNum);
	Mientras employeeIndex = -1 Hacer
		Escribir 'Empleado no encontrado. Vuelva a intentarlo.';
		Escribir Sin Saltar "Ingrese su número de legajo: ";
		Leer fileNum;   
		employeeIndex <- findById(empleado,fileNum);
	FinMientras	
	
	
	//	Current date
	Escribir '_____________________________________________________________________';
	Escribir Sin Saltar "Ingrese fecha actual: ";
	Leer currentDare;
	
	// We get the price per hour of the requested car
	pricePerHour <- auto[carIndex, 6];
	
	
	// Change the status of the car to false / not available
	auto[carIndex,7] <- 'false';	
	
	
	barra('Alquiler');	
	
	
	Escribir '_____________________________________________________________________';
	Escribir '| Vendedor |  Id Auto |    DNI   | Precio por Hora |  Fecha Retiro  | ';
	Escribir '_____________________________________________________________________';
	Escribir '|    ', fileNum , '   |  ', idCar , '   |  ', customerDni ,' |      $', pricePerHour , '       |   ', currentDare, '   |';  
	Escribir '_____________________________________________________________________';
	
	
	Esperar Tecla;	
	
	
FinSubProceso

SubProceso loadDataMenu(auto,empleado,repuestos,cliente,paymentsPlan) //3
	Definir option Como Entero;
	Definir dni Como Cadena; 
	Repetir 
		Limpiar Pantalla;
		Escribir '      REALIZAR CARGA';
		Escribir '_______________________________';
		Escribir "1- Empleados.";
		Escribir "2- Repuestos.";
		Escribir "3- Nuevo Cliente.";
		Escribir "4- Cargar nuevo plan de pago.";
		Escribir "5- Cargar Auto";
		Escribir "6- Salír.";
		Leer option;
		Segun option Hacer
			0:
				setCar(auto); 
			1:
				setEmployees(empleado); 
			2:
				setSpares(repuestos); 
			3:
				setCustomer(cliente); 
			4: 
				setNewPaymentPlan(paymentsPlan); 
			5:	
				setCar(auto);
			6:
			De Otro Modo:
				Escribir "Dato no válido, intente nuevamente.";
		FinSegun
	Hasta Que option = 6;
FinSubProceso


SubProceso doBuyout(cliente, auto) //4
	//To make a purchase we need a client/supplier from whom we are going to buy
	//and the information of the car we bought
	Definir ok Como Cadena;
	//We load the client, if it exists we take its data
	setCustomer(cliente);
	//We load a new car
	setCar(auto);
	Escribir "Compra registrada con éxito.";
	Leer ok;
FinSubProceso


SubProceso carByBrand(auto)
	
	Definir brand, brandCar,results Como Cadena;
	Definir i,j , count, index Como Entero;
	
	Dimension results[100, 8];
	preSetCarList(results);
	count <- 0;
	
	Limpiar Pantalla;
	
	Escribir Sin Saltar'Ingrese marca a buscar: ';
	Leer brand;
	brand <- Minusculas(brand);
	
	Para i<-0 Hasta 99 Hacer
		
		brandCar <- auto[i,2];
		brandCar <- Minusculas(brandCar);
		
		Si auto[i,2] <> '0' Y brandCar = brand Entonces
			
			Para j <- 0 Hasta 7 Hacer
				results[count, j] <- auto[i,j];
			FinPara
			count <- count + 1;
		FinSi
		
	FinPara
	Si count <> 0 Entonces
		Limpiar Pantalla;
		Escribir 'Resultados encontrados: ', count, '.';
		Escribir '-----------------------------------------------------------------------------------------';
		mostrarAutos(results);
	SiNo
		Escribir 'No se encontraron resultados con marca: ' , brand;
	FinSi
	
	Leer brand;
	
FinSubProceso


SubProceso paymentPlan(paymentsPlan)
	Limpiar Pantalla;
	printPaymentsPlan(paymentsPlan);
FinSubProceso

SubProceso finishSale(cliente, auto, empleado, venta, paymentsPlan)
	
	// To make a sale we need:
	
	// ID number of the client, also his name and surname
	// Id of the car to sell
	// Seller's file number
	// Current date
	// Identifier of the payment plan, if necessary.
	
	// Finally with all the data we save the sale in the array
	
	
	Definir customerDni, fileNum, carId, currentDate, answPlan, answConfirmation, idPlan, carStatus,dni Como Cadena;
	Definir customerIndex, carIndex, employeeIndex, lastSale, planPago Como Entero;
	
	
	//Flags
	Definir customerExist, carEnable Como Logica;
	
	Limpiar Pantalla;
	
	customerExist <- Falso;
	
	// Load the client
	Repetir
		Escribir '_____________________________________________';
		Escribir "Ingrese el DNI del cliente: ";
		Leer customerDni;     
		customerIndex <- findById(cliente,customerDni);
		Si customerIndex <> -1 Entonces
			customerExist <- Verdadero;
			Escribir 'Se encontro el cliente con id: ', customerDni;
		FinSi
	Hasta Que customerIndex = -1 O customerExist;
	
	// If it does not find the client entered, we load a new client.
	Si No customerExist Entonces
		Escribir '_____________________________________________';
		Escribir "No se encontro al Cliente ";
		loadNewCustomer(customerDni,cliente);
		customerIndex <- findById(cliente,customerDni);
	FinSi
	
	// Load the car
	Escribir '_____________________________________________';
	Escribir Sin Saltar "Ingrese el id del auto: ";
	Leer carId;     
	carIndex <- findById(auto, carId);
	carEnable <- Falso;
	Mientras carIndex = -1 O No(carEnable) Hacer
		Si carIndex = -1 Entonces
			Escribir 'Auto no encontrado. Vuelva a intentarlo.';
			Escribir Sin Saltar "Ingrese el id del auto: ";
			Leer carId;
			carIndex <- findById(auto, carId);
		FinSi
		Si carIndex <> -1 Entonces
			carStatus <- auto[carIndex,7];
			// A status equal to 'false' means that the car has been sold or is rented
			Si carStatus = 'false' Entonces
				Escribir  Sin Saltar'El auto no esta disponible. Ingrese Otro.';
				Leer carId;  
				carIndex <- findById(auto, carId);
			SiNo
				carEnable <- Verdadero;
			FinSi
		FinSi
	FinMientras
	
	// Load employee file
	Escribir '_____________________________________________';
	Escribir Sin Saltar "Ingrese su número de legajo: ";
	Leer fileNum;     
	employeeIndex <- findById(empleado, fileNum);
	Mientras employeeIndex = -1 Hacer
		Escribir 'Empleado no encontrado. Vuelva a intentarlo.';
		Escribir Sin Saltar "Ingrese su número de legajo: ";
		Leer fileNum;   
		employeeIndex <- findById(empleado,fileNum);
	FinMientras
	
	Escribir '_____________________________________________';
	Escribir Sin Saltar "Ingrese fecha actual: ";
	Leer currentDate;
	Escribir '_____________________________________________';
	
	// Plan de Pago
	
	answPlan <- '0';
	Repetir
		Escribir '¿Quiere incluir un plan de pago? si/no';
		Escribir '1 . Si';
		Escribir '2 . No';
		Leer answPlan;
		answPlan <- Minusculas(answPlan);
	Hasta Que answPlan = '1' O answPlan = '0'
	
	idPlan<-'0';
	Si answPlan = '1' Entonces
		planPago <- addPlan(paymentsPlan);
		idPlan <- paymentsPlan[planPago,0];
	FinSi
	Escribir '---------------------------------------';
	Escribir '¿Confirmar la Venta?';
	Escribir  '1. Si';
	Escribir  '2. No';
	Leer answConfirmation;
	
	Si answConfirmation = '1' Entonces
		// We look for the index after the last sale made in order to enter the new sale.
		lastSale <- getLastIndex(venta);
		Si no (lastSale = -1) Entonces
			// We save the sale: File No., Dni, Name and Last name, date, Id (Car), payment plan.
			setSale(auto, venta,cliente,lastSale, fileNum,customerDni, customerIndex,currentDate,carIndex, planId);
			Escribir '_____________________________________________';
			Escribir 'Venta Realizada con exito.... ';
			printSaleById(venta, cliente, paymentsPlan, lastSale);
		SiNo
			Escribir 'No se pudo concretar la venta, la matriz Venta esta llena.';
		FinSi
		
	SiNo
		Escribir 'Venta cancelada. Presione cualquier tecla para salir ... ';
		Leer answConfirmation;
	FinSi
FinSubProceso

SubProceso sellSpare(repuesto, cliente, empleado)
	
	Limpiar Pantalla;
	Definir customerDni, fileNum, currentDate, dni, idSpare, stock, nameAndLastName Como Cadena;
	Definir customerIndex, employeeIndex, spareIndex, spareQuantity, numberStock Como Entero;
	Definir unitPrice, total Como Real;
	Definir existeRepuesto, customerExist Como Logico;
	
	customerExist <- falso;
	
	// Load customer
	
	Escribir '';
	Escribir '       VENTA DE REPUESTO:';
	Escribir '';
	Escribir '';
	
	
	Repetir
		Escribir '_____________________________________________';
		Escribir  Sin Saltar"Ingrese el DNI del cliente: ";
		Leer customerDni;     
		customerIndex <- findById(cliente,customerDni);
		Si customerIndex <> -1 Entonces
			customerExist <- Verdadero;
			Escribir 'Se encontro el cliente con id: ', customerDni;
		FinSi
	Hasta Que customerIndex = -1 o customerExist;
	
	// If it does not find the client entered, we load a new client..
	Si No customerExist Entonces
		Escribir '_____________________________________________';
		Escribir "No se encontro al Cliente ";
		loadNewCustomer(customerDni,cliente);
		customerIndex <- findById(cliente,customerDni);
	FinSi
	
	nameAndLastName <- cliente[customerIndex, 1];
	
	
	// Choose spare
	Escribir '_____________________________________________';
	Escribir Sin Saltar'Ingrese Id repuesto: ';
	Leer idSpare;  
	
	spareIndex <- findById(repuesto, idSpare);
	
	Mientras spareIndex = -1 Hacer
		Escribir 'Repuesto no encontrado. Vuelva a intentarlo.';
		escribir sin saltar "Ingrese Id repuesto: ";
		leer idSpare;   
		spareIndex <- findById(repuesto,idSpare);
	FinMientras
	
	printSpareById(repuesto,idSpare);
	
	// Enter the spare quantity..
	
	Escribir Sin Saltar'Ingrese unidades de repuestos: '; 
	Leer spareQuantity; 
	
	stock <- repuesto[spareIndex, 5]; 
	numberStock <- ConvertirANumero(stock); 
	numberStock <- numberStock - spareQuantity;
	
	unitPrice <- ConvertirANumero(repuesto[spareIndex, 4]);
	
	Si numberStock < 0 Entonces
		Escribir 'No hay stock.';
		Escribir 'Stock actual: ', repuesto[spareIndex, 5]; 
	FinSi
	Mientras numberStock < 0 Hacer
		Escribir 'Ingrese unidades de repuestos: '; 
		Leer spareQuantity;   
		numberStock <- numberStock - spareQuantity; 
	FinMientras
	
	repuesto[spareIndex, 5] <- ConvertirATexto(numberStock); 
	Escribir 'Stock restante: ', repuesto[spareIndex, 5]; 
	
	
	
	// Read spareQuantity;
	
	// Load vendor file
	
	Escribir '_____________________________________________';
	Escribir Sin Saltar "Ingrese su número de legajo: ";
	Leer fileNum;     
	employeeIndex <- findById(empleado, fileNum);
	Mientras employeeIndex = -1 Hacer
		Escribir 'Empleado no encontrado. Vuelva a intentarlo.';
		Escribir Sin Saltar "Ingrese su número de legajo: ";
		Leer fileNum;   
		employeeIndex <- findById(empleado,fileNum);
	FinMientras
	
	Escribir '_____________________________________________';
	Escribir Sin Saltar "Ingrese fecha actual: ";
	Leer currentDate;
	
	total <- unitPrice * spareQuantity;
	
	Escribir '______________________________________________________________________________________________________________________';
	
	Escribir ' | Num Legajo |     DNI    | Nombre y apellido |  Id Repuesto  | Precio Unitario | Cantidad |     Fecha     |  Total  |';
	Escribir '_______________________________________________________________________________________________________________________';
	Escribir '|     ', fileNum , '     |  ', customerDni, '  |   ', nameAndLastName, '    |   ' ,idSpare , '   |      $',unitPrice, '      |     ', spareQuantity, '    |   ', currentDate, '  |  $', total, '  |' ;
	Escribir '_______________________________________________________________________________________________________________________';
	Leer fileNum;
	
FinSubProceso

// Common Function's___________________________________________________________________________________

SubProceso idPosition <- findById(list, id)  // Search for column 0
	Definir i, idPosition Como Entero;
	Definir idLocated Como Logico;
	i<-0;
	idLocated<-Falso;
	Mientras i<=99 Y No(idLocated) Hacer
		Si No(list[i,0] = "0") Y (list[i,0] = id) Entonces
			idPosition <- i;
			idLocated<-Verdadero;
		FinSi
		i<-i+1;
	FinMientras
	Si No idLocated Entonces
		idPosition <- -1;
	FinSi
FinSubProceso

SubProceso index <- getLastIndex(list)
	Definir i,index Como Entero;
	Definir listFilled Como Logico;
	listFilled <- Verdadero;
	Para i<-0 Hasta 99 Hacer
		Si (list[i,0] = '0') Entonces
			index <- i;
			listFilled <- Falso;
		FinSi
	FinPara
	Si listFilled Entonces
		index <- -1;
	FinSi
FinSubProceso
// ___________________________________________________________________________________________________


SubProceso planPosition <- addPlan(paymentsPlan)
	Definir planPosition Como Entero;
	Definir idPlan Como Cadena;
	
	printPaymentsPlan(paymentsPlan);
	
	Escribir Sin Saltar'Ingresar Plan de Pago: ';
	Leer idPlan;
	planPosition <- findById(paymentsPlan, idPlan);
	Mientras planPosition = -1 Hacer
		Escribir '____________________________________________'; 
		Escribir 'Plan No encontrado.Vuelva a intentar. ';
		Escribir Sin Saltar'Ingresar Plan de Pago: ';
		Leer idPlan;
		planPosition <- findById(paymentsPlan, idPlan);
	FinMientras
	
	Escribir 'Plan encontrado con id: ', idPlan;
	Escribir 'Descripcion plan, Entrega: ', paymentsPlan[planPosition,1], ' , Cuotas: ',paymentsPlan[planPosition,2]; 
FinSubProceso

SubProceso findByEmployee(empleado)
	Definir option Como Entero;
	Limpiar Pantalla;
	Escribir '           BUSCAR EMPLEADOS';
	Escribir '_______________________________________';
	Repetir 
		Escribir "0-Mostrar todos los empleados.";
		Escribir "1-Buscar empleados por n° de legajo.";
		Escribir "2-Salír.";
		Leer option;
		Segun option Hacer
			0:
				printAllEmployees(empleado);
			1:
				findEmployeeFile(empleado);
			2:
				
			De Otro Modo:
				Escribir "Dato no válido, intente nuevamente.";
		FinSegun
	Hasta Que option = 2;
	Limpiar Pantalla;
FinSubProceso

// Search by ID___________________________________________________________________________________________________

SubProceso findSpareById(repuestos)
	Definir idSpare Como Cadena;
	Definir position Como Entero;
	Limpiar Pantalla;
	Escribir "Ingrese el id de repuesto que desea buscar.";
	Leer idSpare;
	position <- findById(repuestos,idSpare );
	Escribir '__________________________________________________________________________';
	Escribir '| Id de repuesto | Categoría |     Marca     |   Modelo | Precio | Stock |';
	Escribir '__________________________________________________________________________';
	Si position <> -1 Entonces 
		Escribir '|   ',repuestos[position,0], '    |    ', repuestos[position,1] ,'   |      ',repuestos[position,2],'     |   ',repuestos[position,3],'  |  ',repuestos[position,4], '  |   ',repuestos[position,5],'  | ';
	SiNo
		Escribir 'Repuesto no encontrado';
	FinSi
	Leer position;
FinSubProceso

SubProceso findCarById(auto)
	Definir idCar Como Cadena;
	Definir position Como Entero;
	Limpiar Pantalla;
	Escribir "Ingrese el id del vehiculo que desea buscar.";
	Leer idCar;
	position <- findById(auto,idCar );
	Escribir '---------------------------------------------------------------------------------------';
	Escribir '|   Id   |   Año  |  Marca  |  Modelo  |   Km   |  Precio  | Precio Alquiler | Estado |'; 
	Escribir '---------------------------------------------------------------------------------------';
	Si position <> -1 Entonces 
		Escribir '|  ',auto[position,0], ' |  ',auto[position,1], '  |  ', auto[position,2], '  |   ', auto[position,3], '  |  ', auto[position,4], ' |  ', auto[position,5], ' |       $', auto[position,6], '      |  ' , auto[position,7],'  |' ; 
		Escribir '---------------------------------------------------------------------------------------';
	SiNo
		
		Escribir 'Vehiculo no encontrado';
		Escribir '---------------------------------------------------------------------------------------';
	FinSi
	Leer position;
FinSubProceso

SubProceso findSaleByEmployee(venta, empleado, paymentsPlan)
	
	Definir i, j, posPaymentPlan, position Como Entero;
	Definir idPlan, delivery, dues, idEmployee,  employeeName, name, lastName Como Cadena;
	Limpiar Pantalla;
	
	Escribir sin saltar 'Ingrese Id Vendedor: ';
	Leer idEmployee;
	position <- findById(empleado, idEmployee);
	
	name <- Concatenar(empleado[position,1], ' ');
	
	lastName <- empleado[position,3];
	
	employeeName <- Concatenar(name,lastName);
	
	Si position <> -1 Entonces
		Escribir '_______________________________';
		Escribir '| N° Legajo | Nombre Vendedor |';
		Escribir '-------------------------------';
		Escribir  '|    ', idEmployee,  '    |   ',  employeeName, '  |';
		Escribir '-------------------------------';
		Escribir '_____________________________________________________________________________';
		Escribir '|    DNI   |  Nombre y Apellido |     Fecha    | Id Auto | Entrega | Cuotas |';
		Para i<-0 Hasta 99 Hacer
			
			Si No(venta[i,0] = '0')  y venta[i, 0] = idEmployee Entonces
				idPlan <- venta[i,5];
				Si idPlan <> '0' Entonces
					posPaymentPlan <- findById(paymentsPlan, idPlan);
					delivery <- paymentsPlan[posPaymentPlan, 1];
					dues <- paymentsPlan[posPaymentPlan, 2];
					Escribir '_____________________________________________________________________________';
					Escribir  '| ', venta[i,1] , ' |     ', venta[i,2] , '    |   ', venta[i,3], ' |  ', venta[i,4] , '  | ', delivery, '   |   ', dues, '   |';
				SiNo
					Escribir '_____________________________________________________________________________';
					Escribir  '| ', venta[i,1] , ' |   ', venta[i,2] , '      |  ', venta[i,3], ' |  ', venta[i,4] , '  | Sin Plan';
				FinSi
				
			FinSi
		FinPara
		Escribir '_____________________________________________________________________________';
	SiNo
		Escribir 'Vendedor no encontrado';
	FinSi
	leer i;
	
FinSubProceso

SubProceso findEmployeeFile(empleado)
	Definir fileNum Como Cadena;
	Definir position Como Entero;
	Limpiar Pantalla;
	Escribir Sin Saltar"Ingrese el n° de legajo que desea buscar.";
	Leer filenum;
	position <- findById(empleado, fileNum);
	Escribir '______________________________________________________________________________________';
	Escribir "| N° de legajo | Nombre | Nombre 2 | Apellido |    Dirección   | Edad | Nacionalidad |";
	Escribir '______________________________________________________________________________________';
	Si position <> -1 Entonces 
		Si empleado[position,2]  = '' Entonces
			Escribir '|      ',empleado[position,0], '     |  ', empleado[position,1] ,' |  ------- |  ',empleado[position,3],'  | ',empleado[position,4], ' |  ',empleado[position,5],'  |   ',empleado[position,6], '  |';
		SiNo
			Escribir '|      ',empleado[position,0], '     |  ', empleado[position,1] ,' |  ',empleado[position,2],'  | ',empleado[position,3],' | ',empleado[position,4], ' | ',empleado[position,5],' | ',empleado[position,6], ' |';
		FinSi
		Escribir '______________________________________________________________________________________';
	Sino
		Escribir 'Empleado no encontrado';
	FinSi
	Leer filenum;
FinSubProceso

SubProceso serviceCar(auto)
	Definir option Como Entero;
	Repetir
		Limpiar Pantalla;
		Escribir '         BUSCAR VEHICULO';
		Escribir '___________________________________';
		Escribir "0-Ver vehiculos disponibles.";
		Escribir "1-Buscar vehiculo por id.";
		Escribir "2-Salir.";
		Leer option;
		Segun option Hacer
			0:
				availableCar(auto);
			1:
				findCarById(auto);
			2:
				
			De Otro Modo:
				Escribir "Dato no válido, intente nuevamente.";
		FinSegun
		Hasta Que	option = 2;
		Limpiar Pantalla;
		
FinSubProceso

SubProceso servicesSpare(repuestos)
	Definir option Como Entero;
	Repetir
		Limpiar Pantalla;
		Escribir '         BUSCAR REPUESTO';
		Escribir '___________________________________';
		Escribir "0-Ver todos los repuestos.";
		Escribir "1-Buscar repuestos por id.";
		Escribir "2-Salir.";
		Leer option;
		Segun option Hacer
			0:
				printSpareList(repuestos);
			1:
				findSpareById(repuestos); // READY
			2:
				
			De Otro Modo:
				Escribir "Dato no válido, intente nuevamente.";
		FinSegun
		Hasta Que	option = 2;
		Limpiar Pantalla;
FinSubProceso


SubProceso serviceSales(venta, planes, empleado)
	Definir option Como Entero;
	Repetir
		Limpiar Pantalla;
		Escribir '         BUSCAR VENTA';
		Escribir '___________________________________';
		Escribir "0-Ver todas las ventas.";
		Escribir "1-Buscar venta por vendedor.";
		Escribir "2-Salir.";
		Leer option;
		Segun option Hacer
			0:
				printSalesList(venta,planes);
			1:
				findSaleByEmployee(venta, empleado, planes);
			2:
				
			De Otro Modo:
				Escribir "Dato no válido, intente nuevamente.";
		FinSegun
		Hasta Que	option = 2;
		Limpiar Pantalla;
FinSubProceso


SubProceso findCustomer(cliente)
	
	Definir idCustomer Como Cadena;
	Definir position Como Entero;
	
	Limpiar Pantalla;
	Escribir "Ingrese el id de cliente que desea buscar.";
	Leer idCustomer;
	position <- findById(cliente,idCustomer );
	Si position <> -1 Entonces 
		Escribir "___________________________";
		Escribir "| DNI | Nombre y Apellido |";
		Escribir "___________________________";
		Escribir '| ',cliente[position,0], ' |  ', cliente[position,1] ,' | ';
	SiNo
		Escribir 'Cliente no encontrado';
	FinSi
	Leer position;
FinSubProceso

// Single load___________________________________________________________________________________________________

SubProceso setCar(auto)
	Definir id, year, brand, model, km, price, pricePerHour Como Cadena;
	Definir index Como Entero;
	Limpiar Pantalla;
	Escribir '      Alta de Nuevo Auto';
	Escribir '________________________________';
	Escribir Sin Saltar"Ingrese id de auto: ";
	Leer id;
	Escribir Sin Saltar"Ingrese año de fabricación: ";
	Leer year;
	Escribir Sin Saltar"Ingrese marca: ";
	Leer brand;
	Escribir Sin Saltar"Ingrese modelo: ";
	Leer model;
	Escribir Sin Saltar"Ingrese km: ";
	Leer km;
	Escribir Sin Saltar"Ingrese precio: ";
	Leer price;
	Escribir Sin Saltar"Ingrese precio de alquiler por hora: ";
	Leer pricePerHour;
	
	index <- getLastIndex(auto);
	auto[index,0] <- id;
	auto[index,1] <- year;
	auto[index,2] <- brand;
	auto[index,3] <- model;
	auto[index,4] <- km;
	auto[index,5] <- price;
	auto[index,6] <- pricePerHour;
	// Te ponemeos la disponibilidad a true / disponible 
	auto[index,7] <- "true";
	Escribir "Se agregó un nuevo auto.";
	Leer id;
FinSubProceso

SubProceso  setCustomer(cliente Por Referencia)
	Definir j,i,index,position Como Entero;
	Definir nameAndLastName, dni Como Cadena;
	Limpiar Pantalla;
	Escribir "Ingrese dni del nuevo cliente: ";
	Leer dni;
	position <- findById(cliente, dni);
	Si position = -1  Entonces
		index <- getLastIndex(cliente);
		Escribir "Ingrese nombre y apellido del nuevo Cliente: ";
		Leer nameAndLastName;
		cliente[index,0] <- dni;
		cliente[index,1] <- nameAndLastName;
		printCustomerById(cliente, dni);
	SiNo
		Escribir "El cliente ya existente.";	
	FinSi
	
	Leer dni;
FinSubProceso

subproceso setSale(auto,venta,cliente, lastSale, fileNum,customerDni,customerIndex, currentDate,carIndex, planPago)
	definir nameAndLastName, carId como cadena;
	//Cambiamnos el estado del auto vendido a 'false' -- Vendido
	auto[carIndex, 7] <- 'false';
	nameAndLastName <- cliente[customerIndex,1];
	venta[lastSale,0] <- fileNum;
	venta[lastSale,1] <- customerDni;
	venta[lastSale,2] <- nameAndLastName;
	venta[lastSale,3] <- currentDate;
	carId <- auto[carIndex,0];
	venta[lastSale,4] <- carId;
	venta[lastSale,5] <- planPago;
FinSubProceso

subproceso loadNewCustomer(customerDni,cliente)
	definir j,i,index como entero;
	definir nameAndLastName como cadena;
	Limpiar Pantalla;
	index <- getLastIndex(cliente);
	escribir "Ingrese nombre y apellido del nuevo Cliente: ";
	leer nameAndLastName;
	cliente[index,0] <- customerDni;
	cliente[index,1] <- nameAndLastName;
	printCustomerById(cliente, customerDni);
FinSubProceso

subproceso setEmployees(empleado)
	definir index como entero;
	limpiar pantalla;
	definir legajo,name,name2,lastName,direccion,edad,nacionalidad como cadena;
	Escribir '           CARGA EMPLEADO';
	Escribir '___________________________________';
	escribir "Ingrese el n° de legajo: ";
	leer legajo;
	escribir "Ingrese el nombre: ";
	leer name;
	escribir "Ingrese el segundo numbre: ";
	leer name2;
	escribir "Ingrese el apellido: ";
	leer lastName;
	escribir "Ingrese domicilio: ";
	leer direccion;
	escribir "Ingrese edad: ";
	leer edad;
	escribir "Ingrese nacionalidad: ";
	leer nacionalidad;
	index <- getLastIndex(empleado);
	empleado[index,0] <- legajo;
	empleado[index,1] <- name;
	empleado[index,2] <- name2;
	empleado[index,3] <- lastName;
	empleado[index,4] <- direccion;
	empleado[index,5] <- edad;
	empleado[index,6] <- nacionalidad;
	escribir "Un nuevo empleado ha sido cargado con éxito.";
	leer legajo;
FinSubProceso

SubProceso setSpares(repuestos)
	Definir id, categoria, brand, model, price, stock Como Cadena;
	Definir index Como Entero;
	Limpiar Pantalla;
	Escribir Sin Saltar "Ingrese id: ";
	Leer id;
	Escribir Sin Saltar "Ingrese categoría: ";
	Leer categoria;
	Escribir Sin Saltar "Ingrese marca: ";
	Leer marca;
	Escribir Sin Saltar "Ingrese modelo: ";
	Leer model;
	Escribir Sin Saltar "Ingrese precio: ";
	Leer price;
	Escribir Sin Saltar "Ingrese stock: ";
	Leer stock;
	index <- getLastIndex(repuestos);
	repuestos[index,0] <- id;
	repuestos[index,1] <- categoria;
	repuestos[index,2] <- marca;
	repuestos[index,3] <- model;
	repuestos[index,4] <- price;
	repuestos[index,5] <- stock;
	escribir "Un nuevo repuesto ha sido cargado con éxito.";
	leer id;
FinSubProceso

Subproceso setNewPaymentPlan(paymentsPlan)
	definir idPlan,delivery,dues como cadena;
	definir index como entero;
	Limpiar Pantalla;
	Escribir '          CARGA NUEVO PLAN ';
	Escribir '_____________________________________';
	escribir sin saltar "Ingrese nuevo id de plan: ";
	leer idPlan;
	escribir sin saltar "Ingrese monto de la entrega: $";
	leer delivery;
	escribir sin saltar "Ingrese n° de cuotas: ";
	leer dues;
	index <- getLastIndex(paymentsPlan);
	paymentsPlan[index,0] <- idPlan;
	paymentsPlan[index,1] <- delivery;
	paymentsPlan[index,2] <- dues;
	escribir sin saltar "Un nuevo plan fue cargado con éxito.";
	leer idPlan;
FinSubProceso

//Mostrar por ID___________________________________________________________________________________________________


SubProceso printSaleById(ventas, cliente, paymentsPlan, idVenta)
	
	Definir legajo , dni , nameAndLastName , fecha, IdAuto, infoPlan, idPlan, answ Como Cadena;
	Definir delivery, dues Como Cadena;
	Definir posPaymentPlan, posCliente Como Entero;
	
	Limpiar Pantalla;
	
	legajo <- ventas[idVenta,0];
	dni <- ventas[idVenta,1];
	
	posCliente <- findById(cliente, dni);
	nameAndLastName <- cliente[posCliente, 1];
	
	fecha <- ventas[idVenta,3];
	carId <- ventas[idVenta,4];
	
	idPlan <- ventas[idVenta,5];
	
	Si idPlan <> '0' Entonces
		posPaymentPlan <- findById(paymentsPlan, idPlan);
		delivery <- paymentsPlan[posPaymentPlan, 1];
		dues <- paymentsPlan[posPaymentPlan, 2];
		Escribir '________________________________________________________________________________________';
		Escribir '| N° Legajo |    DNI   | Nombre y Apellido |    Fecha   |  Id Auto  | Entrega | Cuotas |';
		
		Escribir '________________________________________________________________________________________';
		Escribir  '|    ',legajo, '    | ', dni , ' |    ', nameAndLastName , '     | ', fecha, ' |   ', carId , '   |   ', delivery, '  |    ', dues, ' |';
	SiNo
		Escribir '________________________________________________________________________________________';
		Escribir '| N° Legajo | DNI | Nombre y Apellido | Fecha | Id Auto | Id Plan |';
		Escribir '__________________________________________________________________________________';
		Escribir  legajo, ' | ', dni , ' | ', nameAndLastName , ' | ', fecha, ' | ', carId , ' | Sin Plan';
	FinSi
	Escribir '________________________________________________________________________________________';
	
	Leer answ;
FinSubProceso

SubProceso printCustomerById(cliente, idCustomer)
	Definir customerIndex  como entero;
	customerIndex <- findById(cliente, idCustomer);
	Escribir '|  DNI  | Nombre y Apellido |';
	Escribir '|',cliente[customerIndex,0],'|',cliente[customerIndex,1],'|';
	
	Leer customerIndex;
	
FinSubProceso

SubProceso printSpareById(repuesto, idSpare)
	Definir spareIndex  como entero;
	spareIndex <- findById(repuesto, idSpare);
	// Id, Categoría, Marca, Modelo, Precio, stock.
	Escribir '_______________________________________________________________';
	Escribir '|  Id Repuesto  | Categoria | Marca | Modelo | Precio | Stock |';
	Escribir '_______________________________________________________________';
	Escribir '|   ',repuesto[spareIndex,0],'   |    ',repuesto[spareIndex,1],'   |  ',repuesto[spareIndex,2],' |  ', repuesto[spareIndex,3],'  |  ', repuesto[spareIndex,4],' |   ',repuesto[spareIndex,5],'  |';
	Escribir '_______________________________________________________________';	
FinSubProceso

//Mostrar Todos___________________________________________________________________________________________________

subproceso availableCar(auto)
	Definir i Como Entero;
	Limpiar Pantalla;
	Escribir '|   Id   |  Año  |  Marca |  Modelo |   Km   |  Precio  | Precio Alquiler |'; 
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
	Escribir '|   Id   |   Año  |  Marca | Modelo |    Km     | Precio  | Precio Alquiler |  Estado  |';
	Escribir '-----------------------------------------------------------------------------------------';
	Para i<-0 Hasta 99 Hacer
		Si auto[i,0] <> '0' Entonces
			Escribir '|  ',auto[i,0], '  | ',auto[i,1], ' |  ', auto[i,2], '  | ', auto[i,3], ' |  ', auto[i,4], '  | ', auto[i,5], '   |      ', auto[i,6], '     | ', auto[i,7], ' |'; 
		FinSi
	FinPara
FinSubProceso

subproceso printAllEmployees(empleado)
	definir i,j como entero;
	Limpiar Pantalla;
	escribir "| N° de legajo | Nombre | Nombre 2 | Apellido | Dirección | Edad | Nacionalidad |";
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

SubProceso printSalesList(venta, paymentsPlan)
	
	Definir i, j, posPaymentPlan Como Entero;
	Definir idPlan, delivery, dues como cadena;
	Limpiar Pantalla;
	Escribir '______________________________________________________________________________________';
	Escribir '| N° Legajo |    DNI   | Nombre y Apellido |    Fecha   | Id Auto | Entrega | Cuotas |';
	
	Para i<-0 Hasta 99 Hacer
		Si No(venta[i,0] = '0') Entonces
			idPlan <- venta[i,5];
			Escribir '______________________________________________________________________________________';
			Si idPlan <> '0' Entonces
				posPaymentPlan <- findById(paymentsPlan, idPlan);
				delivery <- paymentsPlan[posPaymentPlan, 1];
				dues <- paymentsPlan[posPaymentPlan, 2];
				Escribir  '|    ',venta[i,0], '    | ', venta[i,1] , ' |    ', venta[i,2] , '    | ', venta[i,3], ' |   ', venta[i,4] , ' |  ', delivery, '  |    ', dues , '  |';
			SiNo
				Escribir  '|    ',venta[i,0], '    | ', venta[i,1] , ' |    ', venta[i,2] , '     | ', venta[i,3], ' |   ', venta[i,4] , ' | Sin Plan         |';
			FinSi
			
		FinSi
	FinPara
	Escribir '______________________________________________________________________________________';
	leer i;
	
FinSubProceso

SubProceso printSpareList(repuestos)
	Definir i, j Como Entero;
	Escribir '|  Id  | Categoría | Marca | Modelo | Precio | Stock';
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

SubProceso printPaymentsPlan(paymentsPlan)
	Definir i, j Como Entero;
	Limpiar Pantalla;
	Escribir '| IdPlan | Entrega | Cuotas |';
	Escribir '______________________________';
	Para i<-0 Hasta 99 Hacer
		Si No(paymentsPlan[i,0] = '0') Entonces
			Para j<-0 Hasta 2 Hacer
				Escribir Sin Saltar '|   ', paymentsPlan[i,j], '  ';
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
subproceso preSetEmployeeList(empleado)
	definir i,j como entero;
	Para i <- 0 Hasta 99 Hacer
		Para j<-0 Hasta 6 Hacer
			empleado[i,j] <- '0';
		FinPara
	FinPara
	
FinSubProceso
subproceso preSetCarList(auto)
	definir i,j como entero;
	Para i <- 0 Hasta 99 Hacer
		Para j <- 0 Hasta 7 Hacer
			auto[i,j] <- '0';
		FinPara
	FinPara
FinSubProceso

subproceso preSetSpareList(repuestos)
	definir i,j como entero;
	Para i<-0 Hasta 99 Hacer
		Para j<-0 Hasta 5 Hacer
			repuestos[i,j] <- '0';
		FinPara
	FinPara
	
FinSubProceso
subproceso presetSalesListList(venta)
	definir i,j como entero;
	Para i<-0 Hasta 99 Hacer
		Para j<-0 Hasta 5 Hacer
			venta[i,j] <- '0';
		FinPara
	FinPara
	
FinSubProceso
subproceso presetCustomersListList(cliente)
	definir i,j como entero;
	Para i <- 0 Hasta 99 Hacer
		Para j <- 0 Hasta 1 Hacer
			cliente[i,j] <- '0';
		FinPara
	FinPara
	
FinSubProceso

subproceso presetPaymentPlanListList(paymentsPlan)
	definir i,j como entero;
	Para i <- 0 Hasta 99 Hacer
		Para j <- 0 Hasta 2 Hacer
			paymentsPlan[i,j] <- '0';
		FinPara
	FinPara
	
FinSubProceso

//fín pre carga


//Carga de matrizes y bases de datos.

// Carga de Matrices
// Auto
// Repuestos
// paymentsPlan


SubProceso setSalesList(venta)
	
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

subproceso setCarList(auto)
	
	
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


subproceso setEmployeeList(empleado)
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

subproceso setPaymentPlanList(paymentsPlan)
	
	Definir i Como Entero;
	i<-0;
	paymentsPlan[i,0] <- '101'; paymentsPlan[i,1] <-'5000';paymentsPlan[i,2] <-'18';
	i<-i+1;
	paymentsPlan[i,0] <- '102'; paymentsPlan[i,1] <-'10000';paymentsPlan[i,2] <-'10';
	i<-i+1;
	paymentsPlan[i,0] <- '103'; paymentsPlan[i,1] <-'8000';paymentsPlan[i,2] <-'16';
	
FinSubProceso	

// código grupo 2

SubProceso  setSpareList(repuestos) //Subproceso para cargar los repuestos
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

SubProceso setCustomersList(cliente Por Referencia)
	Definir i como  Entero;
	
	i<-0;
	cliente[i,0]	<- '12345678'; cliente[i,1]<-'Mateo Russo';
	
	i<- i + 1;
	cliente[i,0]	<- '43290210'; cliente[i,1]<-'Ana Franco';
	
	i<- i +1;
	cliente[i,0]	<- '39854121'; cliente[i,1]<-'Manuel Rosas';
	
	
FinSubProceso
// fín código grupo 2