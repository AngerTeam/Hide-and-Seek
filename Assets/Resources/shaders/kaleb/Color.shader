// Upgrade NOTE: replaced 'glstate_matrix_mvp' with 'UNITY_MATRIX_MVP'

Shader "kaleb/Color" 
{
    Properties
    {
        _Color ("Color", Color) = (1.000000,1.000000,1.000000,1.000000)
    }
    SubShader
    {
        Pass
        {
            GpuProgramID 3101
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            float4 _Color;
            struct appdata_t
            {
                float4 vertex : POSITION;
            };
            struct v2f
            {
                float4 color0 : COLOR0;
                float4 vertex : POSITION;
            };
            v2f vert(appdata_t v)
            {
                v2f o;
                float4 tmpvar_1;
                float4 tmpvar_2;
                tmpvar_2 = clamp (_Color, 0.0, 1.0);
                tmpvar_1 = tmpvar_2;
                float4 tmpvar_3;
                tmpvar_3.w = 1.0;
                tmpvar_3.xyz = v.vertex.xyz;
                o.color0 = tmpvar_1;
                o.vertex = UnityObjectToClipPos(v.vertex);
                return o;
            }
            float4 frag(v2f i) : SV_TARGET
            {
                return i.color0;
            }
            ENDCG
        }
    }
    
}