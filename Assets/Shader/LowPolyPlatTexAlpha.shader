﻿Shader "Custom/LowPolyPlatTexAlpha" {
	Properties {
		_UpColor("Up Color", Color) = (1,1,1,1)
		_LeftColor("Left Color", Color) = (1,0,1,1)
		_RightColor("Right Color", Color) = (1,0,0,1)

		_UpTex ("Up Albedo (RGB)", 2D) = "white" {}
		_UpTexColor ("Up Color", Color) = (1,1,1,1)

		_SideTex ("Side Albedo (RGB)", 2D) = "white" {}
		_SideTexColor ("Side Color", Color) = (1,1,1,1)
	}
	SubShader {
		Tags { "Queue"="Transparent" "RenderType"="Transparent" }

		LOD 200
		Blend SrcAlpha OneMinusSrcAlpha 
	  
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		//#pragma surface surf Standard fullforwardshadows alpha
		// #pragma surface surf Standard keepalpha alpha
		#pragma surface surf Standard alpha

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 2.0

		#define UP float3(0,1,0)
		#define RIGHT float3(1,0,0)
		#define LEFT float3(-1,0,0)

		struct Input {
			float2 uv_UpTex;
		};

		fixed4 _UpColor;
		fixed4 _LeftColor;
		fixed4 _RightColor;

		sampler2D _UpTex;
		sampler2D _SideTex;

		fixed4 _UpTexColor;
		fixed4 _SideTexColor;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			fixed4 up = tex2D (_UpTex, IN.uv_UpTex) * _UpTexColor;
			fixed4 side = tex2D (_SideTex, IN.uv_UpTex) * _SideTexColor;;
			// fixed4 sideRight = tex2D (_SideTex, IN.uv_UpTex) * _SideTexColor;

			/*
			half3 finalColor = _UpColor.rgb * max(0,dot(o.Normal, UP)) * up * _UpColor.a;
			finalColor += _LeftColor.rgb * max(0,dot(o.Normal, LEFT)) * side * _LeftColor.a;
         	finalColor += _RightColor.rgb * max(0,dot(o.Normal, RIGHT)) * sideRight * _RightColor.a;
         	*/

         	/*
			half3 finalColor = _RightColor.rgb * max(0,dot(o.Normal, RIGHT)) * _RightColor + max(0,dot(o.Normal, RIGHT))*(side*(side.a));
			finalColor += _LeftColor.rgb * max(0,dot(o.Normal, LEFT)) * _LeftColor + max(0,dot(o.Normal, LEFT))*(side*(side.a));
         	finalColor += _UpColor.rgb * max(0,dot(o.Normal, UP)) * _UpColor + max(0,dot(o.Normal, UP))*(up*(up.a));
         	*/


			half3 finalColor = _RightColor.rgb * max(0,dot(o.Normal, RIGHT)) * _RightColor*(1-side.a) + max(0,dot(o.Normal, RIGHT))*(side*(side.a));
			finalColor += _LeftColor.rgb * max(0,dot(o.Normal, LEFT)) * _LeftColor*(1-side.a) + max(0,dot(o.Normal, LEFT))*(side*(side.a));
         	finalColor += _UpColor.rgb * max(0,dot(o.Normal, UP)) * _UpColor*(1-up.a) + max(0,dot(o.Normal, UP))*(up*(up.a));
        

         	//half3 rightColor = (1-_UpAlpha) * (1,1,1,1) * (_UpAlpha) * side.rgb;
        	//finalColor += _RightColor.rgb * max(0,dot(o.Normal, RIGHT)) * rightColor * _RightColor.a;

			o.Albedo = finalColor;
			o.Alpha = 1;

			// o.Alpha = saturate((max(0,dot(o.Normal, LEFT)) * side).a+(max(0,dot(o.Normal, UP)) * up).a+(max(0,dot(o.Normal, RIGHT)) * side).a);

		}
		ENDCG             
	}
	FallBack "Diffuse"

}
