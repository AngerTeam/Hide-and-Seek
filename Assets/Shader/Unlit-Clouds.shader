Shader "Unlit/Clouds" {
Properties {
 _Alpha ("Alpha", Range(0.000000,1.000000)) = 0.500000
 _Color ("Main Color", Color) = (1.000000,1.000000,1.000000,0.000000)
}
SubShader { 
 LOD 100
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
  Blend SrcAlpha OneMinusSrcAlpha
CGPROGRAM
  #pragma vertex vert
  #pragma fragment frag

  float _Alpha;
  float4 _Color;

  struct appdata_t
  {
	float4 vertex : POSITION;
  };

  struct v2f
  {
	float4 vertex : POSITION;
  };

  v2f vert(appdata_t v)
  {
    v2f o;
	o.vertex = UnityObjectToClipPos(v.vertex);
    return o;
  }

  float4 frag(v2f i) : SV_TARGET
  {
    return float4(_Color.rgb, _Alpha);
  }
  ENDCG
 }
}
}