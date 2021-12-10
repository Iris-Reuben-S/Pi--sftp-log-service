import re
import sys
import json

keys = []
values = []

def main():
	filename = sys.argv[1]
	with open('/home/pi/pi-logs/' + filename + ".log", 'r') as f:
		for line in f:
			read(line)
		f.close
	with open('/home/pi/pi-logs/' + filename + ".json", "w+") as f:
		f.truncate(0)		
		json_out = json.dumps({keys[0]: values[0], keys[1]: values[1], "log_time": filename}, indent=4)	
		#json_out = json.dumps({keys[0]: values[0], keys[1]: values[1]}, indent=4)
		f.write(json_out)
		f.close
def read(line):
	if '"' and ':' in line:
		line = re.sub(r'[\",]+', "", line).rstrip()
		line = line.lstrip()
		line = line.split(": ")
		keys.append(line[0])
		values.append(line[1])
	elif "'C" and "=" and "temp" in line:
		line = re.sub(r'[\'C]+', "", line).rstrip()
		#temp_val = float(re.search(r'\d+\.\d+', formline).group())
		line = line.split("=")
		keys.append(line[0])
		values.append(line[1])
main()
