Proceso Main
	Definir car, employee, spares, customer, sale, paymentsPlan Como Cadena;
	Definir option Como Entero;
	Dimension car[100,8], employee[100,7], spares[100,6];
	Dimension customer[100,2],sale[100,6],paymentsPlan[100,3];	
	
	
	//Fill all lists with zeros
	preSetCarList(car);
	preSetEmployeeList(employee);
	preSetSpareList(spares);
	preSetPaymentPlanList(paymentsPlan);
	preSetSalesList(sale);
	preSetCustomerList(customer);
	
	//Fill lists with examples dates
	setCarList(car);
	setEmployeeList(employee);
	setSparesList(spares);
	setPaymenPlanList(paymentsPlan);
	setCustomersList(customer);
	setSalesList(sale);	
	
	
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
				doSale(customer,car,employee,sale,paymentsPlan, spares);
			1:
				searchMenu(employee, car, customer, spares, sale, paymentsPlan);
			2:
				serviceRental(customer, car, employee);
			3:
				loadDataMenu(car,employee,spares,customer,paymentsPlan);
			4:
				doBuyout(customer,car);
			5:	
			De Otro Modo: 
				Escribir "Ingrese una opción válida.";
		FinSegun
	Hasta Que option = 5;
	Escribir "Gracias por usar el software, regrese pronto.";
FinProceso

//SubProcess's____________________________________________________________________________________________________________________


SubProceso doSale(customer,car,employee,sale,paymentsPlan, repuesto) //0
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
				carByBrand(car);
			1:
				paymentPlan(paymentsPlan);
				Esperar Tecla;
			2: 
				finishSale(customer,car,employee,sale,paymentsPlan); 
			3:
				sellSpare(repuesto, customer, employee);
			4:
			De Otro Modo:
				escribir "Dato no válido, intente nuevamente.";
		FinSegun
		Hasta Que	option = 4;
		Limpiar Pantalla;
FinSubProceso


SubProceso searchMenu(employee, car, customer, repuesto, sale, planes) //1
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
				carMenu(car);
			1:
				searchEmployeeMenu(employee);
			2:
				sparesMenu(repuesto);
			3:
				searchCustomer(customer);
			4:
				salesMenu(sale, planes, employee);
			5:
			De Otro Modo:
				Escribir "Dato no válido, intente nuevamente.";
		FinSegun
		
	Hasta Que option = 5;
	Limpiar Pantalla;
FinSubProceso


SubProceso serviceRental(customer, car, employee)
	
	Definir customerDni, idCar, pricePerHour, fileNum, currentDate,answ,enableCar Como Cadena;
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
		customerIndex <- findById(customer,customerDni);
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
		loadNewCustomer(customerDni,customer);
		// Get the new position that the new client will fill in the array: to retrieve the name and last name
		customerIndex <- findById(customer,customerDni);
	FinSi
	
	
	// Pick the car for rental
	Escribir '_____________________________________________________________________';
	Escribir Sin Saltar "Ingrese el id del auto: ";
	Leer idCar;   
	
	// Flag that controls if the car picked it's enable
	enableCar <- 'true';
	// Obtain the position that the requested car occupies in the array/list
	carIndex <- findById(car, idCar);
	
	Si carIndex <> -1 Entonces
		enableCar <- car[carIndex, 7];
	FinSi
	
	answ  <- '1';
	
	Mientras carIndex = -1 o (enableCar = 'false' y answ = '1') Hacer
		Si enableCar = 'false' y carIndex <> -1 Entonces
			Escribir 'Auto no disponible';
		FinSI
		Si carIndex = -1  O answ = '1' Entonces
			Escribir Sin Saltar 'Vuelva a intentarlo. Ingrese el id del auto: ';
			Leer idCar;
			carIndex <- findById(car, idCar);
			Si carIndex <> -1 Entonces
				enableCar <- car[carIndex, 7];
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
	employeeIndex <- findById(employee, fileNum);
	Mientras employeeIndex = -1 Hacer
		Escribir 'Empleado no encontrado. Vuelva a intentarlo.';
		Escribir Sin Saltar "Ingrese su número de legajo: ";
		Leer fileNum;   
		employeeIndex <- findById(employee,fileNum);
	FinMientras	
	
	
	//	Current date
	Escribir '_____________________________________________________________________';
	Escribir Sin Saltar "Ingrese fecha actual: ";
	Leer currentDate;
	
	// We get the price per hour of the requested car
	pricePerHour <- car[carIndex, 6];
	
	
	// Change the status of the car to false / not available
	car[carIndex,7] <- 'false';	
	
	
	bar('Alquiler');	
	
	
	Escribir '_____________________________________________________________________';
	Escribir '| Vendedor |  Id Auto |    DNI   | Precio por Hora |  Fecha Retiro  | ';
	Escribir '_____________________________________________________________________';
	Escribir '|    ', fileNum , '   |  ', idCar , '   |  ', customerDni ,' |      $', pricePerHour , '       |   ', currentDate, '   |';  
	Escribir '_____________________________________________________________________';
	
	
	Esperar Tecla;	
	
	
FinSubProceso

SubProceso loadDataMenu(car,employee,spares,customer,paymentsPlan) //3
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
				setCar(car); 
			1:
				setEmployees(employee); 
			2:
				setSpares(spares); 
			3:
				setCustomer(customer); 
			4: 
				setNewPaymentPlan(paymentsPlan); 
			5:	
				setCar(car);
			6:
			De Otro Modo:
				Escribir "Dato no válido, intente nuevamente.";
		FinSegun
	Hasta Que option = 6;
FinSubProceso


SubProceso doBuyout(customer, auto) //4
	//To make a purchase we need a client/supplier from whom we are going to buy
	//and the information of the car we bought
	Definir ok Como Cadena;
	//We load the client, if it exists we take its data
	setCustomer(customer);
	//We load a new car
	setCar(car);
	Escribir "Compra registrada con éxito.";
	Leer ok;
FinSubProceso


SubProceso carByBrand(car)
	
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
		
		brandCar <- car[i,2];
		brandCar <- Minusculas(brandCar);
		
		Si car[i,2] <> '0' Y brandCar = brand Entonces
			
			Para j <- 0 Hasta 7 Hacer
				results[count, j] <- car[i,j];
			FinPara
			count <- count + 1;
		FinSi
		
	FinPara
	Si count <> 0 Entonces
		Limpiar Pantalla;
		Escribir 'Resultados encontrados: ', count, '.';
		Escribir '-----------------------------------------------------------------------------------------';
		printCars(results);
	SiNo
		Escribir 'No se encontraron resultados con marca: ' , brand;
	FinSi
	
	Leer brand;
	
FinSubProceso


SubProceso paymentPlan(paymentsPlan)
	Limpiar Pantalla;
	printPaymentsPlan(paymentsPlan);
FinSubProceso

SubProceso finishSale(customer, car, employee, sale, paymentsPlan)
	
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
		customerIndex <- findById(customer,customerDni);
		Si customerIndex <> -1 Entonces
			customerExist <- Verdadero;
			Escribir 'Se encontro el cliente con id: ', customerDni;
		FinSi
	Hasta Que customerIndex = -1 O customerExist;
	
	// If it does not find the client entered, we load a new client.
	Si No customerExist Entonces
		Escribir '_____________________________________________';
		Escribir "No se encontro al Cliente ";
		loadNewCustomer(customerDni,customer);
		customerIndex <- findById(customer,customerDni);
	FinSi
	
	// Load the car
	Escribir '_____________________________________________';
	Escribir Sin Saltar "Ingrese el id del auto: ";
	Leer carId;     
	carIndex <- findById(car, carId);
	carEnable <- Falso;
	Mientras carIndex = -1 O No(carEnable) Hacer
		Si carIndex = -1 Entonces
			Escribir 'Auto no encontrado. Vuelva a intentarlo.';
			Escribir Sin Saltar "Ingrese el id del auto: ";
			Leer carId;
			carIndex <- findById(car, carId);
		FinSi
		Si carIndex <> -1 Entonces
			carStatus <- car[carIndex,7];
			// A status equal to 'false' means that the car has been sold or is rented
			Si carStatus = 'false' Entonces
				Escribir  Sin Saltar'El auto no esta disponible. Ingrese Otro.';
				Leer carId;  
				carIndex <- findById(car, carId);
			SiNo
				carEnable <- Verdadero;
			FinSi
		FinSi
	FinMientras
	
	// Load employee file
	Escribir '_____________________________________________';
	Escribir Sin Saltar "Ingrese su número de legajo: ";
	Leer fileNum;     
	employeeIndex <- findById(employee, fileNum);
	Mientras employeeIndex = -1 Hacer
		Escribir 'Empleado no encontrado. Vuelva a intentarlo.';
		Escribir Sin Saltar "Ingrese su número de legajo: ";
		Leer fileNum;   
		employeeIndex <- findById(employee,fileNum);
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
		lastSale <- getLastIndex(sale);
		Si no (lastSale = -1) Entonces
			// We save the sale: File No., Dni, Name and Last name, date, Id (Car), payment plan.
			setSale(car, sale,customer,lastSale, fileNum,customerDni, customerIndex,currentDate,carIndex, planId);
			Escribir '_____________________________________________';
			Escribir 'Venta Realizada con exito.... ';
			printSaleById(sale, customer, paymentsPlan, lastSale);
		SiNo
			Escribir 'No se pudo concretar la venta, la matriz Venta esta llena.';
		FinSi
		
	SiNo
		Escribir 'Venta cancelada. Presione cualquier tecla para salir ... ';
		Leer answConfirmation;
	FinSi
FinSubProceso

SubProceso sellSpare(repuesto, customer, employee)
	
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
		customerIndex <- findById(customer,customerDni);
		Si customerIndex <> -1 Entonces
			customerExist <- Verdadero;
			Escribir 'Se encontro el cliente con id: ', customerDni;
		FinSi
	Hasta Que customerIndex = -1 o customerExist;
	
	// If it does not find the client entered, we load a new client..
	Si No customerExist Entonces
		Escribir '_____________________________________________';
		Escribir "No se encontro al Cliente ";
		loadNewCustomer(customerDni,customer);
		customerIndex <- findById(customer,customerDni);
	FinSi
	
	nameAndLastName <- customer[customerIndex, 1];
	
	
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
	employeeIndex <- findById(employee, fileNum);
	Mientras employeeIndex = -1 Hacer
		Escribir 'Empleado no encontrado. Vuelva a intentarlo.';
		Escribir Sin Saltar "Ingrese su número de legajo: ";
		Leer fileNum;   
		employeeIndex <- findById(employee,fileNum);
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

SubProceso findByEmployee(employee)
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
				printAllEmployees(employee);
			1:
				findEmployeeFile(employee);
			2:
				
			De Otro Modo:
				Escribir "Dato no válido, intente nuevamente.";
		FinSegun
	Hasta Que option = 2;
	Limpiar Pantalla;
FinSubProceso

// Search by ID___________________________________________________________________________________________________

SubProceso findSpareById(spares)
	Definir idSpare Como Cadena;
	Definir position Como Entero;
	Limpiar Pantalla;
	Escribir "Ingrese el id de repuesto que desea buscar.";
	Leer idSpare;
	position <- findById(spares,idSpare );
	Escribir '__________________________________________________________________________';
	Escribir '| Id de repuesto | Categoría |     Marca     |   Modelo | Precio | Stock |';
	Escribir '__________________________________________________________________________';
	Si position <> -1 Entonces 
		Escribir '|   ',spares[position,0], '    |    ', spares[position,1] ,'   |      ',spares[position,2],'     |   ',spares[position,3],'  |  ',spares[position,4], '  |   ',spares[position,5],'  | ';
	SiNo
		Escribir 'Repuesto no encontrado';
	FinSi
	Leer position;
FinSubProceso

SubProceso findCarById(car)
	Definir idCar Como Cadena;
	Definir position Como Entero;
	Limpiar Pantalla;
	Escribir "Ingrese el id del vehiculo que desea buscar.";
	Leer idCar;
	position <- findById(car,idCar );
	Escribir '---------------------------------------------------------------------------------------';
	Escribir '|   Id   |   Año  |  Marca  |  Modelo  |   Km   |  Precio  | Precio Alquiler | Estado |'; 
	Escribir '---------------------------------------------------------------------------------------';
	Si position <> -1 Entonces 
		Escribir '|  ',car[position,0], ' |  ',car[position,1], '  |  ', car[position,2], '  |   ', car[position,3], '  |  ', car[position,4], ' |  ', car[position,5], ' |       $', car[position,6], '      |  ' , car[position,7],'  |' ; 
		Escribir '---------------------------------------------------------------------------------------';
	SiNo
		
		Escribir 'Vehiculo no encontrado';
		Escribir '---------------------------------------------------------------------------------------';
	FinSi
	Leer position;
FinSubProceso

SubProceso findSaleByEmployee(sale, employee, paymentsPlan)
	
	Definir i, j, posPaymentPlan, position Como Entero;
	Definir idPlan, delivery, dues, idEmployee,  employeeName, name, lastName Como Cadena;
	Limpiar Pantalla;
	
	Escribir sin saltar 'Ingrese Id Vendedor: ';
	Leer idEmployee;
	position <- findById(employee, idEmployee);
	
	name <- Concatenar(employee[position,1], ' ');
	
	lastName <- employee[position,3];
	
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
			
			Si No(sale[i,0] = '0')  y sale[i, 0] = idEmployee Entonces
				idPlan <- sale[i,5];
				Si idPlan <> '0' Entonces
					posPaymentPlan <- findById(paymentsPlan, idPlan);
					delivery <- paymentsPlan[posPaymentPlan, 1];
					dues <- paymentsPlan[posPaymentPlan, 2];
					Escribir '_____________________________________________________________________________';
					Escribir  '| ', sale[i,1] , ' |     ', sale[i,2] , '    |   ', sale[i,3], ' |  ', sale[i,4] , '  | ', delivery, '   |   ', dues, '   |';
				SiNo
					Escribir '_____________________________________________________________________________';
					Escribir  '| ', sale[i,1] , ' |   ', sale[i,2] , '      |  ', sale[i,3], ' |  ', sale[i,4] , '  | Sin Plan';
				FinSi
				
			FinSi
		FinPara
		Escribir '_____________________________________________________________________________';
	SiNo
		Escribir 'Vendedor no encontrado';
	FinSi
	leer i;
	
FinSubProceso

SubProceso findEmployeeFile(employee)
	Definir fileNum Como Cadena;
	Definir position Como Entero;
	Limpiar Pantalla;
	Escribir Sin Saltar"Ingrese el n° de legajo que desea buscar.";
	Leer filenum;
	position <- findById(employee, fileNum);
	Escribir '______________________________________________________________________________________';
	Escribir "| N° de legajo | Nombre | Nombre 2 | Apellido |    Dirección   | Edad | Nacionalidad |";
	Escribir '______________________________________________________________________________________';
	Si position <> -1 Entonces 
		Si employee[position,2]  = '' Entonces
			Escribir '|      ',employee[position,0], '     |  ', employee[position,1] ,' |  ------- |  ',employee[position,3],'  | ',employee[position,4], ' |  ',employee[position,5],'  |   ',employee[position,6], '  |';
		SiNo
			Escribir '|      ',employee[position,0], '     |  ', employee[position,1] ,' |  ',employee[position,2],'  | ',employee[position,3],' | ',employee[position,4], ' | ',employee[position,5],' | ',employee[position,6], ' |';
		FinSi
		Escribir '______________________________________________________________________________________';
	Sino
		Escribir 'Empleado no encontrado';
	FinSi
	Leer filenum;
FinSubProceso

SubProceso serviceCar(car)
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
				availableCar(car);
			1:
				findCarById(car);
			2:
				
			De Otro Modo:
				Escribir "Dato no válido, intente nuevamente.";
		FinSegun
		Hasta Que	option = 2;
		Limpiar Pantalla;
		
FinSubProceso

SubProceso servicesSpare(spares)
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
				printSpareList(spares);
			1:
				findSpareById(spares); // READY
			2:
				
			De Otro Modo:
				Escribir "Dato no válido, intente nuevamente.";
		FinSegun
		Hasta Que	option = 2;
		Limpiar Pantalla;
FinSubProceso


SubProceso serviceSales(sale, planes, employee)
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
				printSalesList(sale,planes);
			1:
				findSaleByEmployee(sale, employee, planes);
			2:
				
			De Otro Modo:
				Escribir "Dato no válido, intente nuevamente.";
		FinSegun
		Hasta Que	option = 2;
		Limpiar Pantalla;
FinSubProceso


SubProceso findCustomer(customer)
	
	Definir idCustomer Como Cadena;
	Definir position Como Entero;
	
	Limpiar Pantalla;
	Escribir "Ingrese el id de cliente que desea buscar.";
	Leer idCustomer;
	position <- findById(customer,idCustomer );
	Si position <> -1 Entonces 
		Escribir "___________________________";
		Escribir "| DNI | Nombre y Apellido |";
		Escribir "___________________________";
		Escribir '| ',customer[position,0], ' |  ', customer[position,1] ,' | ';
	SiNo
		Escribir 'Cliente no encontrado';
	FinSi
	Leer position;
FinSubProceso

// Single load___________________________________________________________________________________________________

SubProceso setCar(car)
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
	
	index <- getLastIndex(car);
	car[index,0] <- id;
	car[index,1] <- year;
	car[index,2] <- brand;
	car[index,3] <- model;
	car[index,4] <- km;
	car[index,5] <- price;
	car[index,6] <- pricePerHour;
	// Set the availability to true / available
	car[index,7] <- "true";
	Escribir "Se agregó un nuevo auto.";
	Leer id;
FinSubProceso

SubProceso  setCustomer(customer Por Referencia)
	Definir j,i,index,position Como Entero;
	Definir nameAndLastName, dni Como Cadena;
	Limpiar Pantalla;
	Escribir "Ingrese dni del nuevo cliente: ";
	Leer dni;
	position <- findById(customer, dni);
	Si position = -1  Entonces
		index <- getLastIndex(customer);
		Escribir "Ingrese nombre y apellido del nuevo Cliente: ";
		Leer nameAndLastName;
		customer[index,0] <- dni;
		customer[index,1] <- nameAndLastName;
		printCustomerById(customer, dni);
	SiNo
		Escribir "El cliente ya existente.";	
	FinSi
	
	leer dni;
FinSubProceso

SubProceso setSale(car,sale,customer, lastSale, fileNum,customerDni,customerIndex, currentDate,carIndex, planPago)
	Definir nameAndLastName, carId Como Cadena;
	//Change the status of the sold car to 'false' -- Sold
	car[carIndex, 7] <- 'false';
	nameAndLastName <- customer[customerIndex,1];
	sale[lastSale,0] <- fileNum;
	sale[lastSale,1] <- customerDni;
	sale[lastSale,2] <- nameAndLastName;
	sale[lastSale,3] <- currentDate;
	carId <- car[carIndex,0];
	sale[lastSale,4] <- carId;
	sale[lastSale,5] <- planPago;
FinSubProceso

SubProceso loadNewCustomer(customerDni,customer)
	Definir j,i,index Como Entero;
	Definir nameAndLastName Como Cadena;
	Limpiar Pantalla;
	index <- getLastIndex(customer);
	Escribir "Ingrese nombre y apellido del nuevo Cliente: ";
	Leer nameAndLastName;
	customer[index,0] <- customerDni;
	customer[index,1] <- nameAndLastName;
	printCustomerById(customer, customerDni);
FinSubProceso

SubProceso setEmployees(employee)
	Definir index Como Entero;
	Limpiar Pantalla;
	Definir file,name,name2,lastName,address,age,nationality Como Cadena;
	Escribir '           CARGA EMPLEADO';
	Escribir '___________________________________';
	Escribir "Ingrese el n° de legajo: ";
	Leer file;
	Escribir "Ingrese el nombre: ";
	Leer name;
	Escribir "Ingrese el segundo numbre: ";
	Leer name2;
	Escribir "Ingrese el apellido: ";
	Leer lastName;
	Escribir "Ingrese domicilio: ";
	Leer address;
	Escribir "Ingrese edad: ";
	Leer age;
	Escribir "Ingrese nacionalidad: ";
	Leer nationality;
	index <- getLastIndex(employee);
	employee[index,0] <- file;
	employee[index,1] <- name;
	employee[index,2] <- name2;
	employee[index,3] <- lastName;
	employee[index,4] <- address;
	employee[index,5] <- age;
	employee[index,6] <- nationality;
	Escribir "Un nuevo empleado ha sido cargado con éxito.";
	Leer file;
FinSubProceso

SubProceso setSpares(spares)
	Definir id, category, brand, model, price, stock Como Cadena;
	Definir index Como Entero;
	Limpiar Pantalla;
	Escribir Sin Saltar "Ingrese id: ";
	Leer id;
	Escribir Sin Saltar "Ingrese categoría: ";
	Leer category;
	Escribir Sin Saltar "Ingrese marca: ";
	Leer brand;
	Escribir Sin Saltar "Ingrese modelo: ";
	Leer model;
	Escribir Sin Saltar "Ingrese precio: ";
	Leer price;
	Escribir Sin Saltar "Ingrese stock: ";
	Leer stock;
	index <- getLastIndex(spares);
	spares[index,0] <- id;
	spares[index,1] <- category;
	spares[index,2] <- brand;
	spares[index,3] <- model;
	spares[index,4] <- price;
	spares[index,5] <- stock;
	Escribir "Un nuevo repuesto ha sido cargado con éxito.";
	Leer id;
FinSubProceso

SubProceso setNewPaymentPlan(paymentsPlan)
	Definir idPlan,delivery,dues Como Cadena;
	Definir index Como Entero;
	Limpiar Pantalla;
	Escribir '          CARGA NUEVO PLAN ';
	Escribir '_____________________________________';
	Escribir Sin Saltar "Ingrese nuevo id de plan: ";
	Leer idPlan;
	Escribir Sin Saltar "Ingrese monto de la entrega: $";
	Leer delivery;
	Escribir Sin Saltar "Ingrese n° de cuotas: ";
	Leer dues;
	index <- getLastIndex(paymentsPlan);
	paymentsPlan[index,0] <- idPlan;
	paymentsPlan[index,1] <- delivery;
	paymentsPlan[index,2] <- dues;
	Escribir Sin Saltar "Un nuevo plan fue cargado con éxito.";
	Leer idPlan;
FinSubProceso

//Print by ID___________________________________________________________________________________________________


SubProceso printSaleById(ventas, customer, paymentsPlan, idSale)
	
	Definir file , dni , nameAndLastName , date, carId, planInfo, idPlan, answ Como Cadena;
	Definir delivery, dues Como Cadena;
	Definir posPaymentPlan, posCustomer Como Entero;
	
	Limpiar Pantalla;
	
	file <- ventas[idSale,0];
	dni <- ventas[idSale,1];
	
	posCustomer <- findById(customer, dni);
	nameAndLastName <- customer[posCustomer, 1];
	
	date <- ventas[idSale,3];
	carId <- ventas[idSale,4];
	
	idPlan <- ventas[idSale,5];
	
	Si idPlan <> '0' Entonces
		posPaymentPlan <- findById(paymentsPlan, idPlan);
		delivery <- paymentsPlan[posPaymentPlan, 1];
		dues <- paymentsPlan[posPaymentPlan, 2];
		Escribir '________________________________________________________________________________________';
		Escribir '| N° Legajo |    DNI   | Nombre y Apellido |    Fecha   |  Id Auto  | Entrega | Cuotas |';
		
		Escribir '________________________________________________________________________________________';
		Escribir  '|    ',file, '    | ', dni , ' |    ', nameAndLastName , '     | ', date, ' |   ', carId , '   |   ', delivery, '  |    ', dues, ' |';
	SiNo
		Escribir '________________________________________________________________________________________';
		Escribir '| N° Legajo | DNI | Nombre y Apellido | Fecha | Id Auto | Id Plan |';
		Escribir '__________________________________________________________________________________';
		Escribir  file, ' | ', dni , ' | ', nameAndLastName , ' | ', date, ' | ', carId , ' | Sin Plan';
	FinSi
	Escribir '________________________________________________________________________________________';
	
	Leer answ;
FinSubProceso

SubProceso printCustomerById(customer, idCustomer)
	Definir customerIndex  Como Entero;
	customerIndex <- findById(customer, idCustomer);
	Escribir '|  DNI  | Nombre y Apellido |';
	Escribir '|',customer[customerIndex,0],'|',customer[customerIndex,1],'|';
	
	Leer customerIndex;
	
FinSubProceso

SubProceso printSpareById(repuesto, idSpare)
	Definir spareIndex  Como Entero;
	spareIndex <- findById(repuesto, idSpare);
	// Id, Category, Brand, Model, Price, stock.
	Escribir '_______________________________________________________________';
	Escribir '|  Id Repuesto  | Categoria | Marca | Modelo | Precio | Stock |';
	Escribir '_______________________________________________________________';
	Escribir '|   ',repuesto[spareIndex,0],'   |    ',repuesto[spareIndex,1],'   |  ',repuesto[spareIndex,2],' |  ', repuesto[spareIndex,3],'  |  ', repuesto[spareIndex,4],' |   ',repuesto[spareIndex,5],'  |';
	Escribir '_______________________________________________________________';	
FinSubProceso

//Print all's___________________________________________________________________________________________________

SubProceso availableCar(car)
	Definir i Como Entero;
	Limpiar Pantalla;
	Escribir '|   Id   |  Año  |  Marca |  Modelo |   Km   |  Precio  | Precio Alquiler |'; 
	Escribir '---------------------------------------------------------------------------';
	Para i<-0 Hasta 99 Hacer
		Si car[i,7] = 'true' Entonces
			Escribir '| ',car[i,0], ' | ',car[i,1], ' | ', car[i,2], ' | ', car[i,3], ' | ', car[i,4], ' | ', car[i,5], ' | ', car[i,6], ' |'; 
		FinSi
	FinPara
	Leer i;
FinSubProceso

SubProceso printCars(car)
	Definir i Como Entero;
	Escribir '|   Id   |   Año  |  Marca | Modelo |    Km     | Precio  | Precio Alquiler |  Estado  |';
	Escribir '-----------------------------------------------------------------------------------------';
	Para i<-0 Hasta 99 Hacer
		Si car[i,0] <> '0' Entonces
			Escribir '|  ',car[i,0], '  | ',car[i,1], ' |  ', car[i,2], '  | ', car[i,3], ' |  ', car[i,4], '  | ', car[i,5], '   |      ', car[i,6], '     | ', car[i,7], ' |'; 
		FinSi
	FinPara
FinSubProceso

subproceso printAllEmployees(employee)
	Definir i,j Como Entero;
	Limpiar Pantalla;
	Escribir "| N° de legajo | Nombre | Nombre 2 | Apellido | Dirección | Edad | Nacionalidad |";
	Para i <- 0 Hasta 99 Con Paso 1 Hacer
		Para j <- 0 Hasta 6 Con Paso 1 Hacer
			Si No (employee[i,j]= '0') Entonces
				Escribir Sin Saltar "| ",employee[i,j];
			FinSi
		FinPara
		Si No (employee[i,0]= '0') Entonces
			Escribir " |";
		FinSi
	FinPara
	Escribir '_____________________________________________________________________________________';
FinSubProceso

SubProceso printSalesList(sale, paymentsPlan)
	
	Definir i, j, posPaymentPlan Como Entero;
	Definir idPlan, delivery, dues Como Cadena;
	Limpiar Pantalla;
	Escribir '______________________________________________________________________________________';
	Escribir '| N° Legajo |    DNI   | Nombre y Apellido |    Fecha   | Id Auto | Entrega | Cuotas |';
	
	Para i<-0 Hasta 99 Hacer
		Si No(sale[i,0] = '0') Entonces
			idPlan <- sale[i,5];
			Escribir '______________________________________________________________________________________';
			Si idPlan <> '0' Entonces
				posPaymentPlan <- findById(paymentsPlan, idPlan);
				delivery <- paymentsPlan[posPaymentPlan, 1];
				dues <- paymentsPlan[posPaymentPlan, 2];
				Escribir  '|    ',sale[i,0], '    | ', sale[i,1] , ' |    ', sale[i,2] , '    | ', sale[i,3], ' |   ', sale[i,4] , ' |  ', delivery, '  |    ', dues , '  |';
			SiNo
				Escribir  '|    ',sale[i,0], '    | ', sale[i,1] , ' |    ', sale[i,2] , '     | ', sale[i,3], ' |   ', sale[i,4] , ' | Sin Plan         |';
			FinSi
			
		FinSi
	FinPara
	Escribir '______________________________________________________________________________________';
	Leer i;
	
FinSubProceso

SubProceso printSpareList(spares)
	Definir i, j Como Entero;
	Escribir '|  Id  | Categoría | Marca | Modelo | Precio | Stock';
	Para i<-0 Hasta 99 Hacer
		Si No(spares[i,0] = '0') Entonces
			Para j<-0 Hasta 5 Hacer
				Escribir Sin Saltar '| ', spares[i,j], ' ';
			FinPara
			Escribir '|';
		FinSi
	FinPara
	Leer i;
FinSubProceso

SubProceso printCustomers(customer)
	Definir i,j Como Entero;
	Limpiar Pantalla;
	Para i<-0 Hasta 99 Hacer
		Si No(customer[i,0] = '0') Entonces
			Para j<-0 Hasta 1 Hacer
				Escribir Sin Saltar '| ', customer[i,j], ' ';
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

SubProceso printSales(sale)
	Definir i, j Como Entero;
	Limpiar Pantalla;
	Para i<-0 Hasta 99 Hacer
		Si No(sale[i,0] = '0') Entonces
			Para j<-0 Hasta 4 Hacer
				Escribir Sin Saltar '| ', sale[i,j], ' ';
			FinPara
			Escribir '|';
		FinSi
    FinPara
	Leer i;
FinSubProceso

// Loading bar______________________________________________________________________________________________
SubProceso bar(operation)
	
	Definir i Como Entero;
	operation<- Mayusculas(operation);
	
	Escribir '';	Escribir '';
	
	Escribir '                      CARGANDO ' , operation ;
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
	Escribir "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXO------------OXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	Esperar 200 Milisegundos;
	Escribir "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX|            |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	Esperar 200 Milisegundos;
	Escribir "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX|Team pro_Utn|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	Esperar 200 Milisegundos;
	Escribir "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX|            |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	Esperar 200 Milisegundos;
	Escribir "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXO------------OXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	
	
	//Write " ";
	Esperar 100 Milisegundos;
	Escribir "         		                                  _._";
	Esperar 100 Milisegundos;
	Escribir "           		                           _.-=´´_-         _";
	Esperar 100 Milisegundos;
	Escribir "            		                     _.-=´´   _-          | |´´´´´´´---._______     __..";
	Esperar 100 Milisegundos;
	Escribir "            		         ___.===¨¨¨¨-.______-,,,,,,,,,,,,`-¨ ¨----´¨¨ ¨¨¨¨       ¨¨¨¨  __¨¨";
	Esperar 100 Milisegundos;
	Escribir "            		  _.--¨¨¨     _        ,´                   o \           _        [_]|";
	Esperar 100 Milisegundos;
	Escribir "        		 __-´´=======.--¨¨  ¨¨--.=================================.--¨¨  ¨¨--.=======:";
	Esperar 100 Milisegundos;
	Escribir "        		]       [w] : /        \ : |========================|    : /        \ :  [w] :";
	Esperar 100 Milisegundos;
	Escribir "        		V___________:|          |: |========================|    :|          |:   _-´";
	Esperar 100 Milisegundos;
	Escribir "         		V__________: \        / :_|=======================/_____: \        / :__-´";
	Esperar 100 Milisegundos;
	Escribir "         		-----------´  ¨¨____¨¨  `-------------------------------´  ¨¨____¨¨";
FinSubProceso


//Pre load___________________________________________________________________________________________________
SubProceso preSetEmployeeList(employee)
	Definir i,j Como Entero;
	Para i <- 0 Hasta 99 Hacer
		Para j<-0 Hasta 6 Hacer
			employee[i,j] <- '0';
		FinPara
	FinPara
	
FinSubProceso
SubProceso preSetCarList(car)
	Definir i,j Como Entero;
	Para i <- 0 Hasta 99 Hacer
		Para j <- 0 Hasta 7 Hacer
			car[i,j] <- '0';
		FinPara
	FinPara
FinSubProceso

SubProceso preSetSpareList(spares)
	Definir i,j Como Entero;
	Para i<-0 Hasta 99 Hacer
		Para j<-0 Hasta 5 Hacer
			spares[i,j] <- '0';
		FinPara
	FinPara
	
FinSubProceso
SubProceso presetSalesListList(sale)
	Definir i,j Como Entero;
	Para i<-0 Hasta 99 Hacer
		Para j<-0 Hasta 5 Hacer
			sale[i,j] <- '0';
		FinPara
	FinPara
	
FinSubProceso
SubProceso presetCustomersListList(customer)
	Definir i,j Como Entero;
	Para i <- 0 Hasta 99 Hacer
		Para j <- 0 Hasta 1 Hacer
			customer[i,j] <- '0';
		FinPara
	FinPara
	
FinSubProceso

SubProceso presetPaymentPlanListList(paymentsPlan)
	Definir i,j Como Entero;
	Para i <- 0 Hasta 99 Hacer
		Para j <- 0 Hasta 2 Hacer
			paymentsPlan[i,j] <- '0';
		FinPara
	FinPara
	
FinSubProceso

//End pre load


//Load arrays and databases.

// Array Load
// car
// Spare parts
// paymentsPlan


SubProceso setSalesList(sale)
	
	Definir i Como Entero;
	
	//	0: N° file
	//	1: DNI
	//	2: Name and Last Name
	//	3: Date
	//	4: Id (Car)
	//	5: Id (plan).
	
	i<-0;
	sale[i,0] <- '100'; 
	sale[i,1] <- '12345678';
	sale[i,2] <- 'Mateo Russo';
	sale[i,3] <- '2022-05-04';
	sale[i,4] <- '38505';
	sale[i,5] <- '102';
	
	
	
	i<-i + 1;
	sale[i,0] <- '140'; 
	sale[i,1] <- '43290210';
	sale[i,2] <- 'Ana Franco';
	sale[i,3] <- '2022-07-16';
	sale[i,4] <- '22894';
	sale[i,5] <- '0';
	
	
FinSubProceso

SubProceso setCarList(car)
	
	
	Definir i Como Entero;
	
	i<-0;
	car[i,0] <- '55555'; car[i,1] <-'2011';car[i,2] <-'Volkswagen';car[i,3] <-'Trend';
	car[i,4] <-'185664';car[i,5] <-'1000000';car[i,6] <-'300'; car[i,7] <-'true';
	i<- i + 1;  // i = 1
	car[i,0] <- '69125'; car[i,1] <-'2000';car[i,2] <-'Toyota';car[i,3] <-'Corolla';
	car[i,4] <-'186298';car[i,5] <-'1400000';car[i,6] <-'310'; car[i,7] <-'true';
	i<- i + 1; // i = 2
	car[i,0] <- '22894'; car[i,1] <-'2017';car[i,2] <-'Ford';car[i,3] <-'Escort';
	car[i,4] <-'237896';car[i,5] <-'750000';car[i,6] <-'310'; car[i,7] <-'false';
	i<- i + 1; // i = 3
	car[i,0] <- '79927'; car[i,1] <-'2004';car[i,2] <-'Fiat';car[i,3] <-'Escort';
	car[i,4] <-'207669';car[i,5] <-'800000';car[i,6] <-'310'; car[i,7] <-'false';
	i<- i + 1; // i = 4
	car[i,0] <- '25021'; car[i,1] <-'2011';car[i,2] <-'Volkswagen';car[i,3] <-'Suram';
	car[i,4] <-'163390';car[i,5] <-'1000000';car[i,6] <-'310'; car[i,7] <-'false';
	i<- i + 1; // i = 5
	car[i,0] <- '907401'; car[i,1] <-'2007';car[i,2] <-'Toyota';car[i,3] <-'Hillux';
	car[i,4] <-'171491';car[i,5] <-'900000';car[i,6] <-'310'; car[i,7] <-'false';
	i<- i + 1; // i = 6	
	car[i,0] <- '40799'; car[i,1] <-'2017';car[i,2] <-'Ford';car[i,3] <-'Fiesta';
	car[i,4] <-'47341';car[i,5] <-'1400000';car[i,6] <-'310'; car[i,7] <-'true';
	i<- i + 1; // i = 7	
	car[i,0] <- '38505'; car[i,1] <-'2014';car[i,2] <-'Fiat';car[i,3] <-'Palio';
	car[i,4] <-'182198';car[i,5] <-'1000000';car[i,6] <-'310'; car[i,7] <-'false';
	i<- i + 1; // i = 8	
	car[i,0] <- '47151'; car[i,1] <-'2018';car[i,2] <-'Chevrolet';car[i,3] <-'Onix';
	car[i,4] <-'205269';car[i,5] <-'1600000';car[i,6] <-'290'; car[i,7] <-'false';
	i<- i + 1; // i = 9	
	car[i,0] <- '97852'; car[i,1] <-'2017';car[i,2] <-'Volkswagen';car[i,3] <-'Polo';
	car[i,4] <-'133969';car[i,5] <-'1400000';car[i,6] <-'290'; car[i,7] <-'false';
	i<- i + 1; // i = 10	
	car[i,0] <- '33757'; car[i,1] <-'2008';car[i,2] <-'Toyota';car[i,3] <-'Corolla';
	car[i,4] <-'267319';car[i,5] <-'900000';car[i,6] <-'290'; car[i,7] <-'false';
	i<- i + 1; // i = 11
	car[i,0] <- '39335'; car[i,1] <-'2001';car[i,2] <-'Chevrolet';car[i,3] <-'Corsa';
	car[i,4] <-'99685';car[i,5] <-'750000';car[i,6] <-'290'; car[i,7] <-'false';
	i<- i + 1; // i = 12
	car[i,0] <- '39335'; car[i,1] <-'2001';car[i,2] <-'Chevrolet';car[i,3] <-'Corsa';
	car[i,4] <-'99685';car[i,5] <-'750000';car[i,6] <-'290'; car[i,7] <-'false';
	i<- i + 1; // i = 13
	car[i,0] <- '20854'; car[i,1] <-'2016';car[i,2] <-'Volkswagen';car[i,3] <-'Trend';
	car[i,4] <-'156950';car[i,5] <-'1200000';car[i,6] <-'290'; car[i,7] <-'false';
	i<- i + 1; // i = 14
	car[i,0] <- '77152'; car[i,1] <-'2012';car[i,2] <-'Toyota';car[i,3] <-'Corolla';
	car[i,4] <-'135710';car[i,5] <-'1000000';car[i,6] <-'290'; car[i,7] <-'false';
	i<- i + 1; // i = 15
	car[i,0] <- '59949'; car[i,1] <-'2010';car[i,2] <-'Chevrolet';car[i,3] <-'Corsa';
	car[i,4] <-'212238';car[i,5] <-'1000000';car[i,6] <-'290'; car[i,7] <-'true';
	i<- i + 1; // i = 16
	car[i,0] <- '20135'; car[i,1] <-'2015';car[i,2] <-'Ford';car[i,3] <-'Ranger';
	car[i,4] <-'173874';car[i,5] <-'1100000';car[i,6] <-'290'; car[i,7] <-'true';
	i<- i + 1; // i = 17
	car[i,0] <- '74221'; car[i,1] <-'2009';car[i,2] <-'Fiat';car[i,3] <-'Palio';
	car[i,4] <-'195244';car[i,5] <-'900000';car[i,6] <-'290'; car[i,7] <-'true';
	i<- i + 1; // i = 18
	car[i,0] <- '10879'; car[i,1] <-'2000';car[i,2] <-'Chevrolet';car[i,3] <-'Corsa';
	car[i,4] <-'296022';car[i,5] <-'750000';car[i,6] <-'310'; car[i,7] <-'false';
	i<- i + 1; // i = 19
	car[i,0] <- '10607'; car[i,1] <-'2005';car[i,2] <-'Volkswagen';car[i,3] <-'Trend';
	car[i,4] <-'55350';car[i,5] <-'800000';car[i,6] <-'310'; car[i,7] <-'false';
	i<- i + 1; // i = 20
	car[i,0] <- '39052'; car[i,1] <-'2001';car[i,2] <-'Toyota';car[i,3] <-'Corolla';
	car[i,4] <-'197730';car[i,5] <-'750000';car[i,6] <-'300'; car[i,7] <-'false';
	i<- i + 1; // i = 21
	car[i,0] <- '90838'; car[i,1] <-'2001';car[i,2] <-'Ford';car[i,3] <-'Ka';
	car[i,4] <-'227082';car[i,5] <-'750000';car[i,6] <-'300'; car[i,7] <-'false';
	i<- i + 1; // i = 22
	car[i,0] <- '32862'; car[i,1] <-'2009';car[i,2] <-'Fiat';car[i,3] <-'Palio';
	car[i,4] <-'22206';car[i,5] <-'900000';car[i,6] <-'300'; car[i,7] <-'false';
	i<- i + 1; // i = 23
	car[i,0] <- '59105'; car[i,1] <-'2005';car[i,2] <-'Chevrolet';car[i,3] <-'Corsa';
	car[i,4] <-'175897';car[i,5] <-'800000';car[i,6] <-'300'; car[i,7] <-'false';
	i<- i + 1; // i = 24
	car[i,0] <- '31279'; car[i,1] <-'2011';car[i,2] <-'Renault';car[i,3] <-'Clio';
	car[i,4] <-'73578';car[i,5] <-'1000000';car[i,6] <-'310'; car[i,7] <-'false';
	i<- i + 1; // i = 25
	car[i,0] <- '31804'; car[i,1] <-'2009';car[i,2] <-'Ford';car[i,3] <-'Ka';
	car[i,4] <-'259413';car[i,5] <-'900000';car[i,6] <-'310'; car[i,7] <-'false';
	i<- i + 1; // i = 26
	car[i,0] <- '64158'; car[i,1] <-'2002';car[i,2] <-'Fiat';car[i,3] <-'Uno';
	car[i,4] <-'166585';car[i,5] <-'750000';car[i,6] <-'310'; car[i,7] <-'true';
	i<- i + 1; // i = 27
	car[i,0] <- '93059'; car[i,1] <-'2001';car[i,2] <-'Chevrolet';car[i,3] <-'Aveo';
	car[i,4] <-'20574';car[i,5] <-'750000';car[i,6] <-'300'; car[i,7] <-'true';
	i<- i + 1; // i = 28
	car[i,0] <- '34695'; car[i,1] <-'2014';car[i,2] <-'Renault';car[i,3] <-'Sandero';
	car[i,4] <-'225457';car[i,5] <-'1000000';car[i,6] <-'300'; car[i,7] <-'false';
	i<- i + 1; // i = 29
	car[i,0] <- '36179'; car[i,1] <-'2012';car[i,2] <-'Peugeot';car[i,3] <-'206';
	car[i,4] <-'292098';car[i,5] <-'800000';car[i,6] <-'300'; car[i,7] <-'false';
	i<- i + 1; // i = 30
	car[i,0] <- '82071'; car[i,1] <-'2004';car[i,2] <-'Ford';car[i,3] <-'Fiesta';
	car[i,4] <-'10696';car[i,5] <-'1000000';car[i,6] <-'300'; car[i,7] <-'false';
	i<- i + 1; // i = 31
	car[i,0] <- '95244'; car[i,1] <-'2003';car[i,2] <-'Citroen';car[i,3] <-'C3';
	car[i,4] <-'255092';car[i,5] <-'800000';car[i,6] <-'300'; car[i,7] <-'false';
	i<- i + 1; // i = 32
	car[i,0] <- '43914'; car[i,1] <-'2013';car[i,2] <-'Renault';car[i,3] <-'Sandero';
	car[i,4] <-'54346';car[i,5] <-'1000000';car[i,6] <-'310'; car[i,7] <-'false';
	i<- i + 1; // i = 33
	car[i,0] <- '36624'; car[i,1] <-'2017';car[i,2] <-'Peugeot';car[i,3] <-'307';
	car[i,4] <-'210908';car[i,5] <-'900000';car[i,6] <-'300'; car[i,7] <-'true';
	i<- i + 1; // i = 34
	car[i,0] <- '18349'; car[i,1] <-'2009';car[i,2] <-'Ford';car[i,3] <-'Ranger';
	car[i,4] <-'295379';car[i,5] <-'1400000';car[i,6] <-'300'; car[i,7] <-'true';
	i<- i + 1; // i = 35
	car[i,0] <- '90858'; car[i,1] <-'2009';car[i,2] <-'Citroen';car[i,3] <-'C4';
	car[i,4] <-'200926';car[i,5] <-'900000';car[i,6] <-'300'; car[i,7] <-'false';
	i<- i + 1; // i = 36
	car[i,0] <- '87377'; car[i,1] <-'2017';car[i,2] <-'Toyota';car[i,3] <-'Hillux';
	car[i,4] <-'34942';car[i,5] <-'1400000';car[i,6] <-'300'; car[i,7] <-'false';
	i<- i + 1; // i = 37
	car[i,0] <- '66375'; car[i,1] <-'2017';car[i,2] <-'Ford';car[i,3] <-'Ranger';
	car[i,4] <-'57459';car[i,5] <-'1400000';car[i,6] <-'300'; car[i,7] <-'false';
	i<- i + 1; // i = 38
	car[i,0] <- '24056'; car[i,1] <-'2021';car[i,2] <-'Fiat';car[i,3] <-'Cronos';
	car[i,4] <-'65000';car[i,5] <-'2500000';car[i,6] <-'300'; car[i,7] <-'false';
	i<- i + 1; // i = 39
	car[i,0] <- '82155'; car[i,1] <-'2011';car[i,2] <-'Chevrolet';car[i,3] <-'Celta';
	car[i,4] <-'88250';car[i,5] <-'1000000';car[i,6] <-'300'; car[i,7] <-'false';
	i<- i + 1; // i = 40
	car[i,0] <- '92865'; car[i,1] <-'2022';car[i,2] <-'Renault';car[i,3] <-'Koleos';
	car[i,4] <-'0';car[i,5] <-'3000000';car[i,6] <-'300'; car[i,7] <-'false';
	i<- i + 1; // i = 41
	car[i,0] <- '28525'; car[i,1] <-'2004';car[i,2] <-'Ford';car[i,3] <-'Ka';
	car[i,4] <-'238771';car[i,5] <-'800000';car[i,6] <-'290'; car[i,7] <-'false';
	i<- i + 1; // i = 42
	car[i,0] <- '95062'; car[i,1] <-'2007';car[i,2] <-'Fiat';car[i,3] <-'Uno';
	car[i,4] <-'2168';car[i,5] <-'900000';car[i,6] <-'290'; car[i,7] <-'false';
	i<- i + 1; // i = 43	
	car[i,0] <- '84885'; car[i,1] <-'2002';car[i,2] <-'Chevrolet';car[i,3] <-'Aveo';
	car[i,4] <-'68598';car[i,5] <-'760000';car[i,6] <-'290'; car[i,7] <-'false';
	i<- i + 1; // i = 44
	car[i,0] <- '61556'; car[i,1] <-'2004';car[i,2] <-'Renault';car[i,3] <-'Clio';
	car[i,4] <-'218679';car[i,5] <-'800000';car[i,6] <-'290'; car[i,7] <-'false';
	i<- i + 1; // i = 45
	car[i,0] <- '48078'; car[i,1] <-'2009';car[i,2] <-'Ford	';car[i,3] <-'Focus';
	car[i,4] <-'0';car[i,5] <-'6000000';car[i,6] <-'310'; car[i,7] <-'true';
	i<- i + 1; // i = 46	
	car[i,0] <- '81821'; car[i,1] <-'2004';car[i,2] <-'Peugeot';car[i,3] <-'307';
	car[i,4] <-'0';car[i,5] <-'5000000';car[i,6] <-'310'; car[i,7] <-'true';
	i<- i + 1; // i = 47
	car[i,0] <- '45835'; car[i,1] <-'2017';car[i,2] <-'Citroen';car[i,3] <-'C4';
	car[i,4] <-'295795';car[i,5] <-'1400000';car[i,6] <-'300'; car[i,7] <-'false';
	i<- i + 1; // i = 48
	car[i,0] <- '59579'; car[i,1] <-'2011';car[i,2] <-'BMW';car[i,3] <-'Serie 1';
	car[i,4] <-'21052';car[i,5] <-'1000000';car[i,6] <-'300'; car[i,7] <-'false';
	i<- i + 1; // i = 49
	car[i,0] <- '32104'; car[i,1] <-'2004';car[i,2] <-'Ford';car[i,3] <-'Ecosport';
	car[i,4] <-'0';car[i,5] <-'800000';car[i,6] <-'300'; car[i,7] <-'false';
	i<- i + 1; // i = 50
	car[i,0] <- '20815'; car[i,1] <-'2001';car[i,2] <-'Peugeot';car[i,3] <-'406';
	car[i,4] <-'25275';car[i,5] <-'900000';car[i,6] <-'300'; car[i,7] <-'true';
	i<- i + 1; // i = 51	
	car[i,0] <- '20815'; car[i,1] <-'2020';car[i,2] <-'Citroen';car[i,3] <-'C4';
	car[i,4] <-'70000';car[i,5] <-'2000000';car[i,6] <-'300'; car[i,7] <-'true';
	i<- i + 1; // i = 52	
	car[i,0] <- '82792'; car[i,1] <-'2005';car[i,2] <-'BMW';car[i,3] <-'Serie 1';
	car[i,4] <-'34232';car[i,5] <-'800000';car[i,6] <-'300'; car[i,7] <-'true';
	i<- i + 1; // i = 53
	car[i,0] <- '29883'; car[i,1] <-'2022';car[i,2] <-'Ford';car[i,3] <-'Focus';
	car[i,4] <-'0';car[i,5] <-'3000000';car[i,6] <-'310'; car[i,7] <-'true';
	i<- i + 1; // i = 54
	car[i,0] <- '79185'; car[i,1] <-'2004';car[i,2] <-'Peugeot';car[i,3] <-'206';
	car[i,4] <-'11737';car[i,5] <-'800000';car[i,6] <-'310'; car[i,7] <-'true';
	i<- i + 1; // i = 55
	car[i,0] <- '45294'; car[i,1] <-'2002';car[i,2] <-'Mercedes Benz';car[i,3] <-'Clase C';
	car[i,4] <-'212365';car[i,5] <-'750000';car[i,6] <-'310'; car[i,7] <-'true';
	i<- i + 1; // i = 56
	car[i,0] <- '44666'; car[i,1] <-'2016';car[i,2] <-'Honda';car[i,3] <-'Civic';
	car[i,4] <-'59215';car[i,5] <-'1200000';car[i,6] <-'300'; car[i,7] <-'true';
	i<- i + 1; // i = 57
	car[i,0] <- '74992'; car[i,1] <-'2000';car[i,2] <-'Hiundai';car[i,3] <-'Accent';
	car[i,4] <-'76590';car[i,5] <-'750000';car[i,6] <-'310'; car[i,7] <-'true';
	i<- i + 1; // i = 58	
	car[i,0] <- '36023'; car[i,1] <-'2005';car[i,2] <-'Peugeot';car[i,3] <-'307';
	car[i,4] <-'84930';car[i,5] <-'800000';car[i,6] <-'310'; car[i,7] <-'true';
	i<- i + 1; // i = 59	
	car[i,0] <- '95382'; car[i,1] <-'2002';car[i,2] <-'Mercedes Benz';car[i,3] <-'Clase 1';
	car[i,4] <-'161533';car[i,5] <-'750000';car[i,6] <-'310'; car[i,7] <-'true';
	i<- i + 1; // i = 60	
	car[i,0] <- '55079'; car[i,1] <-'2019';car[i,2] <-'Honda';car[i,3] <-'Fit';
	car[i,4] <-'247693';car[i,5] <-'1800000';car[i,6] <-'300'; car[i,7] <-'false';
	i<- i + 1; // i = 61
	car[i,0] <- '90078'; car[i,1] <-'2006';car[i,2] <-'Hiundai';car[i,3] <-'Tucson';
	car[i,4] <-'74024';car[i,5] <-'900000';car[i,6] <-'300'; car[i,7] <-'true';
	i<- i + 1; // i = 62
	car[i,0] <- '17179'; car[i,1] <-'2022';car[i,2] <-'Renault';car[i,3] <-'Sandero';
	car[i,4] <-'0';car[i,5] <-'300000';car[i,6] <-'300'; car[i,7] <-'false';
	i<- i + 1; // i = 63
	car[i,0] <- '99202'; car[i,1] <-'2014';car[i,2] <-'Ford';car[i,3] <-'Fiesta';
	car[i,4] <-'17571';car[i,5] <-'100000';car[i,6] <-'300'; car[i,7] <-'true';
	i<- i + 1; // i = 64
	car[i,0] <- '88142'; car[i,1] <-'2007';car[i,2] <-'Peugeot';car[i,3] <-'207';
	car[i,4] <-'32178';car[i,5] <-'900000';car[i,6] <-'290'; car[i,7] <-'true';
	i<- i + 1; // i = 65
	car[i,0] <- '33001'; car[i,1] <-'2009';car[i,2] <-'Citroen';car[i,3] <-'C3';
	car[i,4] <-'199763';car[i,5] <-'900000';car[i,6] <-'290'; car[i,7] <-'false';
	i<- i + 1; // i = 66
	car[i,0] <- '36954'; car[i,1] <-'2022';car[i,2] <-'BMW';car[i,3] <-'Serie 4';
	car[i,4] <-'0';car[i,5] <-'2600000';car[i,6] <-'290'; car[i,7] <-'false';
	i<- i + 1; // i = 67
	car[i,0] <- '37964'; car[i,1] <-'2000';car[i,2] <-'Ford';car[i,3] <-'Escort';
	car[i,4] <-'84709';car[i,5] <-'750000';car[i,6] <-'300'; car[i,7] <-'true';
	i<- i + 1; // i = 68
	car[i,0] <- '46095'; car[i,1] <-'2002';car[i,2] <-'Citroen';car[i,3] <-'C3';
	car[i,4] <-'221309';car[i,5] <-'750000';car[i,6] <-'300'; car[i,7] <-'false';
	i<- i + 1; // i = 69
	car[i,0] <- '61093'; car[i,1] <-'2018';car[i,2] <-'Peugeot';car[i,3] <-'208';
	car[i,4] <-'137223';car[i,5] <-'1600000';car[i,6] <-'300'; car[i,7] <-'false';
	i<- i + 1; // i = 70
	car[i,0] <- '12671'; car[i,1] <-'2001';car[i,2] <-'BMW';car[i,3] <-'Serie 1';
	car[i,4] <-'261278';car[i,5] <-'750000';car[i,6] <-'310'; car[i,7] <-'true';
	i<- i + 1; // i = 71
	car[i,0] <- '53953'; car[i,1] <-'2015';car[i,2] <-'Ford';car[i,3] <-'Ecosport';
	car[i,4] <-'181816';car[i,5] <-'1100000';car[i,6] <-'310'; car[i,7] <-'true';
	i<- i + 1; // i = 72
	car[i,0] <- '32243'; car[i,1] <-'2020';car[i,2] <-'Peugeot';car[i,3] <-'208';
	car[i,4] <-'100000';car[i,5] <-'2000000';car[i,6] <-'310'; car[i,7] <-'false';
	i<- i + 1; // i = 73
	car[i,0] <- '14143'; car[i,1] <-'2019';car[i,2] <-'Mercedes Benz';car[i,3] <-'Clase 4';
	car[i,4] <-'3692';car[i,5] <-'1800000';car[i,6] <-'310'; car[i,7] <-'false';
	i<- i + 1; // i = 74
	car[i,0] <- '69799'; car[i,1] <-'2017';car[i,2] <-'Honda';car[i,3] <-'Civic';
	car[i,4] <-'91365';car[i,5] <-'1400000';car[i,6] <-'310'; car[i,7] <-'true';
	i<- i + 1; // i = 75
	car[i,0] <- '38539'; car[i,1] <-'2021';car[i,2] <-'Hiundai';car[i,3] <-'Genesis';
	car[i,4] <-'35000';car[i,5] <-'2500000';car[i,6] <-'300'; car[i,7] <-'true';
	i<- i + 1; // i = 76
	car[i,0] <- '54077'; car[i,1] <-'2020';car[i,2] <-'Peugeot';car[i,3] <-'308';
	car[i,4] <-'85000';car[i,5] <-'2000000';car[i,6] <-'300'; car[i,7] <-'false';
	i<- i + 1; // i = 77
	car[i,0] <- '29535'; car[i,1] <-'2022';car[i,2] <-'Honda';car[i,3] <-'Tucson';
	car[i,4] <-'16919';car[i,5] <-'1100000';car[i,6] <-'300'; car[i,7] <-'false';
	i<- i + 1; // i = 78
	car[i,0] <- '62223'; car[i,1] <-'2015';car[i,2] <-'Mercedes Benz';car[i,3] <-'Clase 4';
	car[i,4] <-'0';car[i,5] <-'2600000';car[i,6] <-'300'; car[i,7] <-'false';
	i<- i + 1; // i = 79
	car[i,0] <- '33287'; car[i,1] <-'2006';car[i,2] <-'Hiundai';car[i,3] <-'Veloster';
	car[i,4] <-'249825';car[i,5] <-'900000';car[i,6] <-'310'; car[i,7] <-'true';
	i<- i + 1; // i = 80
	car[i,0] <- '31031'; car[i,1] <-'2005';car[i,2] <-'Peugeot';car[i,3] <-'206';
	car[i,4] <-'265718';car[i,5] <-'800000';car[i,6] <-'310'; car[i,7] <-'true';
	i<- i + 1; // i = 81
	car[i,0] <- '61646'; car[i,1] <-'2022';car[i,2] <-'Citroen';car[i,3] <-'C4';
	car[i,4] <-'0';car[i,5] <-'300000';car[i,6] <-'310'; car[i,7] <-'true';
	i<- i + 1; // i = 82
	car[i,0] <- '11680'; car[i,1] <-'2000';car[i,2] <-'Toyota';car[i,3] <-'Corolla';
	car[i,4] <-'23128';car[i,5] <-'750000';car[i,6] <-'290'; car[i,7] <-'false';
	i<- i + 1; // i = 83
	car[i,0] <- '11812'; car[i,1] <-'2016';car[i,2] <-'Ford';car[i,3] <-'Ranger';
	car[i,4] <-'227480';car[i,5] <-'1200000';car[i,6] <-'290'; car[i,7] <-'true';
	i<- i + 1; // i = 84
	car[i,0] <- '53661'; car[i,1] <-'2020';car[i,2] <-'Fiat';car[i,3] <-'Argo';
	car[i,4] <-'120000';car[i,5] <-'2000000';car[i,6] <-'290'; car[i,7] <-'false';
	i<- i + 1; // i = 85
	car[i,0] <- '58928'; car[i,1] <-'2014';car[i,2] <-'Chevrolet';car[i,3] <-'Cruze';
	car[i,4] <-'139131';car[i,5] <-'1000000';car[i,6] <-'290'; car[i,7] <-'true';
	i<- i + 1; // i = 86
	car[i,0] <- '91877'; car[i,1] <-'2022';car[i,2] <-'Renault';car[i,3] <-'Sandero';
	car[i,4] <-'0';car[i,5] <-'3000000';car[i,6] <-'290'; car[i,7] <-'false';
	i<- i + 1; // i = 87
	car[i,0] <- '55367'; car[i,1] <-'2007';car[i,2] <-'Ford';car[i,3] <-'Ecosport';
	car[i,4] <-'24092';car[i,5] <-'900000';car[i,6] <-'300'; car[i,7] <-'false';
	i<- i + 1; // i = 88
	car[i,0] <- '21620'; car[i,1] <-'2002';car[i,2] <-'Fiat';car[i,3] <-'Uno';
	car[i,4] <-'153338';car[i,5] <-'750000';car[i,6] <-'300'; car[i,7] <-'false';
	i<- i + 1; // i = 89
	car[i,0] <- '50554'; car[i,1] <-'2020';car[i,2] <-'Chevrolet';car[i,3] <-'Uno';
	car[i,4] <-'153338';car[i,5] <-'750000';car[i,6] <-'300'; car[i,7] <-'true';
	
FinSubProceso


SubProceso setEmployeeList(employee)
	Definir i Como Entero;
	
	i<-0;        // i = 0
	employee[i,0] <- '100'; employee[i,1] <-'Pablo';employee[i,2] <-'';employee[i,3] <-'Novara';
	employee[i,4] <-'San Martín 132';employee[i,5] <-'49';employee[i,6] <-'Argentina';
	i<- i + 1; // i = 1
	employee[i,0] <- '101'; employee[i,1] <-'Charles';employee[i,2] <-'';employee[i,3] <-'Babbage';
	employee[i,4] <-'España 131';employee[i,5] <-'32';employee[i,6] <-'Británica';
	i<- i + 1; // i = 2
	employee[i,0] <- '102'; employee[i,1] <-'Ángela';employee[i,2] <-'';employee[i,3] <-'Ruiz Robles';
	employee[i,4] <-'';employee[i,5] <-'54';employee[i,6] <-'Española';
	i<- i + 1; // i = 3
	employee[i,0] <- '103'; employee[i,1] <-'Grace';employee[i,2] <-'';employee[i,3] <-'Murray Hopper';
	employee[i,4] <-'Catamarca 6585';employee[i,5] <-'65';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 4
	employee[i,0] <- '104'; employee[i,1] <-'Niklaus';employee[i,2] <-'';employee[i,3] <-'Wirth Emil';
	employee[i,4] <-'Carcarañá 328';employee[i,5] <-'54';employee[i,6] <-'Suiza';
	i<- i + 1; // i = 5
	employee[i,0] <- '105'; employee[i,1] <-'James';employee[i,2] <-'Arthur';employee[i,3] <-'Gosling';
	employee[i,4] <-'Canadá 6754';employee[i,5] <-'50';employee[i,6] <-'Canadiense';
	i<- i + 1; // i = 6
	employee[i,0] <- '106'; employee[i,1] <-'Guido';employee[i,2] <-'';employee[i,3] <-'Van Rossum';
	employee[i,4] <-'Sarmiento 185';employee[i,5] <-'54';employee[i,6] <-'Holandesa';
	i<- i + 1; // i = 7
	employee[i,0] <- '107'; employee[i,1] <-'Kenneth';employee[i,2] <-'Lane';employee[i,3] <-'Thompson';
	employee[i,4] <-'Córdoba 927';employee[i,5] <-'32';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 8
	employee[i,0] <- '108'; employee[i,1] <-'William';employee[i,2] <-'Henry';employee[i,3] <-'Gates III';
	employee[i,4] <-'Rivadavia 932';employee[i,5] <-'54';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 9
	employee[i,0] <- '109'; employee[i,1] <-'Stephen';employee[i,2] <-'Gary';employee[i,3] <-'Wozniak';
	employee[i,4] <-'Chubut 594';employee[i,5] <-'32';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 10
	employee[i,0] <- '110'; employee[i,1] <-'Margaret';employee[i,2] <-'';employee[i,3] <-'Hamilton';
	employee[i,4] <-'Jujuy 385';employee[i,5] <-'54';employee[i,6] <-'Británica';
	i<- i + 1; // i = 11
	employee[i,0] <- '111'; employee[i,1] <-'Mark';employee[i,2] <-'Elliot';employee[i,3] <-'Zuckerberg';
	employee[i,4] <-'Perú 674';employee[i,5] <-'32';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 12
	employee[i,0] <- '112'; employee[i,1] <-'Louis';employee[i,2] <-'';employee[i,3] <-'Pouzin';
	employee[i,4] <-'Rioja 376';employee[i,5] <-'60';employee[i,6] <-'Francesa';
	i<- i + 1; // i = 13
	employee[i,0] <- '113'; employee[i,1] <-'Isis';employee[i,2] <-'';employee[i,3] <-'Anchalee';
	employee[i,4] <-'Patagonia 931';employee[i,5] <-'32';employee[i,6] <-'Canadiense';
	i<- i + 1; // i = 14
	employee[i,0] <- '114'; employee[i,1] <-'Lawrence';employee[i,2] <-'Edward';employee[i,3] <-'Page';
	employee[i,4] <-'Tierra del Fuego 317';employee[i,5] <-'49';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 15
	employee[i,0] <- '115'; employee[i,1] <-'Serguéi';employee[i,2] <-'';employee[i,3] <-'Brin';
	employee[i,4] <-'';employee[i,5] <-'32';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 16
	employee[i,0] <- '116'; employee[i,1] <-'Karen';employee[i,2] <-'';employee[i,3] <-'Jones';
	employee[i,4] <-'Santa Fe 971';employee[i,5] <-'54';employee[i,6] <-'Británica';
	i<- i + 1; // i = 17
	employee[i,0] <- '117'; employee[i,1] <-'Hedwig';employee[i,2] <-'Eva Maria';employee[i,3] <-'Kiesler';
	employee[i,4] <-'Paraguay 1975';employee[i,5] <-'32';employee[i,6] <-'Austríaca';
	i<- i + 1; // i = 18
	employee[i,0] <- '118'; employee[i,1] <-'George';employee[i,2] <-'Carl Johann';employee[i,3] <-'Antheil';
	employee[i,4] <-'Río Negro 495';employee[i,5] <-'54';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 19
	employee[i,0] <- '119'; employee[i,1] <-'Creola';employee[i,2] <-'Katherine';employee[i,3] <-'Johnson';
	employee[i,4] <-'Croacia 674';employee[i,5] <-'32';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 20
	employee[i,0] <- '120'; employee[i,1] <-'Evelyn';employee[i,2] <-'';employee[i,3] <-'Berezin';
	employee[i,4] <-'Corrientes 674';employee[i,5] <-'54';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 21
	employee[i,0] <- '121'; employee[i,1] <-'Stephanie';employee[i,2] <-'Steve';employee[i,3] <-'Shirley';
	employee[i,4] <-'Formosa 3846';employee[i,5] <-'32';employee[i,6] <-'Británica';
	i<- i + 1; // i = 22
	employee[i,0] <- '122'; employee[i,1] <-'Mary';employee[i,2] <-'Allen';employee[i,3] <-'Wilkes';
	employee[i,4] <-'San Lorenzo 495';employee[i,5] <-'62';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 23
	employee[i,0] <- '123'; employee[i,1] <-'Alan';employee[i,2] <-'Mathison';employee[i,3] <-'Turing';
	employee[i,4] <-'Santa Fe 685';employee[i,5] <-'32';employee[i,6] <-'Británica';
	i<- i + 1; // i = 24
	employee[i,0] <- '124'; employee[i,1] <-'James';employee[i,2] <-'';employee[i,3] <-'Gosling';
	employee[i,4] <-'Venezuela 576';employee[i,5] <-'54';employee[i,6] <-'Canadiense';
	i<- i + 1; // i = 25
	employee[i,0] <- '125'; employee[i,1] <-'Al';employee[i,2] <-'-';employee[i,3] <-'Juarismi';
	employee[i,4] <-'Santa Fe 825';employee[i,5] <-'32';employee[i,6] <-'Iraquí';
	i<- i + 1; // i = 26
	employee[i,0] <- '126'; employee[i,1] <-'Gearge';employee[i,2] <-'';employee[i,3] <-'Boole';
	employee[i,4] <-'Sarmiento 685';employee[i,5] <-'49';employee[i,6] <-'Británica';
	i<- i + 1; // i = 27
	employee[i,0] <- '127'; employee[i,1] <-'Maurice';employee[i,2] <-'Vincent';employee[i,3] <-'Wilkes';
	employee[i,4] <-'Salta 586';employee[i,5] <-'48';employee[i,6] <-'Británica';
	i<- i + 1; // i = 28
	employee[i,0] <- '128'; employee[i,1] <-'John';employee[i,2] <-'Warner';employee[i,3] <-'Backus';
	employee[i,4] <-'Salta 3825';employee[i,5] <-'54';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 29
	employee[i,0] <- '129'; employee[i,1] <-'John';employee[i,2] <-'';employee[i,3] <-'McCarthy';
	employee[i,4] <-'Urquiza 628';employee[i,5] <-'32';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 30
	employee[i,0] <- '130'; employee[i,1] <-'Kenneth';employee[i,2] <-'Eugene';employee[i,3] <-'Iverson';
	employee[i,4] <-'Rioja 825';employee[i,5] <-'54';employee[i,6] <-'Canadiense';
	i<- i + 1; // i = 31
	employee[i,0] <- '131'; employee[i,1] <-'Carol';employee[i,2] <-'';employee[i,3] <-'Shaw';
	employee[i,4] <-'San Juan 396';employee[i,5] <-'32';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 32
	employee[i,0] <- '132'; employee[i,1] <-'John';employee[i,2] <-'George';employee[i,3] <-'Kemeny';
	employee[i,4] <-'Santa Fe 935';employee[i,5] <-'54';employee[i,6] <-'Húngara';
	i<- i + 1; // i = 33
	employee[i,0] <- '133'; employee[i,1] <-'Thomas';employee[i,2] <-'Eugene';employee[i,3] <-'Kurtz';
	employee[i,4] <-'La Pampa 4682';employee[i,5] <-'33';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 34
	employee[i,0] <- '134'; employee[i,1] <-'Seymour';employee[i,2] <-'';employee[i,3] <-'Papert';
	employee[i,4] <-'Salta  546';employee[i,5] <-'54';employee[i,6] <-'Sudafricana';
	i<- i + 1; // i = 35
	employee[i,0] <- '135'; employee[i,1] <-'Niklaus';employee[i,2] <-'Emil';employee[i,3] <-'Wirth';
	employee[i,4] <-'San Martín 1649';employee[i,5] <-'32';employee[i,6] <-'Suiza';
	i<- i + 1; // i = 36
	employee[i,0] <- '136'; employee[i,1] <-'Dennis';employee[i,2] <-'Ritchie';employee[i,3] <-'MacAlistair';
	employee[i,4] <-'San Juan 825';employee[i,5] <-'54';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 37
	employee[i,0] <- '137'; employee[i,1] <-'Alan';employee[i,2] <-'Curtis';employee[i,3] <-'Kay';
	employee[i,4] <-'Jujuy 246';employee[i,5] <-'81';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 38
	employee[i,0] <- '138'; employee[i,1] <-'Brian';employee[i,2] <-'Wilson';employee[i,3] <-'Kernighan';
	employee[i,4] <-'Maipú 731';employee[i,5] <-'54';employee[i,6] <-'Canadiense';
	i<- i + 1; // i = 39
	employee[i,0] <- '139'; employee[i,1] <-'Jean';employee[i,2] <-'David';employee[i,3] <-'Ichbiah';
	employee[i,4] <-'Francia 1764';employee[i,5] <-'69';employee[i,6] <-'Francesa';
	i<- i + 1; // i = 40
	employee[i,0] <- '140'; employee[i,1] <-'Bjarne';employee[i,2] <-'';employee[i,3] <-'Stroustrup';
	employee[i,4] <-'Belgrano 297';employee[i,5] <-'54';employee[i,6] <-'Danesa';
	i<- i + 1; // i = 41
	employee[i,0] <- '141'; employee[i,1] <-'Konrad';employee[i,2] <-'Ernst Otto';employee[i,3] <-'Zuse';
	employee[i,4] <-'Santa Cruz 4679';employee[i,5] <-'32';employee[i,6] <-'Alemana';
	i<- i + 1; // i = 42
	employee[i,0] <- '142'; employee[i,1] <-'Jack';employee[i,2] <-'St. Clair';employee[i,3] <-'Kilby';
	employee[i,4] <-'Río Negro 946';employee[i,5] <-'54';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 43
	employee[i,0] <- '143'; employee[i,1] <-'Claude';employee[i,2] <-'Elwood';employee[i,3] <-'Shannon';
	employee[i,4] <-'Santa Fe 1679';employee[i,5] <-'32';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 44
	employee[i,0] <- '144'; employee[i,1] <-'Betty';employee[i,2] <-'Snyder';employee[i,3] <-'Holberton';
	employee[i,4] <-'Chaco 8256';employee[i,5] <-'54';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 45
	employee[i,0] <- '145'; employee[i,1] <-'John';employee[i,2] <-'William';employee[i,3] <-'Mauchly';
	employee[i,4] <-'Santa Fe 502';employee[i,5] <-'71';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 46
	employee[i,0] <- '146'; employee[i,1] <-'Jean';employee[i,2] <-'Jennings';employee[i,3] <-'Bartik';
	employee[i,4] <-'Catamarca 674';employee[i,5] <-'54';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 47
	employee[i,0] <- '147'; employee[i,1] <-'John';employee[i,2] <-'Presper';employee[i,3] <-'Eckert ';
	employee[i,4] <-'Islas Malvinas 685';employee[i,5] <-'32';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 48
	employee[i,0] <- '148'; employee[i,1] <-'Kathleen';employee[i,2] <-'Rita';employee[i,3] <-'McNulty Mauchly Antonelli';
	employee[i,4] <-'Mitre 823';employee[i,5] <-'54';employee[i,6] <-'Irlandesa';
	i<- i + 1; // i = 49
	employee[i,0] <- '149'; employee[i,1] <-'William';employee[i,2] <-'Bradford';employee[i,3] <-'Shockley';
	employee[i,4] <-'Belgrano 7136';employee[i,5] <-'52';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 50
	employee[i,0] <- '150'; employee[i,1] <-'Marlyn';employee[i,2] <-'Wescoff';employee[i,3] <-'Meltzer';
	employee[i,4] <-'Roca 645';employee[i,5] <-'54';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 51
	employee[i,0] <- '151'; employee[i,1] <-'Houser';employee[i,2] <-'Houser';employee[i,3] <-'Brattain';
	employee[i,4] <-'Av. San Martín';employee[i,5] <-'42';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 52
	employee[i,0] <- '152'; employee[i,1] <-'Ruth';employee[i,2] <-'Lichterman';employee[i,3] <-'Teitelbaum';
	employee[i,4] <-'Belgrano 469';employee[i,5] <-'54';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 53
	employee[i,0] <- '153'; employee[i,1] <-'John';employee[i,2] <-'';employee[i,3] <-'Bardeen';
	employee[i,4] <-'25 de Mayo 2864';employee[i,5] <-'61';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 54
	employee[i,0] <- '154'; employee[i,1] <-'Frances';employee[i,2] <-'Bilas';employee[i,3] <-'Spence';
	employee[i,4] <-'9 de Julio 1764';employee[i,5] <-'54';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 55
	employee[i,0] <- '155'; employee[i,1] <-'Tom';employee[i,2] <-'';employee[i,3] <-'Kilburn';
	employee[i,4] <-'1 de Mayo 367';employee[i,5] <-'27';employee[i,6] <-'Británica';
	i<- i + 1; // i = 56
	employee[i,0] <- '156'; employee[i,1] <-'William';employee[i,2] <-'William';employee[i,3] <-'Mauchly';
	employee[i,4] <-'25 de MAyo 546';employee[i,5] <-'21';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 57
	employee[i,0] <- '157'; employee[i,1] <-'Wallace';employee[i,2] <-'John';employee[i,3] <-'Eckert';
	employee[i,4] <-'9 de Julio 1346';employee[i,5] <-'79';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 58
	employee[i,0] <- '158'; employee[i,1] <-'Maurice';employee[i,2] <-'Vincent';employee[i,3] <-'Wilkes';
	employee[i,4] <-'25 de Mayo 2679';employee[i,5] <-'54';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 59
	employee[i,0] <- '159'; employee[i,1] <-'Kenneth';employee[i,2] <-'Harry';employee[i,3] <-'Olsen';
	employee[i,4] <-'San Lorenzo 7631';employee[i,5] <-'71';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 60
	employee[i,0] <- '160'; employee[i,1] <-'Sergei';employee[i,2] <-'Alexeevich';employee[i,3] <-'Lebedev';
	employee[i,4] <-'1 de Mayo 6479';employee[i,5] <-'54';employee[i,6] <-'Ucraniana';
	i<- i + 1; // i = 61
	employee[i,0] <- '161'; employee[i,1] <-'Eugene';employee[i,2] <-'Myron';employee[i,3] <-'Amdahl';
	employee[i,4] <-'Salta 5679';employee[i,5] <-'32';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 62
	employee[i,0] <- '162'; employee[i,1] <-'Brendan';employee[i,2] <-'';employee[i,3] <-'Eich';
	employee[i,4] <-'Santa Fe 4698';employee[i,5] <-'54';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 63
	employee[i,0] <- '163'; employee[i,1] <-'Yukihiro';employee[i,2] <-'';employee[i,3] <-'Matsumoto';
	employee[i,4] <-'Rafael Obligado 648';employee[i,5] <-'32';employee[i,6] <-'Japonés';
	i<- i + 1; // i = 64
	employee[i,0] <- '164'; employee[i,1] <-'John';employee[i,2] <-'';employee[i,3] <-'Blankenbaker';
	employee[i,4] <-'Entre Ríos 645';employee[i,5] <-'54';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 65
	employee[i,0] <- '165'; employee[i,1] <-'Joan';employee[i,2] <-'Elisabeth';employee[i,3] <-'Lowther Murray';
	employee[i,4] <-'San Martín 764';employee[i,5] <-'32';employee[i,6] <-'Británica';
	i<- i + 1; // i = 66
	employee[i,0] <- '166'; employee[i,1] <-'Pitágoras';employee[i,2] <-'';employee[i,3] <-'De Samos';
	employee[i,4] <-'Rivadavia 9754';employee[i,5] <-'54';employee[i,6] <-'Griega';
	i<- i + 1; // i = 67
	employee[i,0] <- '167'; employee[i,1] <-'Andrew';employee[i,2] <-'Johm';employee[i,3] <-'Wiles';
	employee[i,4] <-'Córdoba 925';employee[i,5] <-'66';employee[i,6] <-'Británica';
	i<- i + 1; // i = 68
	employee[i,0] <- '168'; employee[i,1] <-'Isaac';employee[i,2] <-'';employee[i,3] <-'Newton';
	employee[i,4] <-'Salta 582';employee[i,5] <-'54';employee[i,6] <-'Británica';
	i<- i + 1; // i = 69
	employee[i,0] <- '169'; employee[i,1] <-'Gottfried';employee[i,2] <-'Wilhelm';employee[i,3] <-'Leibniz';
	employee[i,4] <-'Urquiza 3164';employee[i,5] <-'32';employee[i,6] <-'Alemana';
	i<- i + 1; // i = 70
	employee[i,0] <- '170'; employee[i,1] <-'Leonardo';employee[i,2] <-'';employee[i,3] <-'Pisano Blgollo';
	employee[i,4] <-'25 de Mayo 1810';employee[i,5] <-'54';employee[i,6] <-'Italiana';
	i<- i + 1; // i = 71
	employee[i,0] <- '171'; employee[i,1] <-'René';employee[i,2] <-'';employee[i,3] <-'Descartes';
	employee[i,4] <-'9 de Julio 1816';employee[i,5] <-'32';employee[i,6] <-'Francesa';
	i<- i + 1; // i = 72
	employee[i,0] <- '172'; employee[i,1] <-'Euclides';employee[i,2] <-'';employee[i,3] <-'Neucrates';
	employee[i,4] <-'Santa Fe 1985';employee[i,5] <-'54';employee[i,6] <-'Griega';
	i<- i + 1; // i = 73
	employee[i,0] <- '173'; employee[i,1] <-'Georg';employee[i,2] <-'Friedrich Bernhard';employee[i,3] <-'Riemann';
	employee[i,4] <-'Martín Fierro 574';employee[i,5] <-'48';employee[i,6] <-'Alemana';
	i<- i + 1; // i = 74
	employee[i,0] <- '174'; employee[i,1] <-'Carl';employee[i,2] <-'Friedrich';employee[i,3] <-'Gauss';
	employee[i,4] <-'1 de MAyo 582';employee[i,5] <-'21';employee[i,6] <-'Alemana';
	i<- i + 1; // i = 75
	employee[i,0] <- '175'; employee[i,1] <-'Leonhard';employee[i,2] <-'Paul';employee[i,3] <-'Euler';
	employee[i,4] <-'Jujuy 485';employee[i,5] <-'32';employee[i,6] <-'Suiza';
	i<- i + 1; // i = 76
	employee[i,0] <- '176'; employee[i,1] <-'Linus';employee[i,2] <-'Benedict';employee[i,3] <-'Torvalds';
	employee[i,4] <-'Alvear 162';employee[i,5] <-'59';employee[i,6] <-'Finlandesa';
	i<- i + 1; // i = 77
	employee[i,0] <- '177'; employee[i,1] <-'Anders';employee[i,2] <-'';employee[i,3] <-'Hejlsberg';
	employee[i,4] <-'Belgrano 185';employee[i,5] <-'57';employee[i,6] <-'Danesa';
	i<- i + 1; // i = 78
	employee[i,0] <- '178'; employee[i,1] <-'Timothy';employee[i,2] <-'John';employee[i,3] <-'Berners-Lee';
	employee[i,4] <-'Salta 685';employee[i,5] <-'72';employee[i,6] <-'Británica';
	i<- i + 1; // i = 79
	employee[i,0] <- '179'; employee[i,1] <-'Donald';employee[i,2] <-'Ervin';employee[i,3] <-'Knuth';
	employee[i,4] <-'Santa Fe 384';employee[i,5] <-'80';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 80
	employee[i,0] <- '180'; employee[i,1] <-'Paul';employee[i,2] <-'Marie';employee[i,3] <-'Ghislain Otlet';
	employee[i,4] <-'Jacinta del Coro 387';employee[i,5] <-'82';employee[i,6] <-'Belga';
	i<- i + 1; // i = 81
	employee[i,0] <- '181'; employee[i,1] <-'Leonard';employee[i,2] <-'';employee[i,3] <-'Kleinrock';
	employee[i,4] <-'San Lorenzo 831';employee[i,5] <-'75';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 82
	employee[i,0] <- '182'; employee[i,1] <-'Joseph';employee[i,2] <-'Carl';employee[i,3] <-'Robnett Licklider';
	employee[i,4] <-'Mendoza 685';employee[i,5] <-'64';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 83
	employee[i,0] <- '183'; employee[i,1] <-'Robert';employee[i,2] <-'William';employee[i,3] <-'Taylor';
	employee[i,4] <-'Mendoza 525';employee[i,5] <-'85';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 84
	employee[i,0] <- '184'; employee[i,1] <-'Lawrence';employee[i,2] <-'G.';employee[i,3] <-'Roberts';
	employee[i,4] <-'Catamarca 645';employee[i,5] <-'54';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 85
	employee[i,0] <- '185'; employee[i,1] <-'Barry';employee[i,2] <-'D.';employee[i,3] <-'Wessler';
	employee[i,4] <-'Juana Azurduy 121';employee[i,5] <-'61';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 86
	employee[i,0] <- '186'; employee[i,1] <-'Raymond';employee[i,2] <-'Samuel';employee[i,3] <-'Tomlinson';
	employee[i,4] <-'';employee[i,5] <-'54';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 87
	employee[i,0] <- '187'; employee[i,1] <-'Augusta';employee[i,2] <-'Ada';employee[i,3] <-'Lovelace';
	employee[i,4] <-'Belgrano 1323';employee[i,5] <-'26';employee[i,6] <-'Británica';
	i<- i + 1; // i = 88
	employee[i,0] <- '188'; employee[i,1] <-'Ronald';employee[i,2] <-'Lewis';employee[i,3] <-'Graham';
	employee[i,4] <-'Güemes 425';employee[i,5] <-'54';employee[i,6] <-'Estadounidense';
	i<- i + 1; // i = 89
	employee[i,0] <- '189'; employee[i,1] <-'Oren';employee[i,2] <-'';employee[i,3] <-'Patashnik';
	employee[i,4] <-'San MArtín 495';employee[i,5] <-'62';employee[i,6] <-'Estadounidense';
	
FinSubProceso

SubProceso setPaymentPlanList(paymentsPlan)
	
	Definir i Como Entero;
	i<-0;
	paymentsPlan[i,0] <- '101'; paymentsPlan[i,1] <-'5000';paymentsPlan[i,2] <-'18';
	i<-i+1;
	paymentsPlan[i,0] <- '102'; paymentsPlan[i,1] <-'10000';paymentsPlan[i,2] <-'10';
	i<-i+1;
	paymentsPlan[i,0] <- '103'; paymentsPlan[i,1] <-'8000';paymentsPlan[i,2] <-'16';
	
FinSubProceso	

// Group 2 code

SubProceso  setSpareList(spares) // Subprocess to load spares
	Definir i Como Entero;
	i<-0;        // i = 0
	spares[i,0] <- '100123987'; spares[i,1] <-'optica';spares[i,2] <-'fiat';spares[i,3] <-'palio';
	spares[i,4] <-'15000';spares[i,5] <-'5';
	i<- i + 1;  // i = 1
	spares[i,0] <- '100034532'; spares[i,1] <-'bujia';spares[i,2] <-'bosch';spares[i,3] <-'bosch';
	spares[i,4] <-'1000';spares[i,5] <-'50';
	i<- i + 1; // i = 2
	spares[i,0] <- '132453644'; spares[i,1] <-'tasa';spares[i,2] <-'volkswagen';spares[i,3] <-'polo';
	spares[i,4] <-'1500';spares[i,5] <-'54';
	i<- i + 1; // i = 3	
	spares[i,0]	<- '132453646'; spares[i,1]<-'tasa';spares[i,2]<-'ford';spares[i,3]<-'focus';
	spares[i,4]	<- '1502'; spares[i,5]<-'54';
	i<- i + 1; // i = 4	
	spares[i,0]	<- '132453645'; spares[i,1]<-'optica';spares[i,2]<-'fiat';spares[i,3]<-'uno';
	spares[i,4]	<- '1501'; spares[i,5]<-'55';
	i<- i + 1; // i = 5	
	spares[i,0]	<- '132453644'; spares[i,1]<-'espejo';spares[i,2]<-'volkswagen';spares[i,3]<-'polo';
	spares[i,4]	<- '1502'; spares[i,5]<-'56';
	i<- i + 1; // i = 6	
	spares[i,0]	<- '132453647'; spares[i,1]<-'ruleman';spares[i,2]<-'toyota';spares[i,3]<-'corolla';
	spares[i,4]	<- '1503'; spares[i,5]<-'57'; 
	i<- i + 1; // i = 7	
	spares[i,0]	<- '132453648'; spares[i,1]<-'radiador';spares[i,2]<-'cheery';spares[i,3]<-'d2';
	spares[i,4]	<- '1504'; spares[i,5]<-'58';
	i<- i + 1; // i = 8	
	spares[i,0]	<- '132453649'; spares[i,1]<-'manguera de aire';spares[i,2]<-'renaul';spares[i,3]<-'clio';
	spares[i,4]	<- '1505'; spares[i,5]<-'59';
	i<- i + 1; // i = 9	
	spares[i,0]	<- '132453650'; spares[i,1]<-'bujia';spares[i,2]<-'peugeot';spares[i,3]<-'207 gti';
	spares[i,4]	<- '1506'; spares[i,5]<-'60';
	i<- i + 1; // i = 10	
	spares[i,0]	<- '132453651'; spares[i,1]<-'catalizador';spares[i,2]<-'citroen';spares[i,3]<-'13 v';
	spares[i,4]	<- '1507'; spares[i,5]<-'61';
	i<- i + 1; // i = 11	
	spares[i,0]	<- '132453652'; spares[i,1]<-'bomba de agua';spares[i,2]<-'honda';spares[i,3]<-'civic';
	spares[i,4]	<- '1508'; spares[i,5]<-'62';
	i<- i + 1; // i = 12	
	spares[i,0]	<- '132453653'; spares[i,1]<-'embriague';spares[i,2]<-'nissan';spares[i,3]<-'estrada';
	spares[i,4]	<- '1509'; spares[i,5]<-'63';
	i<- i + 1; // i = 13	
	spares[i,0]	<- '132453654'; spares[i,1]<-'luneta';spares[i,2]<-'mercedez benz';spares[i,3]<-'c200';
	spares[i,4]	<- '1510'; spares[i,5]<-'64';
	i<- i + 1; // i = 14	
	spares[i,0]	<- '132453655'; spares[i,1]<-'amortiguador';spares[i,2]<-'suzuki';spares[i,3]<-'fan';
	spares[i,4]	<- '1511'; spares[i,5]<-'65';
	i<- i + 1; // i = 15	
	spares[i,0]	<- '132453656'; spares[i,1]<-'extremo';spares[i,2]<-'audi';spares[i,3]<-'a4';
	spares[i,4]	<- '1512'; spares[i,5]<-'66';
	i<- i + 1; // i = 16	
	spares[i,0]	<- '132453657'; spares[i,1]<-'buje';spares[i,2]<-'tata';spares[i,3]<-'punch';
	spares[i,4]	<- '1513'; spares[i,5]<-'67';
	i<- i + 1; // i = 17	
	spares[i,0]	<- '132453658'; spares[i,1]<-'cable de bujia';spares[i,2]<-'volvo';spares[i,3]<-'xc 90';
	spares[i,4]	<- '1514'; spares[i,5]<-'68';
	i<- i + 1; // i = 18	
	spares[i,0]	<- '132453659'; spares[i,1]<-'alternador';spares[i,2]<-'iveco';spares[i,3]<-'camion';
	spares[i,4]	<- '1515'; spares[i,5]<-'69';
	i<- i + 1; // i = 19	
	spares[i,0]	<- '132453660'; spares[i,1]<-'llanta';spares[i,2]<-'bmw';spares[i,3]<-'328';
	spares[i,4]	<- '1516'; spares[i,5]<-'70';
	i<- i + 1; // i = 20	
	spares[i,0]	<- '132453661'; spares[i,1]<-'espiral';spares[i,2]<-'daewoo';spares[i,3]<-'poli';
	spares[i,4]	<- '1517'; spares[i,5]<-'71';
	i<- i + 1; // i = 21	
	spares[i,0]	<- '132453662'; spares[i,1]<-'casoleta';spares[i,2]<-'mazda';spares[i,3]<-'centra';
	spares[i,4]	<- '1518'; spares[i,5]<-'72';
	i<- i + 1; // i = 22	
	spares[i,0]	<- '132453663'; spares[i,1]<-'maza';spares[i,2]<-'mini cooper';spares[i,3]<-'mini cooper';
	spares[i,4]	<- '1519'; spares[i,5]<-'73';
	i<- i + 1; // i = 23	
	spares[i,0]	<- '132453664'; spares[i,1]<-'turbo';spares[i,2]<-'mitsubishi';spares[i,3]<-'eclipse';
	spares[i,4]	<- '1520'; spares[i,5]<-'74';
	i<- i + 1; // i = 24	
	spares[i,0]	<- '132453665'; spares[i,1]<-'piston';spares[i,2]<-'seat';spares[i,3]<-'ibiza';
	spares[i,4]	<- '1521'; spares[i,5]<-'75';
	i<- i + 1; // i = 25	
	spares[i,0]	<- '132453666'; spares[i,1]<-'metales';spares[i,2]<-'dacia';spares[i,3]<-'dacia';
	spares[i,4]	<- '1522'; spares[i,5]<-'76';
	i<- i + 1; // i = 26	
	spares[i,0]	<- '132453667'; spares[i,1]<-'block';spares[i,2]<-'ferrari';spares[i,3]<-'spider';
	spares[i,4]	<- '1523'; spares[i,5]<-'77';
	i<- i + 1; // i = 27	
	spares[i,0]	<- '132453668'; spares[i,1]<-'tapa de valvula';spares[i,2]<-'porche';spares[i,3]<-'carrera 911';
	spares[i,4]	<- '1524'; spares[i,5]<-'78';
	i<- i + 1; // i = 28	
	spares[i,0]	<- '132453669'; spares[i,1]<-'correa';spares[i,2]<-'hummer';spares[i,3]<-'c3';
	spares[i,4]	<- '1525'; spares[i,5]<-'79';
	i<- i + 1; // i = 29	
	spares[i,0]	<- '132453670'; spares[i,1]<-'termostato';spares[i,2]<-'jaguar';spares[i,3]<-'x3';
	spares[i,4]	<- '1526'; spares[i,5]<-'80';
	i<- i + 1; // i = 30	
	spares[i,0]	<- '132453671'; spares[i,1]<-'fusible';spares[i,2]<-'opel';spares[i,3]<-'tracker';
	spares[i,4]	<- '1527'; spares[i,5]<-'81';
	i<- i + 1; // i = 31	
	spares[i,0]	<- '132453672'; spares[i,1]<-'fusilera';spares[i,2]<-'rolls roys';spares[i,3]<-'phantom';
	spares[i,4]	<- '1528'; spares[i,5]<-'82';
	i<- i + 1; // i = 32	
	spares[i,0]	<- '132453673'; spares[i,1]<-'disco de freno';spares[i,2]<-'scania';spares[i,3]<-'x6';
	spares[i,4]	<- '1529'; spares[i,5]<-'83';
	i<- i + 1; // i = 33	
	spares[i,0]	<- '132453674'; spares[i,1]<-'diferencial';spares[i,2]<-'chevrolet';spares[i,3]<-'camaro';
	spares[i,4]	<- '1530'; spares[i,5]<-'84';
	i<- i + 1; // i = 34	
	spares[i,0]	<- '132453675'; spares[i,1]<-'engranajes';spares[i,2]<-'rover';spares[i,3]<-'rover';
	spares[i,4]	<- '1531'; spares[i,5]<-'85';
	i<- i + 1; // i = 35	
	spares[i,0]	<- '1324536123'; spares[i,1]<-'tasa';spares[i,2]<-'ford';spares[i,3]<-'focus';
	spares[i,4]	<- '1502'; spares[i,5]<-'54';
	i<- i + 1; // i = 36	
	spares[i,0]	<- '132453645'; spares[i,1]<-'optica';spares[i,2]<-'fiat';spares[i,3]<-'uno';
	spares[i,4]	<- '1502'; spares[i,5]<-'87';
	i<- i + 1; // i = 37	
	spares[i,0]	<- '132453647'; spares[i,1]<-'espejo';spares[i,2]<-'volkswagen';spares[i,3]<-'polo';
	spares[i,4]	<- '1503'; spares[i,5]<-'88';
	i<- i + 1; // i = 38	
	spares[i,0]	<- '132453648'; spares[i,1]<-'ruleman';spares[i,2]<-'toyota';spares[i,3]<-'corolla';
	spares[i,4]	<- '1504'; spares[i,5]<-'89';
	i<- i + 1; // i = 39	
	spares[i,0]	<- '132453649'; spares[i,1]<-'radiador';spares[i,2]<-'cheery';spares[i,3]<-'d3';
	spares[i,4]	<- '1505'; spares[i,5]<-'90';
	i<- i + 1; // i = 40	
	spares[i,0]	<- '132453650'; spares[i,1]<-'manguera de aire';spares[i,2]<-'renaul';spares[i,3]<-'clio';
	spares[i,4]	<- '1506'; spares[i,5]<-'91';
	i<- i + 1; // i = 41	
	spares[i,0]	<- '132453651'; spares[i,1]<-'bujia';spares[i,2]<-'peugeot';spares[i,3]<-'208 gti';
	spares[i,4]	<- '1507'; spares[i,5]<-'92';
	i<- i + 1; // i = 42	
	spares[i,0]	<- '132453652'; spares[i,1]<-'catalizador';spares[i,2]<-'citroen';spares[i,3]<-'14 v';
	spares[i,4]	<- '1508'; spares[i,5]<-'93';
	i<- i + 1; // i = 43	
	spares[i,0]	<- '132453653'; spares[i,1]<-'bomba de agua';spares[i,2]<-'honda';spares[i,3]<-'civic';
	spares[i,4]	<- '1509'; spares[i,5]<-'94';
	i<- i + 1; // i = 44	
	spares[i,0]	<- '132453654'; spares[i,1]<-'embriague';spares[i,2]<-'nissan';spares[i,3]<-'estrada';
	spares[i,4]	<- '1510'; spares[i,5]<-'95';
	i<- i + 1; // i = 45	
	spares[i,0]	<- '132453655'; spares[i,1]<-'luneta';spares[i,2]<-'mercedez benz';spares[i,3]<-'c201';
	spares[i,4]	<- '1511'; spares[i,5]<-'96';
	i<- i + 1; // i = 46	
	spares[i,0]	<- '132453656'; spares[i,1]<-'amortiguador';spares[i,2]<-'suzuki';spares[i,3]<-'fan';
	spares[i,4]	<- '1512'; spares[i,5]<-'97';
	i<- i + 1; // i = 47	
	spares[i,0]	<- '132453657'; spares[i,1]<-'extremo';spares[i,2]<-'audi';spares[i,3]<-'a5';
	spares[i,4]	<- '1513'; spares[i,5]<-'98';
	i<- i + 1; // i = 48	
	spares[i,0]	<- '132453658'; spares[i,1]<-'buje';spares[i,2]<-'tata';spares[i,3]<-'punch';
	spares[i,4]	<- '1514'; spares[i,5]<-'99';
	i<- i + 1; // i = 49	
	spares[i,0]	<- '132453659'; spares[i,1]<-'cable de bujia';spares[i,2]<-'volvo';spares[i,3]<-'xc 91';
	spares[i,4]	<- '1515'; spares[i,5]<-'100';
	i<- i + 1; // i = 50	
	spares[i,0]	<- '132453660'; spares[i,1]<-'alternador';spares[i,2]<-'iveco';spares[i,3]<-'camion';
	spares[i,4]	<- '1516'; spares[i,5]<-'101';
	i<- i + 1; // i = 51	
	spares[i,0]	<- '132453661'; spares[i,1]<-'llanta';spares[i,2]<-'bmw';spares[i,3]<-'329';
	spares[i,4]	<- '1517'; spares[i,5]<-'102';
	i<- i + 1; // i = 52	
	spares[i,0]	<- '132453662'; spares[i,1]<-'espiral';spares[i,2]<-'daewoo';spares[i,3]<-'poli';
	spares[i,4]	<- '1518'; spares[i,5]<-'103';
	i<- i + 1; // i = 53	
	spares[i,0]	<- '132453663'; spares[i,1]<-'casoleta';spares[i,2]<-'mazda';spares[i,3]<-'centra';
	spares[i,4]	<- '1519'; spares[i,5]<-'104';
	i<- i + 1; // i = 54	
	spares[i,0]	<- '132453664'; spares[i,1]<-'maza';spares[i,2]<-'mini cooper';spares[i,3]<-'mini cooper';
	spares[i,4]	<- '1520'; spares[i,5]<-'105';
	i<- i + 1; // i = 55	
	spares[i,0]	<- '132453665'; spares[i,1]<-'turbo';spares[i,2]<-'mitsubishi';spares[i,3]<-'eclipse';
	spares[i,4]	<- '1521'; spares[i,5]<-'106';
	i<- i + 1; // i = 56	
	spares[i,0]	<- '132453666'; spares[i,1]<-'piston';spares[i,2]<-'seat';spares[i,3]<-'ibiza';
	spares[i,4]	<- '1522'; spares[i,5]<-'107';
	i<- i + 1; // i = 57	
	spares[i,0]	<- '132453667'; spares[i,1]<-'metales';spares[i,2]<-'dacia';spares[i,3]<-'dacia';
	spares[i,4]	<- '1523'; spares[i,5]<-'108';
	i<- i + 1; // i = 58	
	spares[i,0]	<- '132453668'; spares[i,1]<-'block';spares[i,2]<-'ferrari';spares[i,3]<-'spider';
	spares[i,4]	<- '1524'; spares[i,5]<-'109';
	i<- i + 1; // i = 59	
	spares[i,0]	<- '132453669'; spares[i,1]<-'tapa de valvula';spares[i,2]<-'porche';spares[i,3]<-'carrera 912';
	spares[i,4]	<- '1525'; spares[i,5]<-'110';
	i<- i + 1; // i = 60	
	spares[i,0]	<- '132453670'; spares[i,1]<-'correa';spares[i,2]<-'hummer';spares[i,3]<-'c4';
	spares[i,4]	<- '1526'; spares[i,5]<-'111';
	i<- i + 1; // i = 61	
	spares[i,0]	<- '132453671'; spares[i,1]<-'termostato';spares[i,2]<-'jaguar';spares[i,3]<-'x4';
	spares[i,4]	<- '1527'; spares[i,5]<-'112';
	i<- i + 1; // i = 62	
	spares[i,0]	<- '132453672'; spares[i,1]<-'fusible';spares[i,2]<-'opel';spares[i,3]<-'tracker';
	spares[i,4]	<- '1528'; spares[i,5]<-'113';
	i<- i + 1; // i = 63	
	spares[i,0]	<- '132453673'; spares[i,1]<-'fusilera';spares[i,2]<-'rolls roys';spares[i,3]<-'phantom';
	spares[i,4]	<- '1529'; spares[i,5]<-'114';
	i<- i + 1; // i = 64	
	spares[i,0]	<- '132453674'; spares[i,1]<-'disco de freno';spares[i,2]<-'scania';spares[i,3]<-'x7';
	spares[i,4]	<- '1530'; spares[i,5]<-'115';
	i<- i + 1; // i = 65	
	spares[i,0]	<- '132453675'; spares[i,1]<-'diferencial';spares[i,2]<-'chevrolet';spares[i,3]<-'camaro';
	spares[i,4]	<- '1531'; spares[i,5]<-'116';
	i<- i + 1; // i = 66	
	spares[i,0]	<- '132453676'; spares[i,1]<-'engranajes';spares[i,2]<-'rover';spares[i,3]<-'rover';
	spares[i,4]	<- '1532'; spares[i,5]<-'117';
	i<- i + 1; // i = 67	
	spares[i,0]	<- '132453646'; spares[i,1]<-'tasa';spares[i,2]<-'ford';spares[i,3]<-'focus';
	spares[i,4]	<- '1502'; spares[i,5]<-'118';
	i<- i + 1; // i = 68	
	spares[i,0]	<- '132453647'; spares[i,1]<-'optica';spares[i,2]<-'fiat';spares[i,3]<-'uno';
	spares[i,4]	<- '1503'; spares[i,5]<-'119';
	i<- i + 1; // i = 69	
	spares[i,0]	<- '132453648'; spares[i,1]<-'espejo';spares[i,2]<-'volkswagen';spares[i,3]<-'polo';
	spares[i,4]	<- '1504'; spares[i,5]<-'120';
	i<- i + 1; // i = 70	
	spares[i,0]	<- '132453649'; spares[i,1]<-'ruleman';spares[i,2]<-'toyota';spares[i,3]<-'corolla';
	spares[i,4]	<- '1505'; spares[i,5]<-'121';
	i<- i + 1; // i = 71	
	spares[i,0]	<- '132453650'; spares[i,1]<-'radiador';spares[i,2]<-'cheery';spares[i,3]<-'d4';
	spares[i,4]	<- '1506'; spares[i,5]<-'122';
	i<- i + 1; // i = 72	
	spares[i,0]	<- '132453651'; spares[i,1]<-'manguera de aire';spares[i,2]<-'renaul';spares[i,3]<-'clio';
	spares[i,4]	<- '1507'; spares[i,5]<-'123';
	i<- i + 1; // i = 73	
	spares[i,0]	<- '132453652'; spares[i,1]<-'bujia';spares[i,2]<-'peugeot';spares[i,3]<-'209 gti';
	spares[i,4]	<- '1508'; spares[i,5]<-'124';
	i<- i + 1; // i = 74	
	spares[i,0]	<- '132453653'; spares[i,1]<-'catalizador';spares[i,2]<-'citroen';spares[i,3]<-'15 v';
	spares[i,4]	<- '1509'; spares[i,5]<-'125';
	i<- i + 1; // i = 75	
	spares[i,0]	<- '132453654'; spares[i,1]<-'bomba de agua';spares[i,2]<-'honda';spares[i,3]<-'civic';
	spares[i,4]	<- '1510'; spares[i,5]<-'126';
	i<- i + 1; // i = 76	
	spares[i,0]	<- '132453655'; spares[i,1]<-'embriague';spares[i,2]<-'nissan';spares[i,3]<-'estrada';
	spares[i,4]	<- '1511'; spares[i,5]<-'127';
	i<- i + 1; // i = 77	
	spares[i,0]	<- '132453656'; spares[i,1]<-'luneta';spares[i,2]<-'mercedez benz';spares[i,3]<-'c202';
	spares[i,4]	<- '1512'; spares[i,5]<-'128';
	i<- i + 1; // i = 78	
	spares[i,0]	<- '132453657'; spares[i,1]<-'amortiguador';spares[i,2]<-'suzuki';spares[i,3]<-'fan';
	spares[i,4]	<- '1513'; spares[i,5]<-'129';
	i<- i + 1; // i = 79	
	spares[i,0]	<- '132453658'; spares[i,1]<-'extremo';spares[i,2]<-'audi';spares[i,3]<-'a6';
	spares[i,4]	<- '1514'; spares[i,5]<-'130';
	i<- i + 1; // i = 80	
	spares[i,0]	<- '132453659'; spares[i,1]<-'buje';spares[i,2]<-'tata';spares[i,3]<-'punch';
	spares[i,4]	<- '1515'; spares[i,5]<-'131';
	i<- i + 1; // i = 81	
	spares[i,0]	<- '132453660'; spares[i,1]<-'cable de bujia';spares[i,2]<-'volvo';spares[i,3]<-'xc 92';
	spares[i,4]	<- '1516'; spares[i,5]<-'132';
	i<- i + 1; // i = 82	
	spares[i,0]	<- '132453661'; spares[i,1]<-'alternador';spares[i,2]<-'iveco';spares[i,3]<-'camion';
	spares[i,4]	<- '1517'; spares[i,5]<-'133';
	i<- i + 1; // i = 83	
	spares[i,0]	<- '132453662'; spares[i,1]<-'llanta';spares[i,2]<-'bmw';spares[i,3]<-'330';
	spares[i,4]	<- '1518'; spares[i,5]<-'134';
	i<- i + 1; // i = 84	
	spares[i,0]	<- '132453663'; spares[i,1]<-'espiral';spares[i,2]<-'daewoo';spares[i,3]<-'poli';
	spares[i,4]	<- '1519'; spares[i,5]<-'135';
	i<- i + 1; // i = 85	
	spares[i,0]	<- '132453664'; spares[i,1]<-'casoleta';spares[i,2]<-'mazda';spares[i,3]<-'centra';
	spares[i,4]	<- '1520'; spares[i,5]<-'136';
	i<- i + 1; // i = 86	
	spares[i,0]	<- '132453665'; spares[i,1]<-'maza';spares[i,2]<-'mini cooper';spares[i,3]<-'mini cooper';
	spares[i,4]	<- '1521'; spares[i,5]<-'137';
	i<- i + 1; // i = 87	
	spares[i,0]	<- '132453666'; spares[i,1]<-'turbo';spares[i,2]<-'mitsubishi';spares[i,3]<-'eclipse';
	spares[i,4]	<- '1522'; spares[i,5]<-'138';
	i<- i + 1; // i = 88	
	spares[i,0]	<- '132453667'; spares[i,1]<-'piston';spares[i,2]<-'seat';spares[i,3]<-'ibiza';
	spares[i,4]	<- '1523'; spares[i,5]<-'139';
	i<- i + 1; // i = 89	
	spares[i,0]	<- '132453668'; spares[i,1]<-'metales';spares[i,2]<-'dacia';spares[i,3]<-'dacia';
	spares[i,4]	<- '1524'; spares[i,5]<-'140';
	i<- i + 1; // i = 90	
	spares[i,0]	<- '132453669'; spares[i,1]<-'block';spares[i,2]<-'ferrari';spares[i,3]<-'spider';
	spares[i,4]	<- '1525'; spares[i,5]<-'141';
	i<- i + 1; // i = 91	
	spares[i,0]	<- '132453670'; spares[i,1]<-'tapa de valvula';spares[i,2]<-'porche';spares[i,3]<-'carrera 913';
	spares[i,4]	<- '1526'; spares[i,5]<-'142';
	i<- i + 1; // i = 92	
	spares[i,0]	<- '132453671'; spares[i,1]<-'correa';spares[i,2]<-'hummer';spares[i,3]<-'c5';
	spares[i,4]	<- '1527'; spares[i,5]<-'143';
	i<- i + 1; // i = 93	
	spares[i,0]	<- '132453672'; spares[i,1]<-'termostato';spares[i,2]<-'jaguar';spares[i,3]<-'x5';
	spares[i,4]	<- '1528'; spares[i,5]<-'144';
	i<- i + 1; // i = 94	
	spares[i,0]	<- '132453673'; spares[i,1]<-'fusible';spares[i,2]<-'opel';spares[i,3]<-'tracker';
	spares[i,4]	<- '1529'; spares[i,5]<-'145';
FinSubProceso

SubProceso setCustomersList(customer Por Referencia)
	Definir i como  Entero;
	
	i<-0;
	customer[i,0]	<- '12345678'; customer[i,1]<-'Mateo Russo';
	
	i<- i + 1;
	customer[i,0]	<- '43290210'; customer[i,1]<-'Ana Franco';
	
	i<- i +1;
	customer[i,0]	<- '39854121'; customer[i,1]<-'Manuel Rosas';
	
	
FinSubProceso
// fín código grupo 2