Shader "Custom/LowPolyPlat" {
	Properties {
		_UpColor("Up Color", Color) = (1,1,1,1)
		_LeftColor("Left Color", Color) = (1,0,1,1)
		_RightColor("Right Color", Color) = (1,0,0,1)
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

		fixed4 _UpColor;
		fixed4 _LeftColor;
		fixed4 _RightColor;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutputStandard o) {
			half3 finalColor = _RightColor.rgb * max(0,dot(o.Normal, RIGHT)) * _RightColor.a;
			finalColor += _LeftColor.rgb * max(0,dot(o.Normal, LEFT)) * _LeftColor.a;
         	finalColor += _UpColor.rgb * max(0,dot(o.Normal, UP)) * _UpColor.a;
        
			o.Albedo = finalColor;
			o.Alpha = 1;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
