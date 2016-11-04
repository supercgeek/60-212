import json
from datetime import datetime as dt

# JSON LOAD
myFile = open("LocationHistory.json")
# myFile = open("testLocHist.json")
js = json.load(myFile)
#js = [2012,2013,2014,2015,2016,2017]

# Vars 
nLocations = len(js["locations"])
deleteIndexes = set() #must be a set so it be be easily indexed, gautam bose (andrew: gbose) helped me with the logic behind switching this from a list to a set

print("years in main loop: ")
for i in range(nLocations):
    curTimeStamp = js["locations"][i]["timestampMs"]
    #print(curTimeStamp)
    ## converting milliseconds to seconds   
    humanDate = dt.fromtimestamp(float(curTimeStamp)/1000.0)
    #print(humanDate)
    curYear = humanDate.year
    curMon = humanDate.month 
    curDay = humanDate.day

    #print(str(curMon) + " " + str(curDay))

    if curYear == 2014:  # if the condition is met, the items will be deleted
        # keep these
        # print(curYear)
        if curMon >= 7 and curMon <= 8:
            #print(curYear)
            
            if curMon == 7:
            
                if curDay >= 12:
                    pass
                    #print("locked")
                    #print(humanDate)
                else:
                    deleteIndexes.add(i)

            if curMon == 8:
                if curDay <= 18:
                    pass
                    #print("locked")
                    #print(humanDate)
                else:
                    deleteIndexes.add(i)
        else:
            deleteIndexes.add(i)
    else: 
        deleteIndexes.add(i)
    #@Cam added this conditional to remove a brief trip to SF

    if js["locations"][i]["latitudeE7"] < 350000000:
        pass
    else:
        # print('case1')
        deleteIndexes.add(i)

# print("## start delete loop from ##")
# print(deleteIndexes) 
# print("w/ LENGTH OF ---> ")
# print(len(deleteIndexes))
# print("______")



### PERCENTAGE GUESSOR 
# print(nLocations)
# print("&&")
# print(deleteIndexes)

for x in range(nLocations, 0, -1):
    print(x)
    if x in deleteIndexes:

        del js["locations"][x]

##### CHECKER LOOP
# for y in range(len(js["locations"])):
#     curAgTimeStamp = js["locations"][y]["timestampMs"]
#     # print(curAgTimeStamp)

#     print(dt.fromtimestamp(float(curAgTimeStamp)/1000.0))


open("updated-file.json", "w").write(
    json.dumps(js, sort_keys=True, indent=4, separators=(',', ': '))
    )



# print(deleteIndexes)
# print(js["locations"])
# date = {}

# date = datetime.fromtimestamp(int("unixTimeVar"))
# year = date.year
# hour = date.hou∫∫r∫

##date.year
##etc. unpack 
# #print("a total of" + nLocations + "exist in this JSON File") #TypeError: Can't convert 'int' object to str implicitly
# print("Locs:")
# print(nLocations)
#print(curYear)
#print(huma  nDate.year)ss
# year = humanDate.year
# print(js["locations"][0]["timestampMs"])
# print(js["locations"][1]["timestampMs"])