year = {jan: 31, feb: 28, feb_leap: 29, mar: 31, apr: 30, may: 31, jun: 30, jul: 31, aug: 31, sept: 30, okt: 31, nov: 30, dec: 31}
year.each { |m,d| puts m if d == 30 }
