Shader "Custom/ScreenOverlay" {
   Properties {
      _MainTex ("Base (RGB)", Rect) = "white" {}
      _BlendTex("Blend Txture", 2D) = "white" {}
      _Opacity("Blend Opacity", Range(0,1)) = 1
   }
   SubShader {
      Tags { "Queue" = "Overlay" } // render after everything else
 
      Pass {
         // Blend SrcAlpha OneMinusSrcAlpha // use alpha blending
         // ZTest Always // deactivate depth test
 
         CGPROGRAM
 
         #pragma vertex vert_img
         #pragma fragment frag
         #pragma fragmentoption ARB_precision_hint_fastest 
         #include "UnityCG.cginc" 

         // User-specified uniforms
         uniform sampler2D _MainTex;
         uniform sampler2D _BlendTex;
         fixed _Opacity;


         fixed OverlayBlendMode(fixed basePixel, fixed blendPixel)
         {
         	if ( 0.5 > basePixel )
         		return (2.0 * basePixel * blendPixel);

         	return (1.0 - 2.0 * (1.0 - basePixel) * (1.0 - blendPixel));
         }

         fixed4 frag(v2f_img i) : COLOR
         {
         	fixed4 renderTex = tex2D(_MainTex, i.uv);
         	fixed4 blendTex = tex2D(_BlendTex, i.uv);

         	fixed4 blendedImage = renderTex;

         	blendedImage.r = OverlayBlendMode(renderTex.r, blendTex.r);
         	blendedImage.g = OverlayBlendMode(renderTex.g, blendTex.g);
         	blendedImage.b = OverlayBlendMode(renderTex.b, blendTex.b);

         	renderTex = lerp(renderTex, blendedImage, _Opacity);
         	return renderTex;
         }



 /*
         struct vertexInput {
            float4 vertex : POSITION;
            float4 texcoord : TEXCOORD0;
         };
         struct vertexOutput {
            float4 pos : SV_POSITION;
            float4 tex : TEXCOORD0;
         };
 
         vertexOutput vert(vertexInput input) 
         {
            vertexOutput output;
 
            float2 rasterPosition = float2(
               _X + _ScreenParams.x / 2.0 
               + _Width * (input.vertex.x + 0.5),
               _Y + _ScreenParams.y / 2.0 
               + _Height * (input.vertex.y + 0.5));
            output.pos = float4(
               2.0 * rasterPosition.x / _ScreenParams.x - 1.0,
               _ProjectionParams.x * (2.0 * rasterPosition.y / _ScreenParams.y - 1.0),
               _ProjectionParams.y, // near plane is at -1.0 or at 0.0
               1.0);
 
            output.tex = float4(input.vertex.x + 0.5, 
               input.vertex.y + 0.5, 0.0, 0.0);
               // for a cube, vertex.x and vertex.y 
               // are -0.5 or 0.5
            return output;
         }
 
         float4 frag(vertexOutput input) : COLOR
         {
            return _Color * tex2D(_MainTex, input.tex.xy);   
         }
 */
         ENDCG
      }
   }

}
