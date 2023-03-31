# Flutter Platform for real-time monitoring of COVID-19 patients (Colombia)
# Project analysis
As of 26 March 2020, the number of confirmed cases of patients with IDOC-19 was 462,648 worldwide. The stability of health systems in many countries has been affected by the increasing need for Intensive Care Units (ICUs), especially the availability of mechanical ventilation devices for the care of patients with the most severe symptoms of the disease.
Due to the high rate of infection of the virus, the models developed for the estimation and projection of hospital resources show an imminent overcoming of the attention capacities of the health services in intensive care, which on average happens 30 days after the beginning of the epidemic, depending on the installed capacities of each country. Similarly, it is concluded that there is no timely diagnosis of those critical patients due to the lack of tools for remote monitoring.

The increase in the number of patients in hospitals is one of the variables that has generated a high incidence of mortality among those suffering from SARS-V2. This generates a possible spread of the virus within the same facilities because many developing countries do not have the sanitary conditions to isolate the virus within their own physical facilities. For this reason, the United States has opted for continuous monitoring, which allows for the total isolation of the patient. However, this still requires a tool that physicians can use to monitor their patients in a controlled manner. 

In South Korea, for example, an application has been developed to monitor the symptoms of potential COVID-19 patients. However, there are few applications that can effectively monitor the patient&#39;s physiological variables and generate a diagnosis with greater performance.
Mobile applications are easily accessible and scalable, since most of the population has a Smartphones. This has allowed many disruptive solutions, especially in the eHealth sector, to be based on wearable devices for the continuous monitoring of patients over long distances, such as smart bands or watches or even mobile phones. For example, for obstructive sleep-disrupting events in some patients.

Mechanical ventilators are an indispensable element in the treatment of the disease. Given the experiences of countries such as Italy, Spain and recently the United States, a mechanical ventilator is often the only chance of survival for patients with severe symptoms and critical affects on the respiratory system (dyspnea and respiratory failure).

The emergency has caused the demand for ventilators to increase and the processes of production and acquisition of this equipment to become a priority. Many countries have implemented strategies for the production of alternative prototypes of mechanical ventilation, with the support of universities and the private sector. Such strategies help to cope with the high investments needed by hospitals and the increasingly difficult conditions for importing and exporting this type of equipment.

Examples of a node server for random data generation and an Android Expo (React Native) client to gather the data. Communication uses IBM services or infrastructure. IOS version is untested but might work as well.

## Description

This is a simple 3-block test project for IBM realtime info integration. 
First, a Node (or python) generator will produce random numbers to send them to the cloud (IBM tech)
Second, the IBM service will be configured (see appendix) to support the realtime changes and save the stored data.
Third, a react native client in Expo will gather the data and display it somehow

Requirements:
	1. Block 1: Uses any easy-setup communication technology:
		Socket.io, MQTT, Direct Database access API, HTTP APIs, or any other. Must be supported by IBM services or infrastructure.
	2. Block 2: According to B1, the service or infrastructure must be easily-configured and have a free-tier.
	3. Block 3: Gathering data also depend on the selected technology and platform. Graphics are optional.
	4. All Blocks: data struct is dynamic, each key, value is decomposed in (value, timestamp, max, min, other) keys. e.g:
		{ 
			data1: { 
				value: 1, 
				timestamp: <ns-timestamp>,
				max: 2000,
				min: 0,
				other: {}			
			}, 
			data2: { 
				value: 1002, 
				timestamp: <ns-timestamp>,
				max: 2000,
				min: 0,
				other: {}			
			},
			...
		}
	
	
## Full Application

Refer to this repository.

`git clone https://github.com/sebasmos/PneumApp.git`.

Update dependencies with `npm install` and `npm upgrade`.

Mind that you must keep React navigation with version 3.0.4. 

## Set-up 🤬

Requires NodeJS, NPM and Expo installed.
Download or clone this repo:

`git clone https://github.com/Kseg97/ibm_platform_communication_examples`

To download just press on the download button and unzip in your working env.
Run `npm install` and then `npm start` in the *node_server_gen_using_ibm* folder to execute the number generator.
Run `npm install` and then `npm start` in the *expo_react_client* folder to execute the Expo server and therefore your app in the Android client
Change *.env* with the team credentials.
## Artificial ventilator - Bluetooth interface 
Check our manual for further instructions regarding how to configure your artificial ventilator in our App.

If you have any doubts or suggestions, please let us in sebasmos@ieee.org
