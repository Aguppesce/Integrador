Proceso Main	
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
	
	
	//Fill all lists with ceros
	preSetCarList(auto);
	preSetEmployeeList(empleado);
	preSetSpareList(repuestos);
	presetPaymentPlanListList(planesDePago);
	presetSalesListList(venta);
	presetCustomersListList(cliente);
	
	//Carga con datos de ejemplo las matrices 
	setCarList(auto);
	setEmployeeList(empleado);
	setSpareList(repuestos);
	setPaymentPlanList(planesDePago);
	setCustomersList(cliente);
	setSalesList(venta);
	
	
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
				doSale(cliente,auto,empleado,venta,planesDePago, repuestos);
			1:
				findBy(empleado, auto, cliente, repuestos, venta, planesDePago);
			2:
				serviceRental(cliente, auto, empleado);
			3:
				loadData(auto,empleado,repuestos,cliente,planesDePago);
			4:
				doBuyout(cliente,auto);
			5:	
			De Otro Modo: 
				escribir "Invalid choise!";
		FinSegun
	Hasta Que option = 5;
	escribir "Thanks for using our software, come back soon.";
FinSubProceso