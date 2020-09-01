*-------------------------------------------------------------------------;
* Final Presentation  : Predicting Churn using Logistic Regression        ;
* Developer(s)        : Team 1                                            ;
*                       Ameya Swar                                        ;
*                       Bhargavi Bontha                                   ;
*                       Rashmi Khurana                                    ;
*                       Rushabh Vakharia                                  ;
* Date                : Nov 10, 2018                                      ;
*-------------------------------------------------------------------------;

PROC IMPORT OUT= WORK.Churning_Train 
            DATAFILE= "C:\Users\vrush\OneDrive\Desktop\BIA-652\Final Project\ChurnModelling (TrainData).csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

PROC IMPORT OUT= WORK.Churning_Test 
            DATAFILE= "C:\Users\vrush\OneDrive\Desktop\BIA-652\Final Project\ChurnModelling (TestData).csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

***********************************************************************************************;

*Creating dummy variables for Geography and Gender";

data Train_Churn;
  set Churning_Train;

    if geography = "France" then France = 1;
	else France = 0;

	if geography = "Germany" then Germany = 1;
	else Germany = 0;

	if geography = "Spain" then Spain = 1;
	else Spain = 0;

	if gender = "Male" then Male = 1;
	else Male = 0;

	if gender = "Female" then Female = 1;
	else Female = 0;
run;

data Test_Churn;
  set Churning_Test;

    if geography = "France" then France = 1;
	else France = 0;

	if geography = "Germany" then Germany = 1;
	else Germany = 0;

	if geography = "Spain" then Spain = 1;
	else Spain = 0;

	if gender = "Male" then Male = 1;
	else Male = 0;

	if gender = "Female" then Female = 1;
	else Female = 0;
run;

title "Correlation matrix";

proc corr data = Train_Churn;
	var exited creditscore age tenure balance numofproducts hascrcard isactivemember estimatedsalary female germany spain;
run;

title "Running logistic regression using backward elimination";

proc logistic data = Train_Churn plots(only) = (roc(id=obs) effect);
	class hascrcard (ref = '0') isactivemember (ref = '0') female (ref = '0') spain (ref = '0') germany (ref = '0') / param = ref;
	model exited = creditscore age tenure balance numofproducts hascrcard isactivemember estimatedsalary female spain germany
	/scale = none selection = backward clparm = wald clodds = pl rsquare;
run;

title "PCA";

proc standard data = Train_Churn
  mean = 0 std = 1 
  out = Train_Churn_z;
  var exited creditscore age tenure balance numofproducts hascrcard isactivemember estimatedsalary female spain germany;
run;

proc princomp data=Train_Churn_z ;
   var exited creditscore age tenure balance numofproducts hascrcard isactivemember estimatedsalary female germany spain;
run;
