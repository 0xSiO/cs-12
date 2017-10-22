// Example program to blink an LED on a Raspberry Pi

#include <wiringPi/wiringPi.h>
#include <stdio.h>

#define  LedPin    0

int main(void)
{
	if(wiringPiSetup() == -1) {
		printf("setup wiringPi failed !");
		return 1; 
	}
	printf("linker LedPin : GPIO %d(wiringPi pin)\n",LedPin);
	
	pinMode(LedPin, OUTPUT);

	while(1){
			digitalWrite(LedPin, LOW);
			delay(1000);
			digitalWrite(LedPin, HIGH);
			delay(1000);
	}

	return 0;
}
