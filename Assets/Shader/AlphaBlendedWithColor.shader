Shader "Custom/AlphaBlendedWithColor" {
    Properties {
        _Color2 ("Color RGBA", Color) = (1,1,1,1)
        _MainTex ("Particle Texture", 2D) = "white" {}
    }
    
    Category {
        
        Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
        Blend SrcAlpha OneMinusSrcAlpha
        //Cull Back Lighting Off ZWrite Off
        
        BindChannels {
            Bind "Color", color
            Bind "Vertex", vertex
            Bind "TexCoord", texcoord
        }
        
        SubShader {        
            Pass {
                SetTexture[_MainTex] {
                    ConstantColor [_Color2]
                    Combine Texture * constant
                }
            }
        }
    } 
}