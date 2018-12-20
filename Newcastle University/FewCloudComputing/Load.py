import sys
import numpy
import time
import matplotlib.mlab as mlab
import matplotlib.pyplot as plt
import urllib
import csv
import time

#Generate a list of random number from Normal distribution
def gettimelistbyN(para1, para2, size):
    timelistN = numpy.random.normal(loc=para1, scale=para2, size=size)
    return timelistN


#Generate a list of random number from Poisson distribution
def gettimelistbyP(para1, size):
    timelistP = numpy.random.poisson(lam=para1, size=size)
    return timelistP

# Visualize the number we generated
def Show(datas):
    plt.hist(datas, bins=100, normed=True)
    plt.show()

#Connect to url
def whlieConnect(length, url, Type, timelist):
    count = 0
    while count != length:#Choose Normal or Poisson
        if Type == 'N':#When it is Normal Distribution
        	#Generate a array of number
            #timelistN = gettimelistbyN(float(sys.argv[2]), float(sys.argv[3]), None)
            print('Start:' + str(count) + 'time')
            print('the number is:' + str(abs(timelist[count])))
            print('wait secends:' + str(timelist[count]))
            time.sleep(abs(timelist[count]))
            response = urllib.request.urlopen('http://' + url)
            data = response.read()
            _time = time.strftime('%Y.%m.%d %H:%M:%S',time.localtime(time.time()))
            data={'Time':_time,'infor':data}
            fieldnames = ['Time', 'infor']
            with open('inforN.csv', 'a', newline='',encoding='gb18030') as f:
                writer = csv.DictWriter(f, fieldnames=fieldnames)
                writer.writerows([data])
          
        elif Type == 'P':#When it is Poisson Distribution
        	#Generate a array of number
            #timelistP = gettimelistbyP(float(sys.argv[4]), None)
            print('Start:' + str(count) + 'time')
            print('the number is:' + str(abs(timelist[count])))
            print('wait secends:' + str(timelist[count]))
            time.sleep(abs(timelist[count]))
            response = urllib.request.urlopen('http://' + url)
            data = response.read()
            _time = time.strftime('%Y.%m.%d %H:%M:%S',time.localtime(time.time()))
            data={'Time':_time,'infor':data}
            fieldnames = ['Time', 'infor']
            #Save as csv
            with open('inforP.csv', 'a', newline='',encoding='gb18030') as f:
                writer = csv.DictWriter(f, fieldnames=fieldnames)
                writer.writerows([data])

        count += 1
            
if __name__ == '__main__':
	# How many parameters we used
	# 0: this .py file
	# 1: url
	# 2: mean for Normal Distribution
	# 3: standard distribution for Normal Distribution
	# 4: Lambda for Poisson Distribution

    #Open the csv file
    #with open('./CSV_Data/infor.csv', 'a', newline='') as f:
    #    fieldnames = ['Time', 'infor']
    #    writer = csv.DictWriter(f, fieldnames=fieldnames)
    #    writer.writeheader()


    if len(sys.argv) == 5:#Judge we have 4 parameters
        if sys.argv[4] == 'None':


            with open('inforN.csv', 'a', newline='') as f:
                fieldnames = ['Time', 'inforN']
                writer = csv.DictWriter(f, fieldnames=fieldnames)
                writer.writeheader()

        	# When Lambda equal None means using Normal Distribution
            timelistN = gettimelistbyN(float(sys.argv[2]), float(sys.argv[3]), 1000)
            Show(timelistN)
            length = len(timelistN)
            whlieConnect(length, sys.argv[1], 'N', timelistN)
        elif (sys.argv[3] == 'None') or (sys.argv[2] == 'None'):

            with open('inforP.csv', 'a', newline='') as f:
                fieldnames = ['Time', 'inforP']
                writer = csv.DictWriter(f, fieldnames=fieldnames)
                writer.writeheader()

        	#When mean or sd equal to None means using Poisson Distribution
            timelistP = gettimelistbyP(float(sys.argv[4]), 1000)
            Show(timelistP)
            length = len(timelistP)
            whlieConnect(length, sys.argv[1], 'P', timelistP)
        else:#check the input
            print("para2 or para3 or para4 must be one None")
    else:#check the input
        print("Please input four parameters: url; µ(int&None); σ(int&None); λ(int&None)")
