Libname sasdata 
	"C:\Users\Rushabh Vakharia\Desktop\2nd Semester\Marketing Analytics\Final Project";* access = read;
run;

proc copy in=sasdata out=work;
	select vodka;
run;

proc sort data = vodka
	out = vodka
	noduprecs;
	by city;
run;

data vodka;
	set vodka;
	if cmiss(of _all_) then delete;
run;

proc means data = vodka NMISS N;
run;

proc sql;
	create table absolut_vodka as 
    select * 
	from vodka
	where item_description like 'Absolut%';

	create table smirnoff_vodka as 
    select * 
	from vodka
	where item_description like 'Smirnoff%';

	create table svedka_vodka as 
    select * 
	from vodka
	where item_description like 'Svedka%';

	create table five_oclock_vodka as 
    select * 
	from vodka
	where item_description like 'Five%';

	create table new_amsterdam_vodka as 
    select * 
	from vodka
	where item_description like 'New%';

	create table grey_goose_vodka as 
    select * 
	from vodka
	where item_description like 'Grey%';

	update absolut_vodka
	set item_description = 'Absolut';

	update smirnoff_vodka
	set item_description = 'Smirnoff';

	update svedka_vodka
	set item_description = 'Svedka';

	update five_oclock_vodka
	set item_description = 'Five OClock';

	update new_amsterdam_vodka
	set item_description = 'New Amsterdam';

	update grey_goose_vodka
	set item_description = 'Grey Goose';
quit;

************************ Clustering ********************************;
************************** Absolut *********************************;

title1 "Clustering for Absolut";

proc univariate data = absolut_vodka;
	var _sale__dollars_;
	output out = boxStats median = median qrange = iqr;
run; 

data _null_;
	set boxStats;
	call symput ('median',median);
	call symput ('iqr', iqr);
run; 

%put &median;
%put &iqr;

data absolut_trimmed;
set absolut_vodka;
    if (_sale__dollars_ le &median + 1.5 * &iqr) and (_sale__dollars_ ge &median - 1.5 * &iqr); 
run; 

proc fastclus data = absolut_trimmed maxclusters = 5 out = absolut_trimmed_out; 
	var _sale__dollars_;
	id zip_code;
run;

proc print data = absolut_trimmed_out;
	var zip_code cluster;
run;

************************** Smirnoff *********************************;

title1 "Clustering for Smirnoff";

proc univariate data = smirnoff_vodka;
	var _sale__dollars_;
	output out = boxStats median = median qrange = iqr;
run; 

data _null_;
	set boxStats;
	call symput ('median',median);
	call symput ('iqr', iqr);
run; 

%put &median;
%put &iqr;

data smirnoff_trimmed;
set smirnoff_vodka;
    if (_sale__dollars_ le &median + 1.5 * &iqr) and (_sale__dollars_ ge &median - 1.5 * &iqr); 
run; 

proc fastclus data = smirnoff_trimmed maxclusters = 5 out = smirnoff_trimmed_out; 
	var _sale__dollars_;
	id zip_code;
run;

proc print data = smirnoff_trimmed_out;
	var zip_code cluster;
run;

************************** Svedka *********************************;

title1 "Clustering for Svedka";

proc univariate data = svedka_vodka;
	var _sale__dollars_;
	output out = boxStats median = median qrange = iqr;
run; 

data _null_;
	set boxStats;
	call symput ('median',median);
	call symput ('iqr', iqr);
run; 

%put &median;
%put &iqr;

data svedka_trimmed;
set svedka_vodka;
    if (_sale__dollars_ le &median + 1.5 * &iqr) and (_sale__dollars_ ge &median - 1.5 * &iqr); 
run; 

proc fastclus data = svedka_trimmed maxclusters = 5 out = svedka_trimmed_out; 
	var _sale__dollars_;
	id zip_code;
run;

proc print data = svedka_trimmed_out;
	var zip_code cluster;
run;

************************** Five OClock *******************************;

title1 "Clustering for Five OClock";

proc univariate data = five_oclock_vodka;
	var _sale__dollars_;
	output out = boxStats median = median qrange = iqr;
run; 

data _null_;
	set boxStats;
	call symput ('median',median);
	call symput ('iqr', iqr);
run; 

%put &median;
%put &iqr;

data five_oclock_trimmed;
set five_oclock_vodka;
    if (_sale__dollars_ le &median + 1.5 * &iqr) and (_sale__dollars_ ge &median - 1.5 * &iqr); 
run; 

proc fastclus data = five_oclock_trimmed maxclusters = 5 out = five_oclock_trimmed_out; 
	var _sale__dollars_;
	id zip_code;
run;

proc print data = five_oclock_trimmed_out;
	var zip_code cluster;
run;

************************** New Amsterdam ******************************;

title1 "Clustering for New Amsterdam";

proc univariate data = new_amsterdam_vodka;
	var _sale__dollars_;
	output out = boxStats median = median qrange = iqr;
run; 

data _null_;
	set boxStats;
	call symput ('median',median);
	call symput ('iqr', iqr);
run; 

%put &median;
%put &iqr;

data new_amsterdam_trimmed;
set new_amsterdam_vodka;
    if (_sale__dollars_ le &median + 1.5 * &iqr) and (_sale__dollars_ ge &median - 1.5 * &iqr); 
run; 

proc fastclus data = new_amsterdam_trimmed maxclusters = 5 out = new_amsterdam_trimmed_out; 
	var _sale__dollars_;
	id zip_code;
run;

proc print data = new_amsterdam_trimmed_out;
	var zip_code cluster;
run;

************************** Grey Goose *********************************;

title1 "Clustering for Grey Goose";

proc univariate data = grey_goose_vodka;
	var _sale__dollars_;
	output out = boxStats median = median qrange = iqr;
run; 

data _null_;
	set boxStats;
	call symput ('median',median);
	call symput ('iqr', iqr);
run; 

%put &median;
%put &iqr;

data grey_goose_trimmed;
set grey_goose_vodka;
    if (_sale__dollars_ le &median + 1.5 * &iqr) and (_sale__dollars_ ge &median - 1.5 * &iqr); 
run; 

proc fastclus data = grey_goose_trimmed maxclusters = 5 out = grey_goose_trimmed_out; 
	var _sale__dollars_;
	id zip_code;
run;

proc print data = grey_goose_trimmed_out;
	var zip_code cluster;
run;

************************ Forecasting ********************************;

proc sql;
	create table forecast_absolut as
	select month, item_description, avg(_sale__dollars_) as sale__dollars_
	from absolut_vodka
	group by month, item_description;

	create table forecast_smirnoff as
	select month, item_description, avg(_sale__dollars_) as sale__dollars_
	from smirnoff_vodka
	group by month, item_description;

	create table forecast_svedka as
	select month, item_description, avg(_sale__dollars_) as sale__dollars_
	from svedka_vodka
	group by month, item_description;

	create table forecast_five_oclock as
	select month, item_description, avg(_sale__dollars_) as sale__dollars_
	from five_oclock_vodka
	group by month, item_description;

	create table forecast_grey_goose as
	select month, item_description, avg(_sale__dollars_) as sale__dollars_
	from grey_goose_vodka
	group by month, item_description;

	create table forecast_new_amsterdam as
	select month, item_description, avg(_sale__dollars_) as sale__dollars_
	from new_amsterdam_vodka
	group by month, item_description;
quit;

************************** Absolut *********************************;

title1 "Single Exponential Smoothing for Absolut";

proc forecast data = forecast_absolut interval = month align = end method = expo lead = 12 out = forecast_absolut_single_out outfull outresid outest = forecast_absolut_single_est;
	var sale__dollars_;
	id month;
run;

proc sgplot data = forecast_absolut_single_out;
	series x = month y = sale__dollars_ / group = _type_;
	where _type_ ^= 'RESIDUAL';
run;

title1 "Seasonal Exponential Smoothing for Absolut";

proc forecast data = forecast_absolut interval = month align = end method = winters seasons = 4 lead = 12 out = forecast_absolut_seasonal_out outfull outresid outest = forecast_absolut_seasonal_est;
	var sale__dollars_;
	id month;
run;

proc sgplot data = forecast_absolut_seasonal_out;
	series x = month y = sale__dollars_ / group = _type_;
	where _type_ ^= 'RESIDUAL';
run;

************************** Svedka *********************************;

title1 "Single Exponential Smoothing for Svedka";

proc forecast data = forecast_svedka interval = month align = end method = expo lead = 12 out = forecast_svedka_single_out outfull outresid outest = forecast_svedka_single_out_est;
	var sale__dollars_;
	id month;
run;

proc sgplot data = forecast_svedka_single_out;
	series x = month y = sale__dollars_ / group = _type_;
	where _type_ ^= 'RESIDUAL';
run;

title1 "Seasonal Exponential Smoothing for Svedka";

proc forecast data = forecast_svedka interval = month align = end method = winters seasons = 4 lead = 12 out = forecast_svedka_seasonal_out outfull outresid outest = forecast_svedka_seasonal_est;
	var sale__dollars_;
	id month;
run;

proc sgplot data = forecast_svedka_seasonal_out;
	series x = month y = sale__dollars_ / group = _type_;
	where _type_ ^= 'RESIDUAL';
run;

************************** Smirnoff *********************************;

title1 "Single Exponential Smoothing for Smirnoff";

proc forecast data = forecast_smirnoff interval = month align = end method = expo lead = 12 out = forecast_smirnoff_single_out outfull outresid outest = forecast_smirnoff_single_est;
	var sale__dollars_;
	id month;
run;

proc sgplot data = forecast_smirnoff_single_out;
	series x = month y = sale__dollars_ / group = _type_;
	where _type_ ^= 'RESIDUAL';
run;

title1 "Seasonal Exponential Smoothing for Smirnoff";

proc forecast data = forecast_smirnoff interval = month align = end method = winters seasons = 4 lead = 12 out = forecast_smirnoff_seasonal_out outfull outresid outest = forecast_smirnoff_seasonal_est;
	var sale__dollars_;
	id month;
run;

proc sgplot data = forecast_smirnoff_seasonal_out;
	series x = month y = sale__dollars_ / group = _type_;
	where _type_ ^= 'RESIDUAL';
run;

************************** New Amsterdam *********************************;

title1 "Single Exponential Smoothing for New Amsterdam";

proc forecast data = forecast_new_amsterdam interval = month align = end method = expo lead = 12 out = forecast_na_single_out outfull outresid outest = forecast_na_single_est;
	var sale__dollars_;
	id month;
run;

proc sgplot data = forecast_na_single_out;
	series x = month y = sale__dollars_ / group = _type_;
	where _type_ ^= 'RESIDUAL';
run;

title1 "Seasonal Exponential Smoothing for New Amsterdam";

proc forecast data = forecast_new_amsterdam interval = month align = end method = winters seasons = 4 lead = 12 out = forecast_na_seasonal_out outfull outresid outest = forecast_na_seasonal_est;
	var sale__dollars_;
	id month;
run;

proc sgplot data = forecast_na_seasonal_out;
	series x = month y = sale__dollars_ / group = _type_;
	where _type_ ^= 'RESIDUAL';
run;

************************** Five OClock *********************************;

title1 "Single Exponential Smoothing for Five Oclock";

proc forecast data = forecast_five_oclock interval = month align = end method = expo lead = 12 out = forecast_five_single_out outfull outresid outest = forecast_five_single_est;
	var sale__dollars_;
	id month;
run;

proc sgplot data = forecast_five_single_out;
	series x = month y = sale__dollars_ / group = _type_;
	where _type_ ^= 'RESIDUAL';
run;

title1 "Seasonal Exponential Smoothing for Five Oclock";

proc forecast data = forecast_five_oclock interval = month align = end method = winters seasons = 4 lead = 12 out = forecast_five_seasonal_out outfull outresid outest = forecast_five_seasonal_est;
	var sale__dollars_;
	id month;
run;

proc sgplot data = forecast_five_seasonal_out;
	series x = month y = sale__dollars_ / group = _type_;
	where _type_ ^= 'RESIDUAL';
run;

************************** Grey Goose *********************************;

title1 "Single Exponential Smoothing for Grey Goose";

proc forecast data = forecast_grey_goose interval = month align = end method = expo lead = 12 out = forecast_grey_goose_single_out outfull outresid outest = forecast_grey_goose_single_est;
	var sale__dollars_;
	id month;
run;

proc sgplot data = forecast_grey_goose_single_out;
	series x = month y = sale__dollars_ / group = _type_;
	where _type_ ^= 'RESIDUAL';
run;

title1 "Seasonal Exponential Smoothing for Grey Goose";

proc forecast data = forecast_grey_goose interval = month align = end method = winters seasons = 4 lead = 12 out = forecast_grey_goose_seasonal_out outfull outresid outest = forecast_grey_goose_seasonal_est;
	var sale__dollars_;
	id month;
run;

proc sgplot data = forecast_grey_goose_seasonal_out;
	series x = month y = sale__dollars_ / group = _type_;
	where _type_ ^= 'RESIDUAL';
run;

************************ Price Elasticity *****************************;
**************************** Svedka ***********************************;

title "Log price elasticity for Svedka";

data pe_svedka;
	set svedka_vodka;
	sales_svedka = log(_sale__dollars_);
	quantity_svedka = log(volume_sold__gallons_);
run;

proc sgplot data = pe_svedka;
	scatter x = sales_svedka y = quantity_svedka;
run;

title "Regression analysis for price and quantity of Svedka";

proc autoreg data = pe_svedka;
	model sales_svedka = quantity_svedka;
run;
quit;

**************************** Smirnoff **********************************;

title "Log price elasticity for Smirnoff";

data pe_smirnoff;
	set smirnoff_vodka;
	sales_smirnoff = log(_sale__dollars_);
	quantity_smirnoff = log(volume_sold__gallons_);
run;

proc sgplot data = pe_smirnoff;
	scatter x = sales_smirnoff y = quantity_smirnoff;
run;

title "Regression analysis for price and quantity of Smirnoff";

proc autoreg data = pe_smirnoff;
	model sales_smirnoff = volume_smirnoff;
run;
quit;

**************************** Absolut **********************************;

title "Log price elasticity for Absolut";

data pe_absolut;
	set absolut_vodka;
	sales_absolut = log(_sale__dollars_);
	quantity_absolut = log(volume_sold__gallons_);
run;

proc sgplot data = pe_absolut;
	scatter x = sales_absolut y = quantity_absolut;
run;

title "Regression analysis for price and quantity of Absolut";

proc autoreg data = pe_absolut;
	model sales_absolut = quantity_absolut;
run;
quit;

**************************** Grey Goose **********************************;

title "Log price elasticity for Grey Goose";

data pe_grey_goose;
	set grey_goose_vodka;
	sales_grey_goose = log(_sale__dollars_);
	quantity_grey_goose = log(volume_sold__gallons_);
run;

proc sgplot data = pe_grey_goose;
	scatter x = sales_grey_goose y = quantity_grey_goose;
run;

title "Regression analysis for price and quantity of Grey Goose";

proc autoreg data = pe_grey_goose;
	model sales_grey_goose = quantity_grey_goose;
run;
quit;

**************************** Five O'clock **********************************;

title "Log price elasticity for Five O'clock";

data pe_five_oclock;
	set five_oclock_vodka;
	sales_five_oclock = log(_sale__dollars_);
	quantity_five_oclock = log(volume_sold__gallons_);
run;

proc sgplot data = pe_five_oclock;
	scatter x = sales_five_oclock y = quantity_five_oclock;
run;

title "Regression analysis for price and quantity of Five O'clock";

proc autoreg data = pe_five_oclock;
	model sales_five_oclock = quantity_five_oclock;
run;
quit;

**************************** New Amsterdam **********************************;

title "Log price elasticity for New Amsterdam";

data pe_new_amsterdam;
	set new_amsterdam_vodka;
	sales_new_amsterdam = log(_sale__dollars_);
	quantity_new_amsterdam = log(volume_sold__gallons_);
run;

proc sgplot data = pe_new_amsterdam;
	scatter x = sales_new_amsterdam y = quantity_new_amsterdam;
run;

title "Regression analysis for price and quantity of New Amsterdam";

proc autoreg data = pe_new_amsterdam;
	model sales_new_amsterdam = quantity_new_amsterdam;
run;
quit;
