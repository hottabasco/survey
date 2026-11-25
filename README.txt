The application manages survey report data, using JDBC, in a postgresql database containing the following tables:

survey_report:
    item_id numeric NOT NULL,
    "Type" character varying COLLATE pg_catalog."default",
    "Element Type" character varying COLLATE pg_catalog."default" NOT NULL,
    "Location" character varying COLLATE pg_catalog."default" NOT NULL,
    "Description" character varying COLLATE pg_catalog."default" NOT NULL,
    "Maintenance Required" character varying COLLATE pg_catalog."default" NOT NULL,
    "Priority" boolean,
    "Tranche" character varying COLLATE pg_catalog."default",
    "Notes" character varying COLLATE pg_catalog."default",
    "data_set_id" integer NOT NULL,
    CONSTRAINT survey_report_pkey PRIMARY KEY (data_set_id, item_id),
    CONSTRAINT survey_report_data_set_id_fkey FOREIGN KEY (data_set_id)
        REFERENCES public.survey_data_set (data_set_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION

usr:
    usr_id numeric NOT NULL,
    "account_name" character varying COLLATE pg_catalog."default",
    "first_name" character varying COLLATE pg_catalog."default" NOT NULL,
    "last_name" character varying COLLATE pg_catalog."default" NOT NULL,
    "role" character varying COLLATE pg_catalog."default" NOT NULL,
    "password" text varying COLLATE pg_catalog."default" NOT NULL,
    "start_date" date NOT NULL DEFAULT CURRENT_DATE,
    "end_date" date,
    CONSTRAINT usr_pkey PRIMARY KEY (usr_id)

survey_data_set:
    data_set_id serial NOT NULL,
    data_set_name character varying(20) COLLATE pg_catalog."default",
    data_set_description text COLLATE pg_catalog."default" NOT NULL,
    start_date date NOT NULL DEFAULT CURRENT_DATE,
    end_date date,
    CONSTRAINT data_set_pkey PRIMARY KEY (data_set_id)

contractor:
    "contractor_id" serial NOT NULL,
    "business_name" character varying(20) COLLATE pg_catalog."default" NOT NULL,
    "contact_name"  character varying(20) COLLATE pg_catalog."default",
    "trade"         character varying(20) COLLATE pg_catalog."default",
    "email_address" character varying(30) COLLATE pg_catalog."default",
    "phone"         character varying(20) COLLATE pg_catalog."default",
    "address"       character varying(80) COLLATE pg_catalog."default",
    "notes"         text                  COLLATE pg_catalog."default",
    "start_date"    date NOT NULL DEFAULT CURRENT_DATE,
    "end_date"      date,    
    CONSTRAINT contractor_pkey PRIMARY KEY (contractor_id)


The Application implements the following functionality: 
1. User Login

2. Display, Filter, Search, Sort, Edit and Add survey records

3. User Managment: CRUD for users

4. Copy button, makes survey data available for pasting into LibreOffice Writer document.

5. Can load csv files into the database where csv data is structured as per the survey_report table,
    except that the csv data is not expected to contain a 'data_set_id' field. 
    The csv loader works as follows:
    a. prompt for a filename and path for a csv file that contains survey data set to be loaded.
    b. Prompt for a name for the data set to be loaded
    c. Prompt for a description for the data set to be loaded
    d. Reads the csv file
    e. If the file cannot be read, display an error message then abandon the data load.
    f. Create a new record in the survey_data_set database table, using the name and description input by the user. 
    g. Load CSV data into the survey_report table, setting survey_report.data_set_id to the id from survey_data_set table

Next enhancement:
   Contractor Management

JSF application structure:
./src
./src/survey.properties.example
./src/com
./src/com/survey
./src/com/survey/controller
./src/com/survey/controller/LoginController.java
./src/com/survey/controller/DataSetController.java
./src/com/survey/controller/ImportController.java
./src/com/survey/controller/UserController.java
./src/com/survey/controller/SurveyController.java
./src/com/survey/model
./src/com/survey/model/SurveyReport.java
./src/com/survey/model/User.java
./src/com/survey/model/Utility.java
./src/com/survey/model/DataSet.java
./src/com/survey/config
./src/com/survey/config/LoggingInitializer.java
./src/com/survey/config/AuthFilter.java
./src/com/survey/service
./src/com/survey/service/DatabaseService.java
./src/survey.properties
./src/META-INF
./src/META-INF/services
./web
./web/datasets.xhtml
./web/resources
./web/resources/css
./web/resources/css/style.css
./web/WEB-INF
./web/WEB-INF/lib
./web/WEB-INF/lib/primefaces-14.0.0-jakarta.jar
./web/WEB-INF/lib/postgresql-42.7.14.jar
./web/WEB-INF/lib/jbcrypt-0.4.jar
./web/WEB-INF/web.xml.bak
./web/WEB-INF/beans.xml
./web/WEB-INF/faces-config.xml
./web/WEB-INF/web.xml
./web/users.xhtml
./web/index.xhtml
./web/import.xhtml
./web/login.xhtml
./README.txt

