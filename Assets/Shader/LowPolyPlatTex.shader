Shader "Custom/LowPolyPlatTex" {
	Properties {
		_UpColor("Up Color", Color) = (1,1,1,1)
		_LeftColor("Left Color", Color) = (1,0,1,1)
		_RightColor("Right Color", Color) = (1,0,0,1)

		_UpTex ("Up Albedo (RGB)", 2D) = "white" {}
		_SideTex ("Side Albedo (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

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

		void surf (Input IN, inout SurfaceOutputStandard o) {
			fixed4 up = tex2D (_UpTex, IN.uv_UpTex);
			fixed4 side = tex2D (_SideTex, IN.uv_UpTex);

			half3 finalColor = _UpColor.rgb * max(0,dot(o.Normal, UP)) * up * _UpColor.a;
			finalColor += _LeftColor.rgb * max(0,dot(o.Normal, LEFT)) * side * _LeftColor.a;
         	finalColor += _RightColor.rgb * max(0,dot(o.Normal, RIGHT)) * side * _RightColor.a;
        
			o.Albedo = finalColor;
			o.Alpha = 1;			 
		}
		ENDCG

	}
	FallBack "Diffuse"
}
