
#ifndef __ap_fixed_H__
#define __ap_fixed_H__
#include <stdio.h>

template <int _AP_W, int _AP_I>
class ap_fixed{

	struct Proxy{
		ap_fixed<_AP_W, _AP_I>* parent = nullptr;
		int hi, lo;

		// When ap_unit is rhs
		Proxy& operator =(unsigned u) {parent->set(hi, lo, u); return *this;}

		Proxy& operator =(Proxy u) {parent->set(hi, lo, u); return *this;}

		// When ap_unit is lhs
		operator unsigned int () const {return parent->range(hi, lo);}
	};

	public:
		#if(T==8)
			unsigned char data = 0;
		#elif(T==16)
			unsigned short data = 0;
		#elif(T==32)
			unsigned int data = 0;
		#else
			unsigned int data = 0;
		#endif

		// constructor
		//ap_fixed<_AP_W, _AP_I>(unsigned int u) {data = u;}
		ap_fixed<_AP_W, _AP_I>(float f) {
			int i_part;
			unsigned char i;
			unsigned int f_part=0;
			i_part = (int) f;
			float d_part = f>0 ? f-i_part : -f+i_part;
			for(i=0; i<(_AP_W-_AP_I); i++){
				d_part = d_part * 2;
				if(d_part >= 1){
					f_part = (f_part << 1) + 1;
					d_part -= 1;
				}else{
					f_part = (f_part << 1) + 0;
				}
			}

			i_part = i_part < 0 ? -i_part : i_part;
			data = (i_part << (_AP_W-_AP_I))|f_part;
			data = f > 0 ? data : ~data+1;

		}

		ap_fixed<_AP_W, _AP_I>(){ data = 0;}
		template <int _AP_W_2, int _AP_I_2>
		ap_fixed<_AP_W, _AP_I>(ap_fixed<_AP_W_2, _AP_I_2> op2){
			unsigned char bits_array[32];
			unsigned char bits_array2[32];
			unsigned int din;
			unsigned char i;
			unsigned char _AP_F, _AP_F_2;
			_AP_F =_AP_W-_AP_I;
			_AP_F_2 = _AP_W_2-_AP_I_2;;

			for(i=0; i<_AP_W; i++){
				bits_array[i] = 0;
			}
			din = op2.data;
			this->data_to_array(bits_array2, din);

			if(_AP_I < _AP_I_2){
				for(i=0; i<_AP_I; i++){ bits_array[i+_AP_F] = bits_array2[i+_AP_F_2];}
			}else{
				for(i=0; i<_AP_I_2; i++){ bits_array[i+_AP_F] = bits_array2[i+_AP_F_2];}
				for(i=0; i<_AP_I-_AP_I_2; i++){ bits_array[_AP_I_2+_AP_F+i] = bits_array2[_AP_W_2-1]; }
			}

			if(_AP_F < _AP_F_2){
				for(i=0; i<_AP_F; i++){ bits_array[_AP_F-1-i] = bits_array2[_AP_F_2-1-i];}
			}else{
				for(i=0; i<_AP_F_2; i++){ bits_array[_AP_F-1-i] = bits_array2[_AP_F_2-1-i];}
			}

			data = this->array_to_data(bits_array);

		}

		unsigned int array_to_data (unsigned char bits_array[32]){
			unsigned tmp_data = 0;
			for(int i=0; i<32; i++){
				tmp_data = (tmp_data << 1) + bits_array[31-i];
			}

			return tmp_data;
		}


		void data_to_array (unsigned char bits_array[32], unsigned int din){
			unsigned tmp_data = din;
			int i=0;
			for(i=0; i<32; i++){
				bits_array[i] = (tmp_data & 0x00000001) ? 1 : 0;
				tmp_data = tmp_data>>1;
			}
		}


		// slice the bit[b:a] out and return the sliced data
		unsigned int range(int b, int a) const {
			unsigned tmp1 = 0;
			unsigned tmp2 = 0;
			tmp1 = data >> a;
			for(int i=0; i<(b-a+1); i++) tmp2 = (tmp2<<1)+1;
			return tmp1&tmp2;
		}

		// manually set bit[b:a] = rhs
		void set(int b, int a, unsigned int rhs){
			unsigned or_mask = 0xffffffff;
			unsigned or_data = 0;
			int i;
			for(i=0; i<b-a+1; i++) or_mask = (or_mask << 1);
			for(i=0; i<a; i++) or_mask = (or_mask << 1)+1;
			or_data = data & or_mask;
			data = or_data | (rhs << a);
		}

		// Whenever need () operator, call out the Proxy struct
		Proxy operator() (int Hi, int Lo) {
			return {this, Hi, Lo};
		}

		Proxy operator = (Proxy op2){
			this->data = op2;
		}

	    float to_float(){
	    	unsigned char bits_array[32];
	    	float i_part=0, d_part=0;
	    	unsigned tmp_data = data;
	    	int i=0;
	    	unsigned char is_minus = 0;

	    	is_minus = (data >> (_AP_W-1)) & 0x00000001;

	    	tmp_data = is_minus ? data - 1 : data;
	    	for(i=0; i<32; i++){ bits_array[i] = (tmp_data & 0x00000001) ? 1 : 0; tmp_data = tmp_data>>1; }



	    	if(is_minus == 1) for(i=0; i<_AP_W; i++) bits_array[i] = (bits_array[i] == 1 ? 0 : 1);

	    	//calculate integer part
	    	for(i=_AP_W-1; i>(_AP_W-_AP_I-1); i--) i_part += (1<<(i-_AP_W+_AP_I))*bits_array[i];

	    	//calculate fraction part
	    	for(i=0; i<(_AP_W-_AP_I); i++) d_part += (float)bits_array[i]/(1<<((_AP_W-_AP_I)-i));

	    	// reverse the bits if the sign flag is minus
	    	return is_minus == 1 ? (-i_part-d_part) : (i_part+d_part);
	    }

	    // enable arithmetic operator
	    operator float() { return this->to_float(); }

		void operator ++(int op){
			data = data + 1;
		}


};

#endif
