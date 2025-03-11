@echo off
rem Ustawienie regionu Polski
set REGION=14/24/49/55

gmt begin project_map png
    rem Interpolacja danych z pliku 
    gmt surface your_file.txt -R%REGION% -I0.01 -Gquasigeoid.nc -T0.2

    rem Obliczenie gradientu
    gmt grdgradient quasigeoid.nc -A45 -Ne0.7 -Gquasigeoid_grad.nc

    rem Utworzenie palety kolorów
    gmt makecpt -Cgreen,yellow,red -T-100/100

    rem Przycięcie do kształtu Polski
    gmt clip polska.shp

    gmt grdimage quasigeoid.nc -Iquasigeoid_grad.nc

    rem Wyłączenie przycinania
    gmt clip -C

    rem Dodanie ramki 
    gmt basemap -Baf -Bx -By

    rem Dodanie granic Polski
    gmt plot polska.shp -W1p,black

    rem Dodanie legendy 
    gmt colorbar -DJBC+w10c/0.5c+o0/1c+h -Baf -C
gmt end show