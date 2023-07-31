int count_arr[23] = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x20, 0x21, 0x22, 0x23};
int count = 22;
int state = 0;
int man_flag = 0, i,man_state, push_count = 0;

int getInput(int count){
     count = ~count;
     while(!PORTA.B4);
     return count;
}

void main() {
     TRISB = 0x00;
     ADCON1 = 0x07;
     TRISA.B4 = 1;
     TRISA.B0 = 1;
     TRISC = 0x00;
     PORTC = 0x00;
     PORTB = 0x00;
     TRISD = 0x00;
     PORTD = 0x00;
     while(PORTA.B4 == 1);
     while(1){
          while(PORTA.B4 == 0){
              push_count = 1;
          }
          while(push_count){
               PORTC = 0x00;
               if(PORTA.B0 == 1){
                    if(PORTD.B0 == 1 && PORTD.B5 == 1){
                         PORTD.B5 = 0;
                         PORTD.B4 = 1;
                         Delay_ms(375);
                         PORTD.B4 = 0;
                         PORTD.B0 = 0;
                         PORTD.B2 = 1;
                         PORTD.B3 = 1;
                    }
                    else if(PORTD.B2 == 1 && PORTD.B3 == 1){
                         PORTD.B2 = 0;
                         PORTD.B1 = 1;
                         for(man_state = 0; man_state <= 3; man_state++) Delay_ms(125);
                         PORTD.B1 = 0;
                         PORTD.B0 = 1;
                         PORTD.B3 = 0;
                         PORTD.B5 = 1;
                    }
               }
               while(PORTA.B4 == 0){
                    if(push_count) push_count = 0;
               }
          }
          while(!push_count){
               PORTC = 0X0F;
               //1: Red 2: Yellow ---> 0x11
               //1: Red 2: Green ---> 0x21
               //1: Yellow 2: Red ---> 0x0A
               //1: Green 2: Red ---> 0x0C
               if(PORTD.B0 && PORTD.B5) state = 0;
               else if(PORTD.B2 && PORTD.B3) state = 1;
               switch(state){
                   case 0:
                       PORTD = 0x21;
                       count = 14;
                       break;
                   case 1:
                       PORTD = 0x0C;
                       count = 22;
                       break;
               }
               for(; count >= 0; count--){

                    if(push_count) break;
                    PORTB = count_arr[count];
                    if(count <= 2 && state == 0) PORTD = 0x11;
                    else if(count <= 2 && state == 1) PORTD = 0x0A;
                    for(i = 0; i < 125; i++){
                         while(!PORTA.B4){
                               push_count = getInput(push_count);
                         }
                         Delay_ms(1);
                    }
               }
               if(push_count) break;
               if(state == 0) state = 1;
               else if(state == 1) state = 0;
          }
     }
}