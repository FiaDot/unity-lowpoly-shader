Shader "Custom/AlphaTex"
{
 Properties
 {
   	_Alpha("Alpha", Range(0,1)) = 1
  	_MainTex("Texture", 2D) = ""
 }
  
 SubShader
 {
     Tags {Queue = Transparent}
     ZWrite Off
     Lighting off
     Cull Back
     Blend SrcAlpha OneMinusSrcAlpha
      
        Pass
        {
         SetTexture[_MainTex]
         {
          ConstantColor(1, 1, 1, [_Alpha])
          Combine texture, texture * constant
         }
        }
 }
}
