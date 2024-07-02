cmake_minimum_required (VERSION 2.6)
project (ds1302)
add_executable(ds1302 ds1302.c)
install(TARGETS ds1302 DESTINATION bin)
