Shader "Unlit/ColoredTexture" 
{
    Properties
    {
        _MainTex ("Main Texture", 2D) = "white" { }
        _Color ("Main Color", Color) = (1.000000,1.000000,1.000000,0.000000)
    }
    SubShader
    {
        LOD 100
        Tags { "RenderType"="Opaque" }
        Pass
        {
            Tags { "RenderType"="Opaque" }
            GpuProgramID 9991
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            float4 _MainTex_ST;
            sampler2D _MainTex;
            float4 _Color;
            struct appdata_t
            {
                float4 vertex : POSITION;
                float4 texcoord0 : TEXCOORD0;
            };
            struct v2f
            {
                float2 texcoord0 : TEXCOORD0;
                float4 vertex : POSITION;
            };
            v2f vert(appdata_t v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.texcoord0 = ((v.texcoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
                return o;
            }
            float4 frag(v2f i) : SV_TARGET
            {
                float4 tmpvar_1;
                tmpvar_1 = tex2D (_MainTex, i.texcoord0);
                float4 tmpvar_2;
                tmpvar_2 = (((1.0 - _Color.w) * tmpvar_1) + (_Color.w * _Color));
                return tmpvar_2;
            }
            ENDCG
        }
    }
    
}