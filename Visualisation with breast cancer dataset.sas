/*import project dataset*/
proc import datafile='/home/u59058962/sasuser.v94/Dataset/PROJECTC.csv' out=PROJECTC dbms=csv replace;
getnames=yes;
run;

proc print data=PROJECTC;
run;

proc lifetest data=work.projectc plots=survival;
time DFS * EVENTDFS(1);
strata MORPHOLOGY;
run;

proc lifetest data=work.projectc plots=survival;
time DFS * EVENTDFS(1);
strata HORMONE;
run;

proc lifetest data=work.projectc plots=survival(strata=individual);
time DFS * EVENTDFS(1);
strata MORPHOLOGY;
run;

proc lifetest data=work.projectc plots=survival(strata=individual);
time DFS * EVENTDFS(1);
strata HORMONE;
run;

proc lifetest data=work.projectc plots=survival(strata=panel);
time DFS * EVENTDFS(1);
strata MORPHOLOGY;
run;

proc lifetest data=work.projectc plots=survival(strata=panel);
time DFS * EVENTDFS(1);
strata HORMONE;
run;

proc lifetest data=work.projectc plots=survival(cb=hw test);
time DFS * EVENTDFS(1);
strata MORPHOLOGY;
run;

proc lifetest data=work.projectc plots=survival(cb=hw test);
time DFS * EVENTDFS(1);
strata HORMONE;
run;

proc lifetest data=work.projectc plots=survival(cb=ep test);
time DFS * EVENTDFS(1);
strata MORPHOLOGY;
run;

proc lifetest data=work.projectc plots=survival(cb=ep test);
time DFS * EVENTDFS(1);
strata HORMONE;
run;

proc lifetest data=work.projectc plots=survival(cb=all test);
time DFS * EVENTDFS(1);
strata MORPHOLOGY;
run;

proc lifetest data=work.projectc plots=survival(cb=all test);
time DFS * EVENTDFS(1);
strata HORMONE;
run;

proc lifetest data=work.projectc plots=survival(cb=hw test atrisk);
time DFS * EVENTDFS(1);
strata MORPHOLOGY;
run;

proc lifetest data=work.projectc plots=survival(cb=hw test atrisk);
time DFS * EVENTDFS(1);
strata HORMONE;
run;

proc lifetest data=work.projectc plots=survival(cb=hw test atrisk(maxlen=13));
time DFS * EVENTDFS(1);
strata MORPHOLOGY;
run;

proc lifetest data=work.projectc plots=survival(cb=hw test atrisk);
time DFS * EVENTDFS(1);
strata HORMONE;
run;

proc lifetest data=work.projectc
plots=survival(atrisk(maxlen=13 outside(0.25)));
time DFS * EVENTDFS(1);
strata MORPHOLOGY;
run;

proc lifetest data=work.projectc
plots=survival(atrisk(maxlen=13 outside(0.25)));
time DFS * EVENTDFS(1);
strata HORMONE;
run;

proc lifetest data=work.projectc
plots=survival(atrisk(maxlen=13 outside)=0 to 25 by 2);
time DFS * EVENTDFS(1);
strata MORPHOLOGY;
run;

proc lifetest data=work.projectc
plots=survival(atrisk(maxlen=13 outside)=0 to 30 by 5);
time DFS * EVENTDFS(1);
strata HORMONE;
run;

proc lifetest data=work.projectc
plots=survival(nocensor test atrisk(maxlen=10));
time DFS * EVENTDFS(1);
strata MORPHOLOGY;
run;

proc lifetest data=work.projectc
plots=survival(cb=hw failure test atrisk(maxlen=10));
time DFS * EVENTDFS(1);
strata MORPHOLOGY;
run;

proc lifetest data=work.projectc
plots=survival(cb=hw failure test atrisk(maxlen=10));
time DFS * EVENTDFS(1);
strata HORMONE;
run;

proc lifetest data=work.projectc
plots=survival(cb=hw failure test atrisk (maxlen=10) strata=panel);
time DFS * EVENTDFS(1);
strata HORMONE;
run;

/******Histogram****/
proc univariate data=work.projectc;

histogram Age
/
normal(
mu=est
color=bib
sigma=est
)
barlabel=count midpoints=0 to 90 by 5;
label Age="Patients Age";
title "Breast Cancer Patients Age";

run;

/***1) ER/PR - POSITIVE, HER2 - NEGATIVE, TREATMENT STATUS - Yes, LETROZOLE-1**/
proc sql;
create table ER1 as
select * from work.projectc where ER="POSITIVE" and PR="POSITIVE" and HER2="NEGATIVE" and STATUS='1-Yes' and LETROZOLE=1;

quit;

proc sgplot data=ER1;
vbar DFS;
title "ER/PR - POSITIVE, HER2 NEGATIVE - DFS";
run;

ods graphics / reset width=6.4in height=4.8in imagemap;

proc sgplot data=ER1;
	vline DFS /;
	yaxis grid;
title "ER/PR-POSITIVE, LETROZOLE- DISEASE FREE SURVIVAL";
run;

ods graphics / reset;

ods graphics / reset width=6.4in height=4.8in imagemap;

proc sgplot data=WORK.ER1;
	histogram DFS / showbins;
	density DFS;
	yaxis grid;
run;

ods graphics / reset;

/***2) ER/PR - POSITIVE, HER2 - NEGATIVE, TREATMENT STATUS - Yes, TAMOXIFEN**/
proc sql;
create table ER2 as
select * from work.projectc where ER="POSITIVE" and PR="POSITIVE" and HER2="NEGATIVE" and STATUS='1-Yes' and TAMOXIFEN=1;

quit;

proc sgplot data=ER2;
vbar DFS;
title "ER/PR - POSITIVE, HER2 NEGATIVE - DFS";
run;

proc sgplot data=ER2;
	vline DFS /;
	yaxis grid;
run;

ods graphics / reset;

ods graphics / reset width=6.4in height=4.8in imagemap;

proc sgplot data=WORK.ER1;
	histogram DFS / showbins;
	density DFS;
	yaxis grid;
run;

ods graphics / reset;

/***3) ER/PR/HER2 - POSITIVE, TREATMENT STATUS - Yes, TAMOXIFEN, TRASTUZUMAB**/
proc sql;
create table ER3 as
select * from work.projectc where ER="POSITIVE" and PR="POSITIVE" and HER2="POSITIVE" and STATUS='1-Yes' and TAMOXIFEN=1 and TRASTUZUMAB="Yes";

quit;

proc sgplot data=ER3;
vbar DFS;
title "ER/PR/HER2 - POSITIVE- DFS";
run;

proc sgplot data=ER3;
	vline DFS /;
	yaxis grid;
run;

ods graphics / reset;

ods graphics / reset width=6.4in height=4.8in imagemap;

proc sgplot data=WORK.ER3;
	histogram DFS / showbins;
	density DFS;
	yaxis grid;
run;

ods graphics / reset;

/***4) ER/PR/HER2 - POSITIVE, TREATMENT STATUS - Yes, TAMOXIFEN, but TRASTUZUMAB - No**/
proc sql;
create table ER4 as
select * from work.projectc where ER="POSITIVE" and PR="POSITIVE" and HER2="POSITIVE" and STATUS='1-Yes' and TAMOXIFEN=1 and TRASTUZUMAB="No";

quit;


proc sgplot data=ER4;
vbar DFS;
title "ER/PR/HER2 - POSITIVE- DFS";
run;

proc sgplot data=ER4;
	vline DFS /;
	yaxis grid;
run;

ods graphics / reset;

ods graphics / reset width=6.4in height=4.8in imagemap;

proc sgplot data=WORK.ER4;
	histogram DFS / showbins;
	density DFS;
	yaxis grid;
run;

ods graphics / reset;


/***5) ER/PR/HER2 - POSITIVE, TREATMENT STATUS - Yes, LETROZOLE, TRASTUZUMAB**/
proc sql;
create table ER5 as
select * from work.projectc where ER="POSITIVE" and PR="POSITIVE" and HER2="POSITIVE" and STATUS='1-Yes' and LETROZOLE=1 and TRASTUZUMAB="Yes";

quit;

proc sgplot data=ER5;
vbar DFS;
title "ER/PR/HER2 - POSITIVE- DFS";
run;

/***6) ER/PR/HER2 - POSITIVE, TREATMENT STATUS - Yes, LETROZOLE, but TRASTUZUMAB - No**/
proc sql;
create table ER6 as
select * from work.project where ER="POSITIVE" and PR="POSITIVE" and HER2="POSITIVE" and STATUS='1-Yes' and LETROZOLE=1 and TRASTUZUMAB="No";

quit;

proc sgplot data=ER6;
vbar DFS;
title "ER/PR/HER2 - POSITIVE- DFS";
run;

/***7) ER- POSITIVE, PR/HER2 - NEGATIVE, TREATMENT STATUS - Yes, LETROZOLE*/
proc sql;
create table ER7 as
select * from work.project where ER="POSITIVE" and PR="NEGATIVE" and HER2="NEGATIVE" and STATUS='1-Yes' and LETROZOLE=1;

quit;

proc sgplot data=ER7;
vbar DISEASESTATUS;
title "ER - POSITIVE- DISEASESTATUS";
run;

proc sgplot data=ER7;
vbar DFS;
title "ER - POSITIVE- DFS";
run;

proc sgplot data=ER7;
vbar OS;
title "ER - POSITIVE- OS";
run;

/***8 PR - POSITIVE, ER/HER2 - NEGATIVE, INTENT-Curative, TREATMENT STATUS - Yes, TAMOXIFEN*/
proc sql;
create table ER8 as
select * from work.project where ER="NEGATIVE" and PR="POSITIVE" and HER2="NEGATIVE" and INTENTION='1-Curative' and STATUS='1-Yes' and TAMOXIFEN=1;

quit;

proc sgplot data=ER8;
vbar DISEASESTATUS;
title "PR - POSITIVE- DISEASESTATUS";
run;

proc sgplot data=ER8;
vbar DFS;
title "PR - POSITIVE- DFS";
run;

proc sgplot data=ER8;
vbar OS;
title "PR - POSITIVE- OS";
run;

/***9 PR - NEGATIVE, ER/HER2 - POSITIVE, INTENT-Curative, TREATMENT STATUS - Yes, TAMOXIFEN AND TRASTUZUMAB*/
proc sql;
create table ER9 as
select * from work.project where ER="POSITIVE" and PR="NEGATIVE" and HER2="POSITIVE" and INTENTION='1-Curative' and STATUS='1-Yes' and TAMOXIFEN=1 and TRASTUZUMAB="Yes";

quit;

proc sgplot data=ER9;
vbar DISEASESTATUS;
title "ER/HER2- POSITIVE- DISEASESTATUS";
run;

proc sgplot data=ER9;
vbar DFS;
title "ER/HER2 - POSITIVE- DFS";
run;

proc sgplot data=ER9;
vbar OS;
title "ER/HER2 - POSITIVE- OS";
run;

/***10 PR - NEGATIVE, ER/HER2 - POSITIVE, INTENT-Curative, TREATMENT STATUS - Yes, LETROZOLE AND TRASTUZUMAB*/
proc sql;
create table ER10 as
select * from work.project where ER="POSITIVE" and PR="NEGATIVE" and HER2="POSITIVE" and INTENTION='1-Curative' and STATUS='1-Yes' and LETROZOLE=1 and TRASTUZUMAB="Yes";

quit;

proc sgplot data=ER10;
vbar DISEASESTATUS;
title "ER/HER2- POSITIVE- DISEASESTATUS";
run;

proc sgplot data=ER10;
vbar DFS;
title "ER/HER2 - POSITIVE- DFS";
run;

proc sgplot data=ER10;
vbar OS;
title "ER/HER2 - POSITIVE- OS";
run;

/***11 PR - NEGATIVE, ER/HER2 - POSITIVE, INTENT-Curative, TREATMENT STATUS - Yes, LETROZOLE AND NO TRASTUZUMAB*/
proc sql;
create table ER11 as
select * from work.project where ER="POSITIVE" and PR="NEGATIVE" and HER2="POSITIVE" and INTENTION='1-Curative' and STATUS='1-Yes' and LETROZOLE=1 and TRASTUZUMAB="No";

quit;

proc sgplot data=ER11;
vbar DISEASESTATUS;
title "ER/HER2- POSITIVE- DISEASESTATUS";
run;

proc sgplot data=ER11;
vbar DFS;
title "ER/HER2 - POSITIVE- DFS";
run;

proc sgplot data=ER11;
vbar OS;
title "ER/HER2 - POSITIVE- OS";
run;

/**12 ER - NEGATIVE, PR/HER2 - POSITIVE, INTENT-Curative, TREATMENT STATUS - Yes, LETROZOLE AND TRASTUZUMAB*/
proc sql;
create table ER12 as
select * from work.project where ER="NEGATIVE" and PR="POSITIVE" and HER2="POSITIVE" and INTENTION='1-Curative' and STATUS='1-Yes' and LETROZOLE=1 and TRASTUZUMAB="Yes";

quit;

proc sgplot data=ER12;
vbar DISEASESTATUS;
title "PR/HER2- POSITIVE- DISEASESTATUS";
run;

proc sgplot data=ER12;
vbar DFS;
title "PR/HER2 - POSITIVE- DFS";
run;

proc sgplot data=ER12;
vbar OS;
title "PR/HER2 - POSITIVE- OS";
run;

/**13 ER/PR/HER2 - NEGATIVE, INTENT-Curative, TREATMENT STATUS - Yes*/
proc sql;
create table ER13 as
select * from work.project where ER="NEGATIVE" and PR="NEGATIVE" and HER2="NEGATIVE" and INTENTION='1-Curative' and STATUS='1-Yes';

quit;

proc sgplot data=ER13;
vbar DISEASESTATUS;
title "TNBC- DISEASESTATUS";
run;

proc sgplot data=ER13;
vbar DFS;
title "TNBC - DFS";
run;

proc sgplot data=ER13;
vbar OS;
title "TNBC - OS";
run;

/*---14 Age---*/
proc univariate data=work.project;

histogram Age
/
normal(
mu=est
color=bib
sigma=est
)
barlabel=count midpoints=0 to 90 by 5;
label Age="Patients Age";
title "Breast Cancer Patients Age";

run;

/*---15 Ki67 AND CLINICAL EXTENT---*/
proc sgplot data=work.project;
vbar KI67 / group=CLINICALEXTENT;
title "KI67 AND CLINICAL EXTENT";
run;

/*---16 Ki67 AND CLINICAL EXTENT---*/
proc sgplot data=work.project;
vbar KI67 / group=DISEASESTATUS;
title "KI67 AND DISEASE STATUS";
run;

/*---17 Ki67 AND TNBC---*/
proc sql;
create table ER14 as
select * from work.project where ER="NEGATIVE" and PR="NEGATIVE" and HER2="NEGATIVE";

quit;

proc sgplot data=ER14;
vbar KI67;
title "TNBC- KI67";
run;

/*---18 Ki67 AND ER/PR---*/
proc sql;
create table ER15 as
select * from work.project where ER="POSITIVE" and PR="POSITIVE" and HER2="NEGATIVE";

quit;

proc sgplot data=ER15;
vbar KI67;
title "ER/PR-POSITIVE, KI67";
run;

/*---19 Ki67 AND HER2---*/
proc sql;
create table ER16 as
select * from work.project where ER="NEGATIVE" and PR="NEGATIVE" and HER2="POSITIVE";

quit;

proc sgplot data=ER16;
vbar KI67;
title "HER2-POSITIVE, KI67";
run;

/*---20 MORPHOLOGY AND CLINICAL EXTENT---*/
proc sgplot data=work.project;
vbar MORPHOLOGY / group=DISEASESTATUS;
title "TYPE OF CANCER AND DISEASE STATUS";
run;

/*---20 MORPHOLOGY AND KI67 ---*/
proc sgplot data=work.project;
vbar MORPHOLOGY / group=KI67;
title "TYPE OF CANCER AND KI67";
run;

/*---21 MORPHOLOGY AND CLINICAL EXTENT---*/
proc sgplot data=work.project;
vbar MORPHOLOGY / group=CLINICALEXTENT;
title "TYPE OF CANCER AND CLINICAL EXTENT";
run;

/*---22 MORPHOLOGY AND DFS---*/
proc sgplot data=work.project;
vbar MORPHOLOGY / group=DFS;
title "TYPE OF CANCER AND DFS";
run;

/*---23 MORPHOLOGY AND DFS---*/
proc sgplot data=work.project;
vbar MORPHOLOGY / group=OS;
title "TYPE OF CANCER AND OS";
run;

/*---24 AGE AND DFS---*/
proc sgplot data=work.project;
vbar AGE / group=DFS;
title "AGE AND DFS";
run;

/*---25 AGE AND OS---*/
proc sgplot data=work.project;
vbar AGE / group=OS;
title "AGE AND OVERALL SURVIVAL";
run;

/*---26 PREGRESSION - SITE OF RECURRENCE ---*/
proc sql;
create table ER17 as
select * from work.project where DISEASESTATUS="5-Cancer in progression";

quit;

proc sgplot data=ER17;
vbar SITEOFRECURRENCE;
title "SITE OF RECURRENT AT THE TIME OF PROGRESSION";
run;

/*27---COVID---*/
proc sgplot data=work.project;
vbar COVID;
title "COVID STATUS";
run;

/*27---PROCEDURE---*/
proc sgplot data=work.project;
vbar PROCEDURE;
title "SURGERY UNDERGONE";
run;

/*28---DIABETES---*/
proc sgplot data=work.project;
vbar DIABETES;
title "DIABETES MELLITUS";
run;

/*29---HYPERTENSION---*/
proc sgplot data=work.project;
vbar HTN;
title "HYPERTENSION";
run;

/*29---HYPOTHYROIDISM---*/
proc sgplot data=work.project;
vbar HYPOTHYROIDISM;
title "HYPOTHYROIDISM";
run;

/*30---DYSLIPIDEMIA---*/
proc sgplot data=work.project;
vbar DLP;
title "DYSLIPIDEMIA";
run;

/*---31 - DIABETES / HYPERTENSION AND HYPOTHYROIDISM---*/
proc sql;
create table ER18 as
select * from work.project where DIABETES="Yes" and HTN="Yes";

quit;

proc sgplot data=ER18;
vbar DISEASESTATUS;
title "DISEASE STATUS OF DIABETES AND HYPERTENSION";
run;


/****Bar plot****/

proc sgplot data=work.project;
vbar HER2;
title "HER2 hormone";
run;

/*group ploting*/
proc sgplot data=work.project;
vbar AGE / group=CLINICALEXTENT;
title "AGE AND CLINICAL EXTENT";
run;