import urllib.request
import json
from pymongo import MongoClient
import time

def insertDatatoDB(infor_set, data):
    if infor_set.count(data) == 0:
        infor_set.insert(data)

def getDatas():
    reponse = urllib.request.urlopen("http://localhost:8080/api/v1.3/docker")
    reponseRead = reponse.read().decode("utf-8")
    jsonData = json.loads(reponseRead)
    return jsonData

def insertDatas(jsonData, infor_set):
    for key0 in jsonData.keys():
        Datas = jsonData[key0]
        if "labels" in Datas.keys():
            Dockername = Datas["labels"]["com.docker.swarm.service.name"].split("_")[1] + "_" + key0.split("/")[2][:10]
            for i in range(len(Datas["stats"])):
                time =Datas["stats"][i]["timestamp"]
                cpu =Datas["stats"][i]["cpu"]["usage"]["total"]
                memory = Datas["stats"][i]["memory"]["usage"]
                netreceive = Datas["stats"][i]["network"]["rx_bytes"]
                nettransform = Datas["stats"][i]["network"]["tx_bytes"]
                diskio={}
                if len(Datas["stats"][i]["diskio"]) != 0:
                    baseinfor = Datas["stats"][i]["diskio"]["io_service_bytes"]
                    for ii in range(len(baseinfor)):
                        diskname = baseinfor[ii]["device"]
                        diskread = baseinfor[ii]["stats"]["Read"]
                        diskwrite= baseinfor[ii]["stats"]["Write"]
                        diskio[diskname]= {"diskread":diskread, "diskWrite":diskwrite}
                    insertData ={"DockerName":Dockername,"time":time, "cpu":cpu, "memory":memory, "diskio":diskio,
'netreceive':netreceive, 'nettransform':nettransform}
                    insertDatatoDB(infor_set, insertData)

def main():
    client = MongoClient("127.0.0.1", 3306)
    db_auth = client.admin
    db_auth.authenticate("admin", "admin123")
    db = client.mydb
    infor_set = db.infor_set   
    jsonData = getDatas()
    insertDatas(jsonData, infor_set)
            
if __name__ == '__main__':
    while(1):
        main()
        print('wait 60s')
        time.sleep(60)
    

