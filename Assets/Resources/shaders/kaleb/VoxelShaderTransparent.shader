// Upgrade NOTE: replaced 'glstate_matrix_mvp' with 'UNITY_MATRIX_MVP'

Shader "kaleb/Voxel Shader Transparent" 
{
    Properties
    {
        _MainTex ("Main Texture", 2D) = "white" { }
        _MainColor ("Main Color", Color) = (1.000000,1.000000,1.000000,1.000000)
        _SkyLight ("Sky Light", Color) = (1.000000,1.000000,1.000000,0.000000)
        _AmbientLight ("Ambient Light Color", Color) = (0.200000,0.200000,0.200000,0.000000)
        _NormalPower ("Normal Power", Range(0.000000,1.000000)) = 0.200000
        _CutOut ("Cutout", Range(0.000000,1.000000)) = 0.500000
    }
    SubShader
    {
        LOD 100
        Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
        Pass
        {
            Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
            Blend SrcAlpha OneMinusSrcAlpha
            GpuProgramID 18357
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            float4 _MainTex_ST;
            float4 _SkyLight;
            float4 _AmbientLight;
            float _NormalPower;
            sampler2D _MainTex;
            float _CutOut;
            struct appdata_t
            {
                float4 vertex : POSITION;
                float4 color : COLOR;
                float3 normal : NORMAL;
                float4 texcoord0 : TEXCOORD0;
            };
            struct v2f
            {
                float4 color : COLOR;
                float2 texcoord0 : TEXCOORD0;
                float4 vertex : POSITION;
            };
            v2f vert(appdata_t v)
            {
                v2f o;
                float4 tmpvar_1;
                tmpvar_1 = v.color;
                float power_2;
                float4 lit_3;
                float4 tmpvar_4;
                lit_3 = tmpvar_1;
                float tmpvar_5;
                tmpvar_5 = min ((lit_3.x + (_SkyLight.x * lit_3.w)), 1.0);
                lit_3.x = tmpvar_5;
                float tmpvar_6;
                tmpvar_6 = min ((lit_3.y + (_SkyLight.y * lit_3.w)), 1.0);
                lit_3.y = tmpvar_6;
                float tmpvar_7;
                tmpvar_7 = min ((lit_3.z + (_SkyLight.z * lit_3.w)), 1.0);
                lit_3.z = tmpvar_7;
                float tmpvar_8;
                tmpvar_8 = max (lit_3.x, _AmbientLight.x);
                lit_3.x = tmpvar_8;
                float tmpvar_9;
                tmpvar_9 = max (lit_3.y, _AmbientLight.y);
                lit_3.y = tmpvar_9;
                float tmpvar_10;
                tmpvar_10 = max (lit_3.z, _AmbientLight.z);
                lit_3.z = tmpvar_10;
                power_2 = ((v.normal.y + 1.0) / 2.0);
                power_2 = (1.0 + ((power_2 - 1.0) * _NormalPower));
                tmpvar_4.xyz = (lit_3 * power_2).xyz;
                tmpvar_4.w = 1.0;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.color = tmpvar_4;
                o.texcoord0 = ((v.texcoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
                return o;
            }
            float4 frag(v2f i) : SV_TARGET
            {
                float4 tmpvar_1;
                tmpvar_1 = tex2D (_MainTex, i.texcoord0);
                float4 tmpvar_2;
                tmpvar_2 = (tmpvar_1 * i.color);
                if ((tmpvar_2.w < _CutOut)) {
                	discard;
				}
				return tmpvar_2;
            }
            ENDCG
        }
    }
    
}