#!/usr/bin/env python

import sys
water = sys.argv[1]
energy = sys.argv[2]
if(len(sys.argv) == 3):  #lack one argument for output
    output = sys.stdout  #return the output to the STDOUT stream.
elif(len(sys.argv) == 4):  #satisfy the requirement
    output = open(sys.argv[3],"w")
else:
    print("Error! The number of arguments are false!")  #whether the arguments are less than 3 or larger than 4

def mergy_files(temperature_file, energy_file, output = "output.csv"):
    """The main function is to read data from two arguments and then mergy
    the data by matching the closest time. At last, print it into a csv.file.
    """
    import re
    import time
    import datetime

    if output == "hw2-datamerge/.*.csv":  #prevent overwriting existing files unintentionally.
        print("Error! Overwrite existing files!")

    with open(energy_file) as energy:
        energy_date = []  #a list to store the energy_date
        energy_value = []  #a list to store the energy_value
        energy_month = []  #a list to store the energy_month in order to check the order
        energy_day = []  #a list to store the energy_day in order to check the order
        energy_time = []  #a list to store the energy_time in order to check the format
        for line in energy:
            if re.search(r'^(\d+).*',line):
                date = re.sub(r'^(\d{4})-(\d{2})-(\d{2}).*', r'\1-\2-\3', line)  #get the date
                value = re.sub(r'.*(-\d+),(\d+)', r'\2', line)  #get the value
                month = re.sub(r'^(\d{4})-(\d{2})-(\d{2}).*', r'\2', line)  #get the month
                day = re.sub(r'^(\d{4})-(\d{2})-(\d{2}).*', r'\3', line)  #get the day
                time = re.sub(r'.* (\d+:\d+:\d+).*(-\d+).*', r'\1,\2', line)  #get the time
                energy_date.append(date.rstrip())  #fill the energy_date list
                energy_value.append(value.rstrip())  #fill the energy_value list
                energy_month.append(month.rstrip())  #fill the energy_month list
                energy_day.append(day.rstrip())  #fill the energy_day list
                energy_time.append(time.rstrip())  #fill the energy_time list
        #print(energy_date)
        #print(energy_value)

    def check_time(time):
        """This part is to check that all dates are at 00:00:00
        (midnight, morning of the given day, Wisconsin time).
        """
        for i in range(len(time)):
            if not time[i] == "00:00:00,-0500":  #check the time format
                print("Error! The time is not at midnight, the morning of the given day, Wisconsin time")
                break
    check_time(energy_time)

    def check_order(month, day):
        """This part is to check that dates are ordered.
        """
        for i in range(len(month)-1):
            if month[i] > month[i+1]:
                print("ERROR! Dates are not ordered!")
                break
            elif month[i] == month[i+1]:
                if day[i] > day[i+1]:
                    print("ERROR! Dates are not ordered!")
                    break
    check_order(energy_month, energy_day)

    energy_date_conform = []
    for date in energy_date:  #to make the energy_date have the same format as the water_temperature date
        date_conform = datetime.datetime.strptime(date, '%Y-%m-%d').strftime('%m/%d/%y')
        energy_date_conform.append(date_conform)

    with open(temperature_file) as water:  #deal with the water_temperature file
        water_date = []  #a list to store the water_date
        water_value = []  #a list to store the water_value
        water_index = []  #a list to store the index as the first column of the output file
        for line in water:
            if re.search(r'^(\d+).*', line):
                date = re.sub(r'\d+,(.*),.*', r'\1', line)  #get the date
                value = re.sub(r'.*,(\d+.*)', r'\1', line)  #get the value
                index = re.sub(r'(\d+),.*', r'\1', line)  #get the index
                water_date.append(date.rstrip())  #fill the water_date list
                water_value.append(value.rstrip())  #fill the water_value list
                water_index.append(index.rstrip())  #fill the index list
        #print(water_date)
        #print(water_value)
    #print(energy_date_conform)
    water_date_conform = []
    for date in water_date:  #get the water_date_conform having the same format with energy_date_conform
        newdate = re.sub(r'(\d+)/(\d+)/(\d+)(.*)', r'\1/\2/\3', date)
        water_date_conform.append(newdate)
    #print(water_date_conform)

    n_energy = 1  #set the n_energy value
    currentEnergyDay = energy_date_conform[n_energy-1]  #set the current currentEnergyDay value
    water_energy_value = []  #a list to store the final value in the output file
    for i in range(len(water_date_conform)-1):  #each row in water_temperature file
        if n_energy <= len(energy_date_conform):  #i cannot be greater than len(water_date_conform)
            if water_date_conform[i] == currentEnergyDay:
                if water_date_conform[i+1] == currentEnergyDay:
                    water_energy_value.append(" ")  #to those not the nearest time
                else:
                    water_energy_value.append(str(int(energy_value[n_energy])/1000))
                    n_energy += 1
                    currentEnergyDay = energy_date_conform[n_energy-1]  #those rows to put the value
    water_energy_value.append(" ")  #the last row

    #This part is to get the output.csv file
    output.write(",".join(['"#"','"Date Time"','"Temperature"','"Energy Value(kWh)"']))  #write the column name
    output.write("\n")
    for i in range(len(water_date_conform)):
        output.write(",".join([water_index[i],water_date[i],water_value[i],water_energy_value[i]]))
        output.write("\n")
    return

if __name__=="__main__":  #handle in the terminal
    mergy_files(water, energy, output)
