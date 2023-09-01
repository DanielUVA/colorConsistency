% Crear la carpeta "results" si no existe
FuzzyRule = 2; % 1 o 2
databaseName = 'NCSU'; % Nombre de la base de datos
DatosIn = NCSU; % Variable en la que se han almacenado los 10*N datos experimentales

folderName = ['resultsInconsistenciesFuzzyRule_', databaseName, '_ID_DETALLE_', num2str(FuzzyRule)];

if ~isfolder(folderName)
    mkdir(folderName);
end

% Definir los valores de umbral
umbralInicial = 0.05;
umbralFinal = 1.0;
pasoUmbral = 0.05;

% Calcular el número de iteraciones
numIteraciones = ((umbralFinal - umbralInicial) / pasoUmbral)+1;

% Bucle for para iterar sobre los valores de umbral
for i = 0:numIteraciones 
    % Calcular el valor de umbral para esta iteración
    umbral = umbralInicial + i * pasoUmbral;

    % Invocar la función con el umbral actual
    if FuzzyRule == 1
        [DatosOut, ParesInconsistentes] = InconsistenciesFuzzyRule1(DatosIn, umbral);
    else
        [DatosOut, ParesInconsistentes] = InconsistenciesFuzzyRule2(DatosIn, umbral);
    end

    % Almacenar DatosOut de manera traspuesta
    DatosOut = DatosOut';

    % Exportar los resultados en archivos CSV en la carpeta "results"
    csvwrite(fullfile(folderName, ['umbral', num2str(i), '.csv']), umbral);
    csvwrite(fullfile(folderName, ['DatosOut', num2str(i), '.csv']), DatosOut);
    csvwrite(fullfile(folderName, ['ParesInconsistentes', num2str(i), '.csv']), ParesInconsistentes);
end

% Finalmente, puedes exportar DatosOut fuera del bucle si es necesario
csvwrite(fullfile(folderName, 'DatosOut.csv'), DatosOut);
