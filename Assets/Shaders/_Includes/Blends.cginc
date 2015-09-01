
#ifndef BLENDS_INCLUDED
#define BLENDS_INCLUDED
 
/**********************INCLUDES**********************/
 
 
/**********************STRUCTS**********************/
struct a2f_uv0 {
    float4 vertex : POSITION;
    float4 texcoord : TEXCOORD0;
};
 
struct v2f_uv0 {
    float4 pos : SV_POSITION;
    float2 uv : TEXCOORD0;
};
 
/**********************VERTS**********************/
v2f_uv0 vert_uv0(a2f_uv0 v) {
    v2f_uv0 o;
    o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
    o.uv = v.texcoord.xy;
    return o;
}
 
/********************FUNCTIONS********************/
float4 Darken (float4 a, float4 b) { return float4(min(a.rgb, b.rgb), a.a); }
float4 Multiply (float4 a, float4 b) { return (a * b); }
float4 ColorBurn (float4 a, float4 b) { return (1-(1-a)/b); }
float4 LinearBurn (float4 a, float4 b) { return (a+b-1); }
float4 Lighten (float4 a, float4 b) { return float4(max(a.rgb, b.rgb), a.a); }
float4 Screen (float4 a, float4 b) { return (1-(1-a)*(1-b)); }
float4 ColorDodge (float4 a, float4 b) { return (a/(1-b)); }
float4 LinearDodge (float4 a, float4 b) { return (a+b); }
float4 Overlay (float4 a, float4 b) {
    float4 r = float4(0,0,0,1);
    if (a.r > 0.5) { r.r = 1-(1-2*(a.r-0.5))*(1-b.r); }
    else { r.r = (2*a.r)*b.r; }
    if (a.g > 0.5) { r.g = 1-(1-2*(a.g-0.5))*(1-b.g); }
    else { r.g = (2*a.g)*b.g; }
    if (a.b > 0.5) { r.b = 1-(1-2*(a.b-0.5))*(1-b.b); }
    else { r.b = (2*a.b)*b.b; }
    return r;
}
float4 SoftLight (float4 a, float4 b) {
    //float4 r = float4(0,0,0,1);
    //if (b.r > 0.5) { r.r = a.r*(1-(1-a.r)*(1-2*(b.r))); }
    //else { r.r = 1-(1-a.r)*(1-(a.r*(2*b.r))); }
    //if (b.g > 0.5) { r.g = a.g*(1-(1-a.g)*(1-2*(b.g))); }
    //else { r.g = 1-(1-a.g)*(1-(a.g*(2*b.g))); }
    //if (b.b > 0.5) { r.b = a.b*(1-(1-a.b)*(1-2*(b.b))); }
    //else { r.b = 1-(1-a.b)*(1-(a.b*(2*b.b))); }
    //return r;
    float4 r = float4(0,0,0,a.a);
				
    if (b.r > 0.5) 
    { 
    	r.r = a.r*(1-(1-a.r)*(1-4*(b.r))) * 0.75; 
    }
    else 
    {
    	r.r = (2.0 * a.r * b.r + a.r * a.r * (1.0 - 2.0 * b.r));
    }
    
    if (b.g > 0.5) 
    {	
    	r.g = a.g*(1-(1-a.g)*(1-4*(b.g))) * 0.75; 
    }
    else 
    { 
    	r.g = (2.0 * a.g * b.g + a.g * a.g * (1.0 - 2.0 * b.g));
    }
    
    if (b.b > 0.5) 
    { 
    	r.b = a.b*(1-(1-a.b)*(1-4*(b.b))) * 0.75; 
    }
    else 
    { 
    	r.b = (2.0 * a.b * b.b + a.b * a.b * (1.0 - 2.0 * b.b));
   	}
	
	return r;
}
float4 HardLight (float4 a, float4 b) {
    float4 r = float4(0,0,0,1);
    if (b.r > 0.5) { r.r = 1-(1-a.r)*(1-2*(b.r)); }
    else { r.r = a.r*(2*b.r); }
    if (b.g > 0.5) { r.g = 1-(1-a.g)*(1-2*(b.g)); }
    else { r.g = a.g*(2*b.g); }
    if (b.b > 0.5) { r.b = 1-(1-a.b)*(1-2*(b.b)); }
    else { r.b = a.b*(2*b.b); }
    return r;
}
float4 VividLight (float4 a, float4 b) {
    float4 r = float4(0,0,0,1);
    if (b.r > 0.5) { r.r = 1-(1-a.r)/(2*(b.r-0.5)); }
    else { r.r = a.r/(1-2*b.r); }
    if (b.g > 0.5) { r.g = 1-(1-a.g)/(2*(b.g-0.5)); }
    else { r.g = a.g/(1-2*b.g); }
    if (b.b > 0.5) { r.b = 1-(1-a.b)/(2*(b.b-0.5)); }
    else { r.b = a.b/(1-2*b.b); }
    return r;
}
float4 LinearLight (float4 a, float4 b) {
    float4 r = float4(0,0,0,1);
    if (b.r > 0.5) { r.r = a.r+2*(b.r-0.5); }
    else { r.r = a.r+2*b.r-1; }
    if (b.g > 0.5) { r.g = a.g+2*(b.g-0.5); }
    else { r.g = a.g+2*b.g-1; }
    if (b.b > 0.5) { r.b = a.b+2*(b.b-0.5); }
    else { r.b = a.b+2*b.b-1; }
    return r;
}
float4 PinLight (float4 a, float4 b) {
    float4 r = float4(0,0,0,1);
    if (b.r > 0.5) { r.r = max(a.r, 2*(b.r-0.5)); }
    else { r.r = min(a.r, 2*b.r); }
    if (b.g > 0.5) { r.g = max(a.g, 2*(b.g-0.5)); }
    else { r.g = min(a.g, 2*b.g); }
    if (b.b > 0.5) { r.b = max(a.b, 2*(b.b-0.5)); }
    else { r.b = min(a.b, 2*b.b); }
    return r;
}
float4 Difference (float4 a, float4 b) { return (abs(a-b)); }
float4 Exclusion (float4 a, float4 b) { return (0.5-2*(a-0.5)*(b-0.5)); }
 
#endif