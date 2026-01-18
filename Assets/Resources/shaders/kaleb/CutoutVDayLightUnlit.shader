Shader "kaleb/Cutout Vertex Color Unlit DayLight" {
Properties {
 _MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
 _TexBrightness ("Tex Brightness", Range(-1.000000,1.000000)) = 0.000000
 _TexContrast ("Tex Contrast", Range(0.000000,10.000000)) = 1.000000
 _TexContrastOffset ("Tex Contrast Offset", Range(0.000000,1.000000)) = 0.500000
 _SkyLight ("Sky Light", Color) = (1.000000,1.000000,1.000000,0.000000)
 _Color ("Main Color", Color) = (1.000000,1.000000,1.000000,1.000000)
 _AmbientLight ("Ambient Light", Color) = (0.200000,0.200000,0.200000,0.000000)
 _LitBrightness ("Lit Brightness", Range(-1.000000,1.000000)) = 0.000000
 _LitContrast ("Lit Contrast", Range(0.500000,2.000000)) = 1.000000
 _LitContrastOffset ("Lit Contrast Offset", Range(0.000000,1.000000)) = 0.500000
}
SubShader { 
 LOD 100
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  GpuProgramID 22348
Program "vp" {
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  mediump vec3 normal_8;
					  normal_8 = worldNormal_1;
					  mediump vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = normal_8;
					  mediump vec3 res_10;
					  mediump vec3 x_11;
					  x_11.x = dot (unity_SHAr, tmpvar_9);
					  x_11.y = dot (unity_SHAg, tmpvar_9);
					  x_11.z = dot (unity_SHAb, tmpvar_9);
					  mediump vec3 x1_12;
					  mediump vec4 tmpvar_13;
					  tmpvar_13 = (normal_8.xyzz * normal_8.yzzx);
					  x1_12.x = dot (unity_SHBr, tmpvar_13);
					  x1_12.y = dot (unity_SHBg, tmpvar_13);
					  x1_12.z = dot (unity_SHBb, tmpvar_13);
					  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
					    ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y))
					  )));
					  res_10 = max (((1.055 * 
					    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), res_10);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec4 tex_7;
					  lowp vec4 lit_8;
					  lit_8.w = xlv_COLOR0.w;
					  highp float tmpvar_9;
					  tmpvar_9 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_8.x = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_8.y = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_8.z = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = max (lit_8.x, _AmbientLight.x);
					  lit_8.x = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = max (lit_8.y, _AmbientLight.y);
					  lit_8.y = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = max (lit_8.z, _AmbientLight.z);
					  lit_8.z = tmpvar_14;
					  lit_8.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_8.xyz = (((
					    (lit_8.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_15;
					  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_7.w = tmpvar_15.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_7.xyz = (((
					    (tmpvar_15.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  lowp vec4 tmpvar_16;
					  tmpvar_16 = (tex_7 * lit_8);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_17;
					  lowp vec4 c_18;
					  lowp float diff_19;
					  mediump float tmpvar_20;
					  tmpvar_20 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_19 = tmpvar_20;
					  c_18.xyz = ((tmpvar_16.xyz * tmpvar_1) * diff_19);
					  c_18.w = 0.0;
					  c_17.w = c_18.w;
					  c_17.xyz = (c_18.xyz + (tmpvar_16.xyz * xlv_TEXCOORD3));
					  c_3.xyz = c_17.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  mediump vec3 normal_8;
					  normal_8 = worldNormal_1;
					  mediump vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = normal_8;
					  mediump vec3 res_10;
					  mediump vec3 x_11;
					  x_11.x = dot (unity_SHAr, tmpvar_9);
					  x_11.y = dot (unity_SHAg, tmpvar_9);
					  x_11.z = dot (unity_SHAb, tmpvar_9);
					  mediump vec3 x1_12;
					  mediump vec4 tmpvar_13;
					  tmpvar_13 = (normal_8.xyzz * normal_8.yzzx);
					  x1_12.x = dot (unity_SHBr, tmpvar_13);
					  x1_12.y = dot (unity_SHBg, tmpvar_13);
					  x1_12.z = dot (unity_SHBb, tmpvar_13);
					  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
					    ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y))
					  )));
					  res_10 = max (((1.055 * 
					    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), res_10);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec4 tex_7;
					  lowp vec4 lit_8;
					  lit_8.w = xlv_COLOR0.w;
					  highp float tmpvar_9;
					  tmpvar_9 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_8.x = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_8.y = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_8.z = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = max (lit_8.x, _AmbientLight.x);
					  lit_8.x = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = max (lit_8.y, _AmbientLight.y);
					  lit_8.y = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = max (lit_8.z, _AmbientLight.z);
					  lit_8.z = tmpvar_14;
					  lit_8.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_8.xyz = (((
					    (lit_8.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_15;
					  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_7.w = tmpvar_15.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_7.xyz = (((
					    (tmpvar_15.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  lowp vec4 tmpvar_16;
					  tmpvar_16 = (tex_7 * lit_8);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_17;
					  lowp vec4 c_18;
					  lowp float diff_19;
					  mediump float tmpvar_20;
					  tmpvar_20 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_19 = tmpvar_20;
					  c_18.xyz = ((tmpvar_16.xyz * tmpvar_1) * diff_19);
					  c_18.w = 0.0;
					  c_17.w = c_18.w;
					  c_17.xyz = (c_18.xyz + (tmpvar_16.xyz * xlv_TEXCOORD3));
					  c_3.xyz = c_17.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  mediump vec3 normal_8;
					  normal_8 = worldNormal_1;
					  mediump vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = normal_8;
					  mediump vec3 res_10;
					  mediump vec3 x_11;
					  x_11.x = dot (unity_SHAr, tmpvar_9);
					  x_11.y = dot (unity_SHAg, tmpvar_9);
					  x_11.z = dot (unity_SHAb, tmpvar_9);
					  mediump vec3 x1_12;
					  mediump vec4 tmpvar_13;
					  tmpvar_13 = (normal_8.xyzz * normal_8.yzzx);
					  x1_12.x = dot (unity_SHBr, tmpvar_13);
					  x1_12.y = dot (unity_SHBg, tmpvar_13);
					  x1_12.z = dot (unity_SHBb, tmpvar_13);
					  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
					    ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y))
					  )));
					  res_10 = max (((1.055 * 
					    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), res_10);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec4 tex_7;
					  lowp vec4 lit_8;
					  lit_8.w = xlv_COLOR0.w;
					  highp float tmpvar_9;
					  tmpvar_9 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_8.x = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_8.y = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_8.z = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = max (lit_8.x, _AmbientLight.x);
					  lit_8.x = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = max (lit_8.y, _AmbientLight.y);
					  lit_8.y = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = max (lit_8.z, _AmbientLight.z);
					  lit_8.z = tmpvar_14;
					  lit_8.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_8.xyz = (((
					    (lit_8.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_15;
					  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_7.w = tmpvar_15.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_7.xyz = (((
					    (tmpvar_15.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  lowp vec4 tmpvar_16;
					  tmpvar_16 = (tex_7 * lit_8);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_17;
					  lowp vec4 c_18;
					  lowp float diff_19;
					  mediump float tmpvar_20;
					  tmpvar_20 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_19 = tmpvar_20;
					  c_18.xyz = ((tmpvar_16.xyz * tmpvar_1) * diff_19);
					  c_18.w = 0.0;
					  c_17.w = c_18.w;
					  c_17.xyz = (c_18.xyz + (tmpvar_16.xyz * xlv_TEXCOORD3));
					  c_3.xyz = c_17.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat15;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat15 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat15 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat15) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat16_3.xyz = u_xlat10_2.xyz * _LightColor0.xyz;
					    u_xlat16_4.xyz = u_xlat10_2.xyz * vs_TEXCOORD3.xyz;
					    u_xlat16_18 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_18 = max(u_xlat16_18, 0.0);
					    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_18) + u_xlat16_4.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat15;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat15 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat15 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat15) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat16_3.xyz = u_xlat10_2.xyz * _LightColor0.xyz;
					    u_xlat16_4.xyz = u_xlat10_2.xyz * vs_TEXCOORD3.xyz;
					    u_xlat16_18 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_18 = max(u_xlat16_18, 0.0);
					    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_18) + u_xlat16_4.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat15;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat15 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat15 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat15) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat16_3.xyz = u_xlat10_2.xyz * _LightColor0.xyz;
					    u_xlat16_4.xyz = u_xlat10_2.xyz * vs_TEXCOORD3.xyz;
					    u_xlat16_18 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_18 = max(u_xlat16_18, 0.0);
					    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_18) + u_xlat16_4.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp vec4 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  mediump vec3 normal_8;
					  normal_8 = worldNormal_1;
					  mediump vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = normal_8;
					  mediump vec3 res_10;
					  mediump vec3 x_11;
					  x_11.x = dot (unity_SHAr, tmpvar_9);
					  x_11.y = dot (unity_SHAg, tmpvar_9);
					  x_11.z = dot (unity_SHAb, tmpvar_9);
					  mediump vec3 x1_12;
					  mediump vec4 tmpvar_13;
					  tmpvar_13 = (normal_8.xyzz * normal_8.yzzx);
					  x1_12.x = dot (unity_SHBr, tmpvar_13);
					  x1_12.y = dot (unity_SHBg, tmpvar_13);
					  x1_12.z = dot (unity_SHBb, tmpvar_13);
					  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
					    ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y))
					  )));
					  res_10 = max (((1.055 * 
					    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  highp vec4 tmpvar_14;
					  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = tmpvar_14.xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), res_10);
					  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_14);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 _LightShadowData;
					uniform lowp vec4 _LightColor0;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp vec4 xlv_TEXCOORD4;
					void main ()
					{
					  mediump float tmpvar_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 c_4;
					  lowp vec3 tmpvar_5;
					  lowp vec3 lightDir_6;
					  mediump vec3 tmpvar_7;
					  tmpvar_7 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_7;
					  tmpvar_5 = xlv_TEXCOORD1;
					  lowp vec4 tex_8;
					  lowp vec4 lit_9;
					  lit_9.w = xlv_COLOR0.w;
					  highp float tmpvar_10;
					  tmpvar_10 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_9.x = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_9.y = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_9.z = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = max (lit_9.x, _AmbientLight.x);
					  lit_9.x = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = max (lit_9.y, _AmbientLight.y);
					  lit_9.y = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = max (lit_9.z, _AmbientLight.z);
					  lit_9.z = tmpvar_15;
					  lit_9.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_9.xyz = (((
					    (lit_9.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_16;
					  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_8.w = tmpvar_16.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_8.xyz = (((
					    (tmpvar_16.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  lowp vec4 tmpvar_17;
					  tmpvar_17 = (tex_8 * lit_9);
					  lowp float tmpvar_18;
					  highp float lightShadowDataX_19;
					  mediump float tmpvar_20;
					  tmpvar_20 = _LightShadowData.x;
					  lightShadowDataX_19 = tmpvar_20;
					  highp float tmpvar_21;
					  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_19);
					  tmpvar_18 = tmpvar_21;
					  tmpvar_2 = _LightColor0.xyz;
					  tmpvar_3 = lightDir_6;
					  tmpvar_1 = tmpvar_18;
					  mediump vec3 tmpvar_22;
					  tmpvar_22 = (tmpvar_2 * tmpvar_1);
					  tmpvar_2 = tmpvar_22;
					  lowp vec4 c_23;
					  lowp vec4 c_24;
					  lowp float diff_25;
					  mediump float tmpvar_26;
					  tmpvar_26 = max (0.0, dot (tmpvar_5, tmpvar_3));
					  diff_25 = tmpvar_26;
					  c_24.xyz = ((tmpvar_17.xyz * tmpvar_22) * diff_25);
					  c_24.w = 0.0;
					  c_23.w = c_24.w;
					  c_23.xyz = (c_24.xyz + (tmpvar_17.xyz * xlv_TEXCOORD3));
					  c_4.xyz = c_23.xyz;
					  c_4.w = 1.0;
					  gl_FragData[0] = c_4;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp vec4 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  mediump vec3 normal_8;
					  normal_8 = worldNormal_1;
					  mediump vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = normal_8;
					  mediump vec3 res_10;
					  mediump vec3 x_11;
					  x_11.x = dot (unity_SHAr, tmpvar_9);
					  x_11.y = dot (unity_SHAg, tmpvar_9);
					  x_11.z = dot (unity_SHAb, tmpvar_9);
					  mediump vec3 x1_12;
					  mediump vec4 tmpvar_13;
					  tmpvar_13 = (normal_8.xyzz * normal_8.yzzx);
					  x1_12.x = dot (unity_SHBr, tmpvar_13);
					  x1_12.y = dot (unity_SHBg, tmpvar_13);
					  x1_12.z = dot (unity_SHBb, tmpvar_13);
					  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
					    ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y))
					  )));
					  res_10 = max (((1.055 * 
					    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  highp vec4 tmpvar_14;
					  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = tmpvar_14.xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), res_10);
					  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_14);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 _LightShadowData;
					uniform lowp vec4 _LightColor0;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp vec4 xlv_TEXCOORD4;
					void main ()
					{
					  mediump float tmpvar_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 c_4;
					  lowp vec3 tmpvar_5;
					  lowp vec3 lightDir_6;
					  mediump vec3 tmpvar_7;
					  tmpvar_7 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_7;
					  tmpvar_5 = xlv_TEXCOORD1;
					  lowp vec4 tex_8;
					  lowp vec4 lit_9;
					  lit_9.w = xlv_COLOR0.w;
					  highp float tmpvar_10;
					  tmpvar_10 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_9.x = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_9.y = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_9.z = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = max (lit_9.x, _AmbientLight.x);
					  lit_9.x = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = max (lit_9.y, _AmbientLight.y);
					  lit_9.y = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = max (lit_9.z, _AmbientLight.z);
					  lit_9.z = tmpvar_15;
					  lit_9.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_9.xyz = (((
					    (lit_9.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_16;
					  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_8.w = tmpvar_16.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_8.xyz = (((
					    (tmpvar_16.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  lowp vec4 tmpvar_17;
					  tmpvar_17 = (tex_8 * lit_9);
					  lowp float tmpvar_18;
					  highp float lightShadowDataX_19;
					  mediump float tmpvar_20;
					  tmpvar_20 = _LightShadowData.x;
					  lightShadowDataX_19 = tmpvar_20;
					  highp float tmpvar_21;
					  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_19);
					  tmpvar_18 = tmpvar_21;
					  tmpvar_2 = _LightColor0.xyz;
					  tmpvar_3 = lightDir_6;
					  tmpvar_1 = tmpvar_18;
					  mediump vec3 tmpvar_22;
					  tmpvar_22 = (tmpvar_2 * tmpvar_1);
					  tmpvar_2 = tmpvar_22;
					  lowp vec4 c_23;
					  lowp vec4 c_24;
					  lowp float diff_25;
					  mediump float tmpvar_26;
					  tmpvar_26 = max (0.0, dot (tmpvar_5, tmpvar_3));
					  diff_25 = tmpvar_26;
					  c_24.xyz = ((tmpvar_17.xyz * tmpvar_22) * diff_25);
					  c_24.w = 0.0;
					  c_23.w = c_24.w;
					  c_23.xyz = (c_24.xyz + (tmpvar_17.xyz * xlv_TEXCOORD3));
					  c_4.xyz = c_23.xyz;
					  c_4.w = 1.0;
					  gl_FragData[0] = c_4;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp vec4 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  mediump vec3 normal_8;
					  normal_8 = worldNormal_1;
					  mediump vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = normal_8;
					  mediump vec3 res_10;
					  mediump vec3 x_11;
					  x_11.x = dot (unity_SHAr, tmpvar_9);
					  x_11.y = dot (unity_SHAg, tmpvar_9);
					  x_11.z = dot (unity_SHAb, tmpvar_9);
					  mediump vec3 x1_12;
					  mediump vec4 tmpvar_13;
					  tmpvar_13 = (normal_8.xyzz * normal_8.yzzx);
					  x1_12.x = dot (unity_SHBr, tmpvar_13);
					  x1_12.y = dot (unity_SHBg, tmpvar_13);
					  x1_12.z = dot (unity_SHBb, tmpvar_13);
					  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
					    ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y))
					  )));
					  res_10 = max (((1.055 * 
					    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  highp vec4 tmpvar_14;
					  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = tmpvar_14.xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), res_10);
					  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_14);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 _LightShadowData;
					uniform lowp vec4 _LightColor0;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp vec4 xlv_TEXCOORD4;
					void main ()
					{
					  mediump float tmpvar_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 c_4;
					  lowp vec3 tmpvar_5;
					  lowp vec3 lightDir_6;
					  mediump vec3 tmpvar_7;
					  tmpvar_7 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_7;
					  tmpvar_5 = xlv_TEXCOORD1;
					  lowp vec4 tex_8;
					  lowp vec4 lit_9;
					  lit_9.w = xlv_COLOR0.w;
					  highp float tmpvar_10;
					  tmpvar_10 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_9.x = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_9.y = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_9.z = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = max (lit_9.x, _AmbientLight.x);
					  lit_9.x = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = max (lit_9.y, _AmbientLight.y);
					  lit_9.y = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = max (lit_9.z, _AmbientLight.z);
					  lit_9.z = tmpvar_15;
					  lit_9.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_9.xyz = (((
					    (lit_9.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_16;
					  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_8.w = tmpvar_16.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_8.xyz = (((
					    (tmpvar_16.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  lowp vec4 tmpvar_17;
					  tmpvar_17 = (tex_8 * lit_9);
					  lowp float tmpvar_18;
					  highp float lightShadowDataX_19;
					  mediump float tmpvar_20;
					  tmpvar_20 = _LightShadowData.x;
					  lightShadowDataX_19 = tmpvar_20;
					  highp float tmpvar_21;
					  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_19);
					  tmpvar_18 = tmpvar_21;
					  tmpvar_2 = _LightColor0.xyz;
					  tmpvar_3 = lightDir_6;
					  tmpvar_1 = tmpvar_18;
					  mediump vec3 tmpvar_22;
					  tmpvar_22 = (tmpvar_2 * tmpvar_1);
					  tmpvar_2 = tmpvar_22;
					  lowp vec4 c_23;
					  lowp vec4 c_24;
					  lowp float diff_25;
					  mediump float tmpvar_26;
					  tmpvar_26 = max (0.0, dot (tmpvar_5, tmpvar_3));
					  diff_25 = tmpvar_26;
					  c_24.xyz = ((tmpvar_17.xyz * tmpvar_22) * diff_25);
					  c_24.w = 0.0;
					  c_23.w = c_24.w;
					  c_23.xyz = (c_24.xyz + (tmpvar_17.xyz * xlv_TEXCOORD3));
					  c_4.xyz = c_23.xyz;
					  c_4.w = 1.0;
					  gl_FragData[0] = c_4;
					}
					
					
					#endif
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD4 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	lowp vec4 _LightColor0;
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					lowp float u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat15;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat15 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat15 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat15) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    vec3 txVec0 = vec3(vs_TEXCOORD4.xy,vs_TEXCOORD4.z);
					    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_3.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
					    u_xlat16_3.xyz = u_xlat16_3.xxx * _LightColor0.xyz;
					    u_xlat16_3.xyz = u_xlat10_2.xyz * u_xlat16_3.xyz;
					    u_xlat16_4.xyz = u_xlat10_2.xyz * vs_TEXCOORD3.xyz;
					    u_xlat16_18 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_18 = max(u_xlat16_18, 0.0);
					    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_18) + u_xlat16_4.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD4 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	lowp vec4 _LightColor0;
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					lowp float u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat15;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat15 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat15 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat15) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    vec3 txVec0 = vec3(vs_TEXCOORD4.xy,vs_TEXCOORD4.z);
					    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_3.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
					    u_xlat16_3.xyz = u_xlat16_3.xxx * _LightColor0.xyz;
					    u_xlat16_3.xyz = u_xlat10_2.xyz * u_xlat16_3.xyz;
					    u_xlat16_4.xyz = u_xlat10_2.xyz * vs_TEXCOORD3.xyz;
					    u_xlat16_18 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_18 = max(u_xlat16_18, 0.0);
					    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_18) + u_xlat16_4.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD4 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	lowp vec4 _LightColor0;
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					lowp float u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat15;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat15 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat15 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat15) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    vec3 txVec0 = vec3(vs_TEXCOORD4.xy,vs_TEXCOORD4.z);
					    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_3.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
					    u_xlat16_3.xyz = u_xlat16_3.xxx * _LightColor0.xyz;
					    u_xlat16_3.xyz = u_xlat10_2.xyz * u_xlat16_3.xyz;
					    u_xlat16_4.xyz = u_xlat10_2.xyz * vs_TEXCOORD3.xyz;
					    u_xlat16_18 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_18 = max(u_xlat16_18, 0.0);
					    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_18) + u_xlat16_4.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].x;
					  v_6.y = unity_WorldToObject[1].x;
					  v_6.z = unity_WorldToObject[2].x;
					  v_6.w = unity_WorldToObject[3].x;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].y;
					  v_7.y = unity_WorldToObject[1].y;
					  v_7.z = unity_WorldToObject[2].y;
					  v_7.w = unity_WorldToObject[3].y;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].z;
					  v_8.y = unity_WorldToObject[1].z;
					  v_8.z = unity_WorldToObject[2].z;
					  v_8.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize(((
					    (v_6.xyz * _glesNormal.x)
					   + 
					    (v_7.xyz * _glesNormal.y)
					  ) + (v_8.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_9;
					  tmpvar_2 = worldNormal_1;
					  highp vec3 lightColor0_10;
					  lightColor0_10 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_11;
					  lightColor1_11 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_12;
					  lightColor2_12 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_13;
					  lightColor3_13 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_14;
					  lightAttenSq_14 = unity_4LightAtten0;
					  highp vec3 normal_15;
					  normal_15 = worldNormal_1;
					  highp vec3 col_16;
					  highp vec4 ndotl_17;
					  highp vec4 lengthSq_18;
					  highp vec4 tmpvar_19;
					  tmpvar_19 = (unity_4LightPosX0 - tmpvar_5.x);
					  highp vec4 tmpvar_20;
					  tmpvar_20 = (unity_4LightPosY0 - tmpvar_5.y);
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (unity_4LightPosZ0 - tmpvar_5.z);
					  lengthSq_18 = (tmpvar_19 * tmpvar_19);
					  lengthSq_18 = (lengthSq_18 + (tmpvar_20 * tmpvar_20));
					  lengthSq_18 = (lengthSq_18 + (tmpvar_21 * tmpvar_21));
					  ndotl_17 = (tmpvar_19 * normal_15.x);
					  ndotl_17 = (ndotl_17 + (tmpvar_20 * normal_15.y));
					  ndotl_17 = (ndotl_17 + (tmpvar_21 * normal_15.z));
					  highp vec4 tmpvar_22;
					  tmpvar_22 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_17 * inversesqrt(lengthSq_18)));
					  ndotl_17 = tmpvar_22;
					  highp vec4 tmpvar_23;
					  tmpvar_23 = (tmpvar_22 * (1.0/((1.0 + 
					    (lengthSq_18 * lightAttenSq_14)
					  ))));
					  col_16 = (lightColor0_10 * tmpvar_23.x);
					  col_16 = (col_16 + (lightColor1_11 * tmpvar_23.y));
					  col_16 = (col_16 + (lightColor2_12 * tmpvar_23.z));
					  col_16 = (col_16 + (lightColor3_13 * tmpvar_23.w));
					  tmpvar_3 = col_16;
					  mediump vec3 normal_24;
					  normal_24 = worldNormal_1;
					  mediump vec3 ambient_25;
					  mediump vec4 tmpvar_26;
					  tmpvar_26.w = 1.0;
					  tmpvar_26.xyz = normal_24;
					  mediump vec3 res_27;
					  mediump vec3 x_28;
					  x_28.x = dot (unity_SHAr, tmpvar_26);
					  x_28.y = dot (unity_SHAg, tmpvar_26);
					  x_28.z = dot (unity_SHAb, tmpvar_26);
					  mediump vec3 x1_29;
					  mediump vec4 tmpvar_30;
					  tmpvar_30 = (normal_24.xyzz * normal_24.yzzx);
					  x1_29.x = dot (unity_SHBr, tmpvar_30);
					  x1_29.y = dot (unity_SHBg, tmpvar_30);
					  x1_29.z = dot (unity_SHBb, tmpvar_30);
					  res_27 = (x_28 + (x1_29 + (unity_SHC.xyz * 
					    ((normal_24.x * normal_24.x) - (normal_24.y * normal_24.y))
					  )));
					  res_27 = max (((1.055 * 
					    pow (max (res_27, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  ambient_25 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), res_27));
					  tmpvar_3 = ambient_25;
					  gl_Position = (glstate_matrix_mvp * tmpvar_4);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_5;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD3 = ambient_25;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec4 tex_7;
					  lowp vec4 lit_8;
					  lit_8.w = xlv_COLOR0.w;
					  highp float tmpvar_9;
					  tmpvar_9 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_8.x = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_8.y = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_8.z = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = max (lit_8.x, _AmbientLight.x);
					  lit_8.x = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = max (lit_8.y, _AmbientLight.y);
					  lit_8.y = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = max (lit_8.z, _AmbientLight.z);
					  lit_8.z = tmpvar_14;
					  lit_8.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_8.xyz = (((
					    (lit_8.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_15;
					  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_7.w = tmpvar_15.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_7.xyz = (((
					    (tmpvar_15.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  lowp vec4 tmpvar_16;
					  tmpvar_16 = (tex_7 * lit_8);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_17;
					  lowp vec4 c_18;
					  lowp float diff_19;
					  mediump float tmpvar_20;
					  tmpvar_20 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_19 = tmpvar_20;
					  c_18.xyz = ((tmpvar_16.xyz * tmpvar_1) * diff_19);
					  c_18.w = 0.0;
					  c_17.w = c_18.w;
					  c_17.xyz = (c_18.xyz + (tmpvar_16.xyz * xlv_TEXCOORD3));
					  c_3.xyz = c_17.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].x;
					  v_6.y = unity_WorldToObject[1].x;
					  v_6.z = unity_WorldToObject[2].x;
					  v_6.w = unity_WorldToObject[3].x;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].y;
					  v_7.y = unity_WorldToObject[1].y;
					  v_7.z = unity_WorldToObject[2].y;
					  v_7.w = unity_WorldToObject[3].y;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].z;
					  v_8.y = unity_WorldToObject[1].z;
					  v_8.z = unity_WorldToObject[2].z;
					  v_8.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize(((
					    (v_6.xyz * _glesNormal.x)
					   + 
					    (v_7.xyz * _glesNormal.y)
					  ) + (v_8.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_9;
					  tmpvar_2 = worldNormal_1;
					  highp vec3 lightColor0_10;
					  lightColor0_10 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_11;
					  lightColor1_11 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_12;
					  lightColor2_12 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_13;
					  lightColor3_13 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_14;
					  lightAttenSq_14 = unity_4LightAtten0;
					  highp vec3 normal_15;
					  normal_15 = worldNormal_1;
					  highp vec3 col_16;
					  highp vec4 ndotl_17;
					  highp vec4 lengthSq_18;
					  highp vec4 tmpvar_19;
					  tmpvar_19 = (unity_4LightPosX0 - tmpvar_5.x);
					  highp vec4 tmpvar_20;
					  tmpvar_20 = (unity_4LightPosY0 - tmpvar_5.y);
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (unity_4LightPosZ0 - tmpvar_5.z);
					  lengthSq_18 = (tmpvar_19 * tmpvar_19);
					  lengthSq_18 = (lengthSq_18 + (tmpvar_20 * tmpvar_20));
					  lengthSq_18 = (lengthSq_18 + (tmpvar_21 * tmpvar_21));
					  ndotl_17 = (tmpvar_19 * normal_15.x);
					  ndotl_17 = (ndotl_17 + (tmpvar_20 * normal_15.y));
					  ndotl_17 = (ndotl_17 + (tmpvar_21 * normal_15.z));
					  highp vec4 tmpvar_22;
					  tmpvar_22 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_17 * inversesqrt(lengthSq_18)));
					  ndotl_17 = tmpvar_22;
					  highp vec4 tmpvar_23;
					  tmpvar_23 = (tmpvar_22 * (1.0/((1.0 + 
					    (lengthSq_18 * lightAttenSq_14)
					  ))));
					  col_16 = (lightColor0_10 * tmpvar_23.x);
					  col_16 = (col_16 + (lightColor1_11 * tmpvar_23.y));
					  col_16 = (col_16 + (lightColor2_12 * tmpvar_23.z));
					  col_16 = (col_16 + (lightColor3_13 * tmpvar_23.w));
					  tmpvar_3 = col_16;
					  mediump vec3 normal_24;
					  normal_24 = worldNormal_1;
					  mediump vec3 ambient_25;
					  mediump vec4 tmpvar_26;
					  tmpvar_26.w = 1.0;
					  tmpvar_26.xyz = normal_24;
					  mediump vec3 res_27;
					  mediump vec3 x_28;
					  x_28.x = dot (unity_SHAr, tmpvar_26);
					  x_28.y = dot (unity_SHAg, tmpvar_26);
					  x_28.z = dot (unity_SHAb, tmpvar_26);
					  mediump vec3 x1_29;
					  mediump vec4 tmpvar_30;
					  tmpvar_30 = (normal_24.xyzz * normal_24.yzzx);
					  x1_29.x = dot (unity_SHBr, tmpvar_30);
					  x1_29.y = dot (unity_SHBg, tmpvar_30);
					  x1_29.z = dot (unity_SHBb, tmpvar_30);
					  res_27 = (x_28 + (x1_29 + (unity_SHC.xyz * 
					    ((normal_24.x * normal_24.x) - (normal_24.y * normal_24.y))
					  )));
					  res_27 = max (((1.055 * 
					    pow (max (res_27, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  ambient_25 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), res_27));
					  tmpvar_3 = ambient_25;
					  gl_Position = (glstate_matrix_mvp * tmpvar_4);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_5;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD3 = ambient_25;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec4 tex_7;
					  lowp vec4 lit_8;
					  lit_8.w = xlv_COLOR0.w;
					  highp float tmpvar_9;
					  tmpvar_9 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_8.x = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_8.y = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_8.z = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = max (lit_8.x, _AmbientLight.x);
					  lit_8.x = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = max (lit_8.y, _AmbientLight.y);
					  lit_8.y = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = max (lit_8.z, _AmbientLight.z);
					  lit_8.z = tmpvar_14;
					  lit_8.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_8.xyz = (((
					    (lit_8.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_15;
					  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_7.w = tmpvar_15.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_7.xyz = (((
					    (tmpvar_15.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  lowp vec4 tmpvar_16;
					  tmpvar_16 = (tex_7 * lit_8);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_17;
					  lowp vec4 c_18;
					  lowp float diff_19;
					  mediump float tmpvar_20;
					  tmpvar_20 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_19 = tmpvar_20;
					  c_18.xyz = ((tmpvar_16.xyz * tmpvar_1) * diff_19);
					  c_18.w = 0.0;
					  c_17.w = c_18.w;
					  c_17.xyz = (c_18.xyz + (tmpvar_16.xyz * xlv_TEXCOORD3));
					  c_3.xyz = c_17.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].x;
					  v_6.y = unity_WorldToObject[1].x;
					  v_6.z = unity_WorldToObject[2].x;
					  v_6.w = unity_WorldToObject[3].x;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].y;
					  v_7.y = unity_WorldToObject[1].y;
					  v_7.z = unity_WorldToObject[2].y;
					  v_7.w = unity_WorldToObject[3].y;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].z;
					  v_8.y = unity_WorldToObject[1].z;
					  v_8.z = unity_WorldToObject[2].z;
					  v_8.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize(((
					    (v_6.xyz * _glesNormal.x)
					   + 
					    (v_7.xyz * _glesNormal.y)
					  ) + (v_8.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_9;
					  tmpvar_2 = worldNormal_1;
					  highp vec3 lightColor0_10;
					  lightColor0_10 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_11;
					  lightColor1_11 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_12;
					  lightColor2_12 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_13;
					  lightColor3_13 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_14;
					  lightAttenSq_14 = unity_4LightAtten0;
					  highp vec3 normal_15;
					  normal_15 = worldNormal_1;
					  highp vec3 col_16;
					  highp vec4 ndotl_17;
					  highp vec4 lengthSq_18;
					  highp vec4 tmpvar_19;
					  tmpvar_19 = (unity_4LightPosX0 - tmpvar_5.x);
					  highp vec4 tmpvar_20;
					  tmpvar_20 = (unity_4LightPosY0 - tmpvar_5.y);
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (unity_4LightPosZ0 - tmpvar_5.z);
					  lengthSq_18 = (tmpvar_19 * tmpvar_19);
					  lengthSq_18 = (lengthSq_18 + (tmpvar_20 * tmpvar_20));
					  lengthSq_18 = (lengthSq_18 + (tmpvar_21 * tmpvar_21));
					  ndotl_17 = (tmpvar_19 * normal_15.x);
					  ndotl_17 = (ndotl_17 + (tmpvar_20 * normal_15.y));
					  ndotl_17 = (ndotl_17 + (tmpvar_21 * normal_15.z));
					  highp vec4 tmpvar_22;
					  tmpvar_22 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_17 * inversesqrt(lengthSq_18)));
					  ndotl_17 = tmpvar_22;
					  highp vec4 tmpvar_23;
					  tmpvar_23 = (tmpvar_22 * (1.0/((1.0 + 
					    (lengthSq_18 * lightAttenSq_14)
					  ))));
					  col_16 = (lightColor0_10 * tmpvar_23.x);
					  col_16 = (col_16 + (lightColor1_11 * tmpvar_23.y));
					  col_16 = (col_16 + (lightColor2_12 * tmpvar_23.z));
					  col_16 = (col_16 + (lightColor3_13 * tmpvar_23.w));
					  tmpvar_3 = col_16;
					  mediump vec3 normal_24;
					  normal_24 = worldNormal_1;
					  mediump vec3 ambient_25;
					  mediump vec4 tmpvar_26;
					  tmpvar_26.w = 1.0;
					  tmpvar_26.xyz = normal_24;
					  mediump vec3 res_27;
					  mediump vec3 x_28;
					  x_28.x = dot (unity_SHAr, tmpvar_26);
					  x_28.y = dot (unity_SHAg, tmpvar_26);
					  x_28.z = dot (unity_SHAb, tmpvar_26);
					  mediump vec3 x1_29;
					  mediump vec4 tmpvar_30;
					  tmpvar_30 = (normal_24.xyzz * normal_24.yzzx);
					  x1_29.x = dot (unity_SHBr, tmpvar_30);
					  x1_29.y = dot (unity_SHBg, tmpvar_30);
					  x1_29.z = dot (unity_SHBb, tmpvar_30);
					  res_27 = (x_28 + (x1_29 + (unity_SHC.xyz * 
					    ((normal_24.x * normal_24.x) - (normal_24.y * normal_24.y))
					  )));
					  res_27 = max (((1.055 * 
					    pow (max (res_27, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  ambient_25 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), res_27));
					  tmpvar_3 = ambient_25;
					  gl_Position = (glstate_matrix_mvp * tmpvar_4);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_5;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD3 = ambient_25;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec4 tex_7;
					  lowp vec4 lit_8;
					  lit_8.w = xlv_COLOR0.w;
					  highp float tmpvar_9;
					  tmpvar_9 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_8.x = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_8.y = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_8.z = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = max (lit_8.x, _AmbientLight.x);
					  lit_8.x = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = max (lit_8.y, _AmbientLight.y);
					  lit_8.y = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = max (lit_8.z, _AmbientLight.z);
					  lit_8.z = tmpvar_14;
					  lit_8.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_8.xyz = (((
					    (lit_8.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_15;
					  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_7.w = tmpvar_15.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_7.xyz = (((
					    (tmpvar_15.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  lowp vec4 tmpvar_16;
					  tmpvar_16 = (tex_7 * lit_8);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_17;
					  lowp vec4 c_18;
					  lowp float diff_19;
					  mediump float tmpvar_20;
					  tmpvar_20 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_19 = tmpvar_20;
					  c_18.xyz = ((tmpvar_16.xyz * tmpvar_1) * diff_19);
					  c_18.w = 0.0;
					  c_17.w = c_18.w;
					  c_17.xyz = (c_18.xyz + (tmpvar_16.xyz * xlv_TEXCOORD3));
					  c_3.xyz = c_17.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump vec4 u_xlat16_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_5;
					mediump vec3 u_xlat16_6;
					float u_xlat21;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat2 = (-u_xlat1.yyyy) + unity_4LightPosY0;
					    u_xlat3 = u_xlat0.yyyy * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat4 = (-u_xlat1.xxxx) + unity_4LightPosX0;
					    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
					    u_xlat3 = u_xlat4 * u_xlat0.xxxx + u_xlat3;
					    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
					    u_xlat2 = u_xlat1 * u_xlat1 + u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat0.zzzz + u_xlat3;
					    u_xlat3 = inversesqrt(u_xlat2);
					    u_xlat2 = u_xlat2 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat2 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat3;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat1 = u_xlat2 * u_xlat1;
					    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
					    u_xlat16_5.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_5.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_5.x);
					    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
					    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_5.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD3.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat15;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat15 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat15 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat15) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat16_3.xyz = u_xlat10_2.xyz * _LightColor0.xyz;
					    u_xlat16_4.xyz = u_xlat10_2.xyz * vs_TEXCOORD3.xyz;
					    u_xlat16_18 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_18 = max(u_xlat16_18, 0.0);
					    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_18) + u_xlat16_4.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump vec4 u_xlat16_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_5;
					mediump vec3 u_xlat16_6;
					float u_xlat21;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat2 = (-u_xlat1.yyyy) + unity_4LightPosY0;
					    u_xlat3 = u_xlat0.yyyy * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat4 = (-u_xlat1.xxxx) + unity_4LightPosX0;
					    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
					    u_xlat3 = u_xlat4 * u_xlat0.xxxx + u_xlat3;
					    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
					    u_xlat2 = u_xlat1 * u_xlat1 + u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat0.zzzz + u_xlat3;
					    u_xlat3 = inversesqrt(u_xlat2);
					    u_xlat2 = u_xlat2 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat2 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat3;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat1 = u_xlat2 * u_xlat1;
					    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
					    u_xlat16_5.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_5.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_5.x);
					    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
					    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_5.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD3.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat15;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat15 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat15 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat15) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat16_3.xyz = u_xlat10_2.xyz * _LightColor0.xyz;
					    u_xlat16_4.xyz = u_xlat10_2.xyz * vs_TEXCOORD3.xyz;
					    u_xlat16_18 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_18 = max(u_xlat16_18, 0.0);
					    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_18) + u_xlat16_4.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump vec4 u_xlat16_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_5;
					mediump vec3 u_xlat16_6;
					float u_xlat21;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat2 = (-u_xlat1.yyyy) + unity_4LightPosY0;
					    u_xlat3 = u_xlat0.yyyy * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat4 = (-u_xlat1.xxxx) + unity_4LightPosX0;
					    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
					    u_xlat3 = u_xlat4 * u_xlat0.xxxx + u_xlat3;
					    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
					    u_xlat2 = u_xlat1 * u_xlat1 + u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat0.zzzz + u_xlat3;
					    u_xlat3 = inversesqrt(u_xlat2);
					    u_xlat2 = u_xlat2 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat2 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat3;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat1 = u_xlat2 * u_xlat1;
					    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
					    u_xlat16_5.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_5.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_5.x);
					    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
					    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_5.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD3.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat15;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat15 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat15 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat15) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat16_3.xyz = u_xlat10_2.xyz * _LightColor0.xyz;
					    u_xlat16_4.xyz = u_xlat10_2.xyz * vs_TEXCOORD3.xyz;
					    u_xlat16_18 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_18 = max(u_xlat16_18, 0.0);
					    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_18) + u_xlat16_4.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp vec4 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  highp vec4 tmpvar_5;
					  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].x;
					  v_6.y = unity_WorldToObject[1].x;
					  v_6.z = unity_WorldToObject[2].x;
					  v_6.w = unity_WorldToObject[3].x;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].y;
					  v_7.y = unity_WorldToObject[1].y;
					  v_7.z = unity_WorldToObject[2].y;
					  v_7.w = unity_WorldToObject[3].y;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].z;
					  v_8.y = unity_WorldToObject[1].z;
					  v_8.z = unity_WorldToObject[2].z;
					  v_8.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize(((
					    (v_6.xyz * _glesNormal.x)
					   + 
					    (v_7.xyz * _glesNormal.y)
					  ) + (v_8.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_9;
					  tmpvar_2 = worldNormal_1;
					  highp vec3 lightColor0_10;
					  lightColor0_10 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_11;
					  lightColor1_11 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_12;
					  lightColor2_12 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_13;
					  lightColor3_13 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_14;
					  lightAttenSq_14 = unity_4LightAtten0;
					  highp vec3 normal_15;
					  normal_15 = worldNormal_1;
					  highp vec3 col_16;
					  highp vec4 ndotl_17;
					  highp vec4 lengthSq_18;
					  highp vec4 tmpvar_19;
					  tmpvar_19 = (unity_4LightPosX0 - tmpvar_5.x);
					  highp vec4 tmpvar_20;
					  tmpvar_20 = (unity_4LightPosY0 - tmpvar_5.y);
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (unity_4LightPosZ0 - tmpvar_5.z);
					  lengthSq_18 = (tmpvar_19 * tmpvar_19);
					  lengthSq_18 = (lengthSq_18 + (tmpvar_20 * tmpvar_20));
					  lengthSq_18 = (lengthSq_18 + (tmpvar_21 * tmpvar_21));
					  ndotl_17 = (tmpvar_19 * normal_15.x);
					  ndotl_17 = (ndotl_17 + (tmpvar_20 * normal_15.y));
					  ndotl_17 = (ndotl_17 + (tmpvar_21 * normal_15.z));
					  highp vec4 tmpvar_22;
					  tmpvar_22 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_17 * inversesqrt(lengthSq_18)));
					  ndotl_17 = tmpvar_22;
					  highp vec4 tmpvar_23;
					  tmpvar_23 = (tmpvar_22 * (1.0/((1.0 + 
					    (lengthSq_18 * lightAttenSq_14)
					  ))));
					  col_16 = (lightColor0_10 * tmpvar_23.x);
					  col_16 = (col_16 + (lightColor1_11 * tmpvar_23.y));
					  col_16 = (col_16 + (lightColor2_12 * tmpvar_23.z));
					  col_16 = (col_16 + (lightColor3_13 * tmpvar_23.w));
					  tmpvar_3 = col_16;
					  mediump vec3 normal_24;
					  normal_24 = worldNormal_1;
					  mediump vec3 ambient_25;
					  mediump vec4 tmpvar_26;
					  tmpvar_26.w = 1.0;
					  tmpvar_26.xyz = normal_24;
					  mediump vec3 res_27;
					  mediump vec3 x_28;
					  x_28.x = dot (unity_SHAr, tmpvar_26);
					  x_28.y = dot (unity_SHAg, tmpvar_26);
					  x_28.z = dot (unity_SHAb, tmpvar_26);
					  mediump vec3 x1_29;
					  mediump vec4 tmpvar_30;
					  tmpvar_30 = (normal_24.xyzz * normal_24.yzzx);
					  x1_29.x = dot (unity_SHBr, tmpvar_30);
					  x1_29.y = dot (unity_SHBg, tmpvar_30);
					  x1_29.z = dot (unity_SHBb, tmpvar_30);
					  res_27 = (x_28 + (x1_29 + (unity_SHC.xyz * 
					    ((normal_24.x * normal_24.x) - (normal_24.y * normal_24.y))
					  )));
					  res_27 = max (((1.055 * 
					    pow (max (res_27, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  ambient_25 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), res_27));
					  tmpvar_3 = ambient_25;
					  gl_Position = (glstate_matrix_mvp * tmpvar_4);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_5.xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD3 = ambient_25;
					  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_5);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 _LightShadowData;
					uniform lowp vec4 _LightColor0;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp vec4 xlv_TEXCOORD4;
					void main ()
					{
					  mediump float tmpvar_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 c_4;
					  lowp vec3 tmpvar_5;
					  lowp vec3 lightDir_6;
					  mediump vec3 tmpvar_7;
					  tmpvar_7 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_7;
					  tmpvar_5 = xlv_TEXCOORD1;
					  lowp vec4 tex_8;
					  lowp vec4 lit_9;
					  lit_9.w = xlv_COLOR0.w;
					  highp float tmpvar_10;
					  tmpvar_10 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_9.x = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_9.y = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_9.z = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = max (lit_9.x, _AmbientLight.x);
					  lit_9.x = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = max (lit_9.y, _AmbientLight.y);
					  lit_9.y = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = max (lit_9.z, _AmbientLight.z);
					  lit_9.z = tmpvar_15;
					  lit_9.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_9.xyz = (((
					    (lit_9.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_16;
					  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_8.w = tmpvar_16.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_8.xyz = (((
					    (tmpvar_16.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  lowp vec4 tmpvar_17;
					  tmpvar_17 = (tex_8 * lit_9);
					  lowp float tmpvar_18;
					  highp float lightShadowDataX_19;
					  mediump float tmpvar_20;
					  tmpvar_20 = _LightShadowData.x;
					  lightShadowDataX_19 = tmpvar_20;
					  highp float tmpvar_21;
					  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_19);
					  tmpvar_18 = tmpvar_21;
					  tmpvar_2 = _LightColor0.xyz;
					  tmpvar_3 = lightDir_6;
					  tmpvar_1 = tmpvar_18;
					  mediump vec3 tmpvar_22;
					  tmpvar_22 = (tmpvar_2 * tmpvar_1);
					  tmpvar_2 = tmpvar_22;
					  lowp vec4 c_23;
					  lowp vec4 c_24;
					  lowp float diff_25;
					  mediump float tmpvar_26;
					  tmpvar_26 = max (0.0, dot (tmpvar_5, tmpvar_3));
					  diff_25 = tmpvar_26;
					  c_24.xyz = ((tmpvar_17.xyz * tmpvar_22) * diff_25);
					  c_24.w = 0.0;
					  c_23.w = c_24.w;
					  c_23.xyz = (c_24.xyz + (tmpvar_17.xyz * xlv_TEXCOORD3));
					  c_4.xyz = c_23.xyz;
					  c_4.w = 1.0;
					  gl_FragData[0] = c_4;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp vec4 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  highp vec4 tmpvar_5;
					  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].x;
					  v_6.y = unity_WorldToObject[1].x;
					  v_6.z = unity_WorldToObject[2].x;
					  v_6.w = unity_WorldToObject[3].x;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].y;
					  v_7.y = unity_WorldToObject[1].y;
					  v_7.z = unity_WorldToObject[2].y;
					  v_7.w = unity_WorldToObject[3].y;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].z;
					  v_8.y = unity_WorldToObject[1].z;
					  v_8.z = unity_WorldToObject[2].z;
					  v_8.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize(((
					    (v_6.xyz * _glesNormal.x)
					   + 
					    (v_7.xyz * _glesNormal.y)
					  ) + (v_8.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_9;
					  tmpvar_2 = worldNormal_1;
					  highp vec3 lightColor0_10;
					  lightColor0_10 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_11;
					  lightColor1_11 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_12;
					  lightColor2_12 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_13;
					  lightColor3_13 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_14;
					  lightAttenSq_14 = unity_4LightAtten0;
					  highp vec3 normal_15;
					  normal_15 = worldNormal_1;
					  highp vec3 col_16;
					  highp vec4 ndotl_17;
					  highp vec4 lengthSq_18;
					  highp vec4 tmpvar_19;
					  tmpvar_19 = (unity_4LightPosX0 - tmpvar_5.x);
					  highp vec4 tmpvar_20;
					  tmpvar_20 = (unity_4LightPosY0 - tmpvar_5.y);
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (unity_4LightPosZ0 - tmpvar_5.z);
					  lengthSq_18 = (tmpvar_19 * tmpvar_19);
					  lengthSq_18 = (lengthSq_18 + (tmpvar_20 * tmpvar_20));
					  lengthSq_18 = (lengthSq_18 + (tmpvar_21 * tmpvar_21));
					  ndotl_17 = (tmpvar_19 * normal_15.x);
					  ndotl_17 = (ndotl_17 + (tmpvar_20 * normal_15.y));
					  ndotl_17 = (ndotl_17 + (tmpvar_21 * normal_15.z));
					  highp vec4 tmpvar_22;
					  tmpvar_22 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_17 * inversesqrt(lengthSq_18)));
					  ndotl_17 = tmpvar_22;
					  highp vec4 tmpvar_23;
					  tmpvar_23 = (tmpvar_22 * (1.0/((1.0 + 
					    (lengthSq_18 * lightAttenSq_14)
					  ))));
					  col_16 = (lightColor0_10 * tmpvar_23.x);
					  col_16 = (col_16 + (lightColor1_11 * tmpvar_23.y));
					  col_16 = (col_16 + (lightColor2_12 * tmpvar_23.z));
					  col_16 = (col_16 + (lightColor3_13 * tmpvar_23.w));
					  tmpvar_3 = col_16;
					  mediump vec3 normal_24;
					  normal_24 = worldNormal_1;
					  mediump vec3 ambient_25;
					  mediump vec4 tmpvar_26;
					  tmpvar_26.w = 1.0;
					  tmpvar_26.xyz = normal_24;
					  mediump vec3 res_27;
					  mediump vec3 x_28;
					  x_28.x = dot (unity_SHAr, tmpvar_26);
					  x_28.y = dot (unity_SHAg, tmpvar_26);
					  x_28.z = dot (unity_SHAb, tmpvar_26);
					  mediump vec3 x1_29;
					  mediump vec4 tmpvar_30;
					  tmpvar_30 = (normal_24.xyzz * normal_24.yzzx);
					  x1_29.x = dot (unity_SHBr, tmpvar_30);
					  x1_29.y = dot (unity_SHBg, tmpvar_30);
					  x1_29.z = dot (unity_SHBb, tmpvar_30);
					  res_27 = (x_28 + (x1_29 + (unity_SHC.xyz * 
					    ((normal_24.x * normal_24.x) - (normal_24.y * normal_24.y))
					  )));
					  res_27 = max (((1.055 * 
					    pow (max (res_27, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  ambient_25 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), res_27));
					  tmpvar_3 = ambient_25;
					  gl_Position = (glstate_matrix_mvp * tmpvar_4);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_5.xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD3 = ambient_25;
					  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_5);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 _LightShadowData;
					uniform lowp vec4 _LightColor0;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp vec4 xlv_TEXCOORD4;
					void main ()
					{
					  mediump float tmpvar_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 c_4;
					  lowp vec3 tmpvar_5;
					  lowp vec3 lightDir_6;
					  mediump vec3 tmpvar_7;
					  tmpvar_7 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_7;
					  tmpvar_5 = xlv_TEXCOORD1;
					  lowp vec4 tex_8;
					  lowp vec4 lit_9;
					  lit_9.w = xlv_COLOR0.w;
					  highp float tmpvar_10;
					  tmpvar_10 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_9.x = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_9.y = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_9.z = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = max (lit_9.x, _AmbientLight.x);
					  lit_9.x = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = max (lit_9.y, _AmbientLight.y);
					  lit_9.y = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = max (lit_9.z, _AmbientLight.z);
					  lit_9.z = tmpvar_15;
					  lit_9.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_9.xyz = (((
					    (lit_9.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_16;
					  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_8.w = tmpvar_16.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_8.xyz = (((
					    (tmpvar_16.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  lowp vec4 tmpvar_17;
					  tmpvar_17 = (tex_8 * lit_9);
					  lowp float tmpvar_18;
					  highp float lightShadowDataX_19;
					  mediump float tmpvar_20;
					  tmpvar_20 = _LightShadowData.x;
					  lightShadowDataX_19 = tmpvar_20;
					  highp float tmpvar_21;
					  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_19);
					  tmpvar_18 = tmpvar_21;
					  tmpvar_2 = _LightColor0.xyz;
					  tmpvar_3 = lightDir_6;
					  tmpvar_1 = tmpvar_18;
					  mediump vec3 tmpvar_22;
					  tmpvar_22 = (tmpvar_2 * tmpvar_1);
					  tmpvar_2 = tmpvar_22;
					  lowp vec4 c_23;
					  lowp vec4 c_24;
					  lowp float diff_25;
					  mediump float tmpvar_26;
					  tmpvar_26 = max (0.0, dot (tmpvar_5, tmpvar_3));
					  diff_25 = tmpvar_26;
					  c_24.xyz = ((tmpvar_17.xyz * tmpvar_22) * diff_25);
					  c_24.w = 0.0;
					  c_23.w = c_24.w;
					  c_23.xyz = (c_24.xyz + (tmpvar_17.xyz * xlv_TEXCOORD3));
					  c_4.xyz = c_23.xyz;
					  c_4.w = 1.0;
					  gl_FragData[0] = c_4;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp vec4 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  highp vec4 tmpvar_5;
					  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].x;
					  v_6.y = unity_WorldToObject[1].x;
					  v_6.z = unity_WorldToObject[2].x;
					  v_6.w = unity_WorldToObject[3].x;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].y;
					  v_7.y = unity_WorldToObject[1].y;
					  v_7.z = unity_WorldToObject[2].y;
					  v_7.w = unity_WorldToObject[3].y;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].z;
					  v_8.y = unity_WorldToObject[1].z;
					  v_8.z = unity_WorldToObject[2].z;
					  v_8.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize(((
					    (v_6.xyz * _glesNormal.x)
					   + 
					    (v_7.xyz * _glesNormal.y)
					  ) + (v_8.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_9;
					  tmpvar_2 = worldNormal_1;
					  highp vec3 lightColor0_10;
					  lightColor0_10 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_11;
					  lightColor1_11 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_12;
					  lightColor2_12 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_13;
					  lightColor3_13 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_14;
					  lightAttenSq_14 = unity_4LightAtten0;
					  highp vec3 normal_15;
					  normal_15 = worldNormal_1;
					  highp vec3 col_16;
					  highp vec4 ndotl_17;
					  highp vec4 lengthSq_18;
					  highp vec4 tmpvar_19;
					  tmpvar_19 = (unity_4LightPosX0 - tmpvar_5.x);
					  highp vec4 tmpvar_20;
					  tmpvar_20 = (unity_4LightPosY0 - tmpvar_5.y);
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (unity_4LightPosZ0 - tmpvar_5.z);
					  lengthSq_18 = (tmpvar_19 * tmpvar_19);
					  lengthSq_18 = (lengthSq_18 + (tmpvar_20 * tmpvar_20));
					  lengthSq_18 = (lengthSq_18 + (tmpvar_21 * tmpvar_21));
					  ndotl_17 = (tmpvar_19 * normal_15.x);
					  ndotl_17 = (ndotl_17 + (tmpvar_20 * normal_15.y));
					  ndotl_17 = (ndotl_17 + (tmpvar_21 * normal_15.z));
					  highp vec4 tmpvar_22;
					  tmpvar_22 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_17 * inversesqrt(lengthSq_18)));
					  ndotl_17 = tmpvar_22;
					  highp vec4 tmpvar_23;
					  tmpvar_23 = (tmpvar_22 * (1.0/((1.0 + 
					    (lengthSq_18 * lightAttenSq_14)
					  ))));
					  col_16 = (lightColor0_10 * tmpvar_23.x);
					  col_16 = (col_16 + (lightColor1_11 * tmpvar_23.y));
					  col_16 = (col_16 + (lightColor2_12 * tmpvar_23.z));
					  col_16 = (col_16 + (lightColor3_13 * tmpvar_23.w));
					  tmpvar_3 = col_16;
					  mediump vec3 normal_24;
					  normal_24 = worldNormal_1;
					  mediump vec3 ambient_25;
					  mediump vec4 tmpvar_26;
					  tmpvar_26.w = 1.0;
					  tmpvar_26.xyz = normal_24;
					  mediump vec3 res_27;
					  mediump vec3 x_28;
					  x_28.x = dot (unity_SHAr, tmpvar_26);
					  x_28.y = dot (unity_SHAg, tmpvar_26);
					  x_28.z = dot (unity_SHAb, tmpvar_26);
					  mediump vec3 x1_29;
					  mediump vec4 tmpvar_30;
					  tmpvar_30 = (normal_24.xyzz * normal_24.yzzx);
					  x1_29.x = dot (unity_SHBr, tmpvar_30);
					  x1_29.y = dot (unity_SHBg, tmpvar_30);
					  x1_29.z = dot (unity_SHBb, tmpvar_30);
					  res_27 = (x_28 + (x1_29 + (unity_SHC.xyz * 
					    ((normal_24.x * normal_24.x) - (normal_24.y * normal_24.y))
					  )));
					  res_27 = max (((1.055 * 
					    pow (max (res_27, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  ambient_25 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), res_27));
					  tmpvar_3 = ambient_25;
					  gl_Position = (glstate_matrix_mvp * tmpvar_4);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_5.xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD3 = ambient_25;
					  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_5);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 _LightShadowData;
					uniform lowp vec4 _LightColor0;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD3;
					varying highp vec4 xlv_TEXCOORD4;
					void main ()
					{
					  mediump float tmpvar_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 c_4;
					  lowp vec3 tmpvar_5;
					  lowp vec3 lightDir_6;
					  mediump vec3 tmpvar_7;
					  tmpvar_7 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_7;
					  tmpvar_5 = xlv_TEXCOORD1;
					  lowp vec4 tex_8;
					  lowp vec4 lit_9;
					  lit_9.w = xlv_COLOR0.w;
					  highp float tmpvar_10;
					  tmpvar_10 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_9.x = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_9.y = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_9.z = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = max (lit_9.x, _AmbientLight.x);
					  lit_9.x = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = max (lit_9.y, _AmbientLight.y);
					  lit_9.y = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = max (lit_9.z, _AmbientLight.z);
					  lit_9.z = tmpvar_15;
					  lit_9.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_9.xyz = (((
					    (lit_9.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_16;
					  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_8.w = tmpvar_16.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_8.xyz = (((
					    (tmpvar_16.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  lowp vec4 tmpvar_17;
					  tmpvar_17 = (tex_8 * lit_9);
					  lowp float tmpvar_18;
					  highp float lightShadowDataX_19;
					  mediump float tmpvar_20;
					  tmpvar_20 = _LightShadowData.x;
					  lightShadowDataX_19 = tmpvar_20;
					  highp float tmpvar_21;
					  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_19);
					  tmpvar_18 = tmpvar_21;
					  tmpvar_2 = _LightColor0.xyz;
					  tmpvar_3 = lightDir_6;
					  tmpvar_1 = tmpvar_18;
					  mediump vec3 tmpvar_22;
					  tmpvar_22 = (tmpvar_2 * tmpvar_1);
					  tmpvar_2 = tmpvar_22;
					  lowp vec4 c_23;
					  lowp vec4 c_24;
					  lowp float diff_25;
					  mediump float tmpvar_26;
					  tmpvar_26 = max (0.0, dot (tmpvar_5, tmpvar_3));
					  diff_25 = tmpvar_26;
					  c_24.xyz = ((tmpvar_17.xyz * tmpvar_22) * diff_25);
					  c_24.w = 0.0;
					  c_23.w = c_24.w;
					  c_23.xyz = (c_24.xyz + (tmpvar_17.xyz * xlv_TEXCOORD3));
					  c_4.xyz = c_23.xyz;
					  c_4.w = 1.0;
					  gl_FragData[0] = c_4;
					}
					
					
					#endif
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump vec4 u_xlat16_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_5;
					mediump vec3 u_xlat16_6;
					float u_xlat21;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat2 = (-u_xlat1.yyyy) + unity_4LightPosY0;
					    u_xlat3 = u_xlat0.yyyy * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat4 = (-u_xlat1.xxxx) + unity_4LightPosX0;
					    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
					    u_xlat3 = u_xlat4 * u_xlat0.xxxx + u_xlat3;
					    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
					    u_xlat2 = u_xlat1 * u_xlat1 + u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat0.zzzz + u_xlat3;
					    u_xlat3 = inversesqrt(u_xlat2);
					    u_xlat2 = u_xlat2 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat2 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat3;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat1 = u_xlat2 * u_xlat1;
					    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
					    u_xlat16_5.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_5.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_5.x);
					    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
					    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_5.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD3.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD4 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	lowp vec4 _LightColor0;
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					lowp float u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat15;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat15 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat15 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat15) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    vec3 txVec0 = vec3(vs_TEXCOORD4.xy,vs_TEXCOORD4.z);
					    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_3.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
					    u_xlat16_3.xyz = u_xlat16_3.xxx * _LightColor0.xyz;
					    u_xlat16_3.xyz = u_xlat10_2.xyz * u_xlat16_3.xyz;
					    u_xlat16_4.xyz = u_xlat10_2.xyz * vs_TEXCOORD3.xyz;
					    u_xlat16_18 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_18 = max(u_xlat16_18, 0.0);
					    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_18) + u_xlat16_4.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump vec4 u_xlat16_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_5;
					mediump vec3 u_xlat16_6;
					float u_xlat21;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat2 = (-u_xlat1.yyyy) + unity_4LightPosY0;
					    u_xlat3 = u_xlat0.yyyy * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat4 = (-u_xlat1.xxxx) + unity_4LightPosX0;
					    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
					    u_xlat3 = u_xlat4 * u_xlat0.xxxx + u_xlat3;
					    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
					    u_xlat2 = u_xlat1 * u_xlat1 + u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat0.zzzz + u_xlat3;
					    u_xlat3 = inversesqrt(u_xlat2);
					    u_xlat2 = u_xlat2 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat2 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat3;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat1 = u_xlat2 * u_xlat1;
					    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
					    u_xlat16_5.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_5.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_5.x);
					    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
					    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_5.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD3.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD4 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	lowp vec4 _LightColor0;
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					lowp float u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat15;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat15 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat15 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat15) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    vec3 txVec0 = vec3(vs_TEXCOORD4.xy,vs_TEXCOORD4.z);
					    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_3.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
					    u_xlat16_3.xyz = u_xlat16_3.xxx * _LightColor0.xyz;
					    u_xlat16_3.xyz = u_xlat10_2.xyz * u_xlat16_3.xyz;
					    u_xlat16_4.xyz = u_xlat10_2.xyz * vs_TEXCOORD3.xyz;
					    u_xlat16_18 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_18 = max(u_xlat16_18, 0.0);
					    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_18) + u_xlat16_4.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump vec4 u_xlat16_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_5;
					mediump vec3 u_xlat16_6;
					float u_xlat21;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat2 = (-u_xlat1.yyyy) + unity_4LightPosY0;
					    u_xlat3 = u_xlat0.yyyy * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat4 = (-u_xlat1.xxxx) + unity_4LightPosX0;
					    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
					    u_xlat3 = u_xlat4 * u_xlat0.xxxx + u_xlat3;
					    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
					    u_xlat2 = u_xlat1 * u_xlat1 + u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat0.zzzz + u_xlat3;
					    u_xlat3 = inversesqrt(u_xlat2);
					    u_xlat2 = u_xlat2 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat2 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat3;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat1 = u_xlat2 * u_xlat1;
					    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
					    u_xlat16_5.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_5.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_5.x);
					    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
					    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_5.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD3.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD4 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	lowp vec4 _LightColor0;
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					lowp float u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat15;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat15 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat15 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat15) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    vec3 txVec0 = vec3(vs_TEXCOORD4.xy,vs_TEXCOORD4.z);
					    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_3.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
					    u_xlat16_3.xyz = u_xlat16_3.xxx * _LightColor0.xyz;
					    u_xlat16_3.xyz = u_xlat10_2.xyz * u_xlat16_3.xyz;
					    u_xlat16_4.xyz = u_xlat10_2.xyz * vs_TEXCOORD3.xyz;
					    u_xlat16_18 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_18 = max(u_xlat16_18, 0.0);
					    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_18) + u_xlat16_4.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif
}
}
Program "fp" {
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
}
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "RenderType"="Opaque" }
  ZWrite Off
  Blend One One
  GpuProgramID 108846
Program "vp" {
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec4 tex_7;
					  lowp vec4 lit_8;
					  lit_8.w = xlv_COLOR0.w;
					  highp float tmpvar_9;
					  tmpvar_9 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_8.x = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_8.y = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_8.z = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = max (lit_8.x, _AmbientLight.x);
					  lit_8.x = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = max (lit_8.y, _AmbientLight.y);
					  lit_8.y = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = max (lit_8.z, _AmbientLight.z);
					  lit_8.z = tmpvar_14;
					  lit_8.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_8.xyz = (((
					    (lit_8.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_15;
					  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_7.w = tmpvar_15.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_7.xyz = (((
					    (tmpvar_15.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  highp vec4 tmpvar_16;
					  tmpvar_16.w = 1.0;
					  tmpvar_16.xyz = xlv_TEXCOORD2;
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (unity_WorldToLight * tmpvar_16).xyz;
					  highp float tmpvar_18;
					  tmpvar_18 = dot (tmpvar_17, tmpvar_17);
					  lowp float tmpvar_19;
					  tmpvar_19 = texture2D (_LightTexture0, vec2(tmpvar_18)).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  tmpvar_1 = (tmpvar_1 * tmpvar_19);
					  lowp vec4 c_20;
					  lowp vec4 c_21;
					  lowp float diff_22;
					  mediump float tmpvar_23;
					  tmpvar_23 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_22 = tmpvar_23;
					  c_21.xyz = (((tex_7 * lit_8).xyz * tmpvar_1) * diff_22);
					  c_21.w = 0.0;
					  c_20.w = c_21.w;
					  c_20.xyz = c_21.xyz;
					  c_3.xyz = c_20.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec4 tex_7;
					  lowp vec4 lit_8;
					  lit_8.w = xlv_COLOR0.w;
					  highp float tmpvar_9;
					  tmpvar_9 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_8.x = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_8.y = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_8.z = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = max (lit_8.x, _AmbientLight.x);
					  lit_8.x = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = max (lit_8.y, _AmbientLight.y);
					  lit_8.y = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = max (lit_8.z, _AmbientLight.z);
					  lit_8.z = tmpvar_14;
					  lit_8.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_8.xyz = (((
					    (lit_8.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_15;
					  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_7.w = tmpvar_15.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_7.xyz = (((
					    (tmpvar_15.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  highp vec4 tmpvar_16;
					  tmpvar_16.w = 1.0;
					  tmpvar_16.xyz = xlv_TEXCOORD2;
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (unity_WorldToLight * tmpvar_16).xyz;
					  highp float tmpvar_18;
					  tmpvar_18 = dot (tmpvar_17, tmpvar_17);
					  lowp float tmpvar_19;
					  tmpvar_19 = texture2D (_LightTexture0, vec2(tmpvar_18)).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  tmpvar_1 = (tmpvar_1 * tmpvar_19);
					  lowp vec4 c_20;
					  lowp vec4 c_21;
					  lowp float diff_22;
					  mediump float tmpvar_23;
					  tmpvar_23 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_22 = tmpvar_23;
					  c_21.xyz = (((tex_7 * lit_8).xyz * tmpvar_1) * diff_22);
					  c_21.w = 0.0;
					  c_20.w = c_21.w;
					  c_20.xyz = c_21.xyz;
					  c_3.xyz = c_20.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {
Keywords { "POINT" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec4 tex_7;
					  lowp vec4 lit_8;
					  lit_8.w = xlv_COLOR0.w;
					  highp float tmpvar_9;
					  tmpvar_9 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_8.x = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_8.y = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_8.z = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = max (lit_8.x, _AmbientLight.x);
					  lit_8.x = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = max (lit_8.y, _AmbientLight.y);
					  lit_8.y = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = max (lit_8.z, _AmbientLight.z);
					  lit_8.z = tmpvar_14;
					  lit_8.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_8.xyz = (((
					    (lit_8.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_15;
					  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_7.w = tmpvar_15.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_7.xyz = (((
					    (tmpvar_15.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  highp vec4 tmpvar_16;
					  tmpvar_16.w = 1.0;
					  tmpvar_16.xyz = xlv_TEXCOORD2;
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (unity_WorldToLight * tmpvar_16).xyz;
					  highp float tmpvar_18;
					  tmpvar_18 = dot (tmpvar_17, tmpvar_17);
					  lowp float tmpvar_19;
					  tmpvar_19 = texture2D (_LightTexture0, vec2(tmpvar_18)).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  tmpvar_1 = (tmpvar_1 * tmpvar_19);
					  lowp vec4 c_20;
					  lowp vec4 c_21;
					  lowp float diff_22;
					  mediump float tmpvar_23;
					  tmpvar_23 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_22 = tmpvar_23;
					  c_21.xyz = (((tex_7 * lit_8).xyz * tmpvar_1) * diff_22);
					  c_21.w = 0.0;
					  c_20.w = c_21.w;
					  c_20.xyz = c_21.xyz;
					  c_3.xyz = c_20.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	vec4 hlslcc_mtx4unity_WorldToLight[4];
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _LightTexture0;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					lowp float u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					mediump float u_xlat16_15;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat12 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat12 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4unity_WorldToLight[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4unity_WorldToLight[3].xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat10_0 = texture(_LightTexture0, u_xlat0.xx).w;
					    u_xlat16_3.xyz = vec3(u_xlat10_0) * _LightColor0.xyz;
					    u_xlat16_3.xyz = u_xlat10_2.xyz * u_xlat16_3.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat16_15 = max(u_xlat16_15, 0.0);
					    u_xlat16_3.xyz = vec3(u_xlat16_15) * u_xlat16_3.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	vec4 hlslcc_mtx4unity_WorldToLight[4];
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _LightTexture0;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					lowp float u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					mediump float u_xlat16_15;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat12 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat12 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4unity_WorldToLight[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4unity_WorldToLight[3].xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat10_0 = texture(_LightTexture0, u_xlat0.xx).w;
					    u_xlat16_3.xyz = vec3(u_xlat10_0) * _LightColor0.xyz;
					    u_xlat16_3.xyz = u_xlat10_2.xyz * u_xlat16_3.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat16_15 = max(u_xlat16_15, 0.0);
					    u_xlat16_3.xyz = vec3(u_xlat16_15) * u_xlat16_3.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier03 " {
Keywords { "POINT" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	vec4 hlslcc_mtx4unity_WorldToLight[4];
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _LightTexture0;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					lowp float u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					mediump float u_xlat16_15;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat12 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat12 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4unity_WorldToLight[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4unity_WorldToLight[3].xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat10_0 = texture(_LightTexture0, u_xlat0.xx).w;
					    u_xlat16_3.xyz = vec3(u_xlat10_0) * _LightColor0.xyz;
					    u_xlat16_3.xyz = u_xlat10_2.xyz * u_xlat16_3.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat16_15 = max(u_xlat16_15, 0.0);
					    u_xlat16_3.xyz = vec3(u_xlat16_15) * u_xlat16_3.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec4 tex_7;
					  lowp vec4 lit_8;
					  lit_8.w = xlv_COLOR0.w;
					  highp float tmpvar_9;
					  tmpvar_9 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_8.x = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_8.y = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_8.z = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = max (lit_8.x, _AmbientLight.x);
					  lit_8.x = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = max (lit_8.y, _AmbientLight.y);
					  lit_8.y = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = max (lit_8.z, _AmbientLight.z);
					  lit_8.z = tmpvar_14;
					  lit_8.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_8.xyz = (((
					    (lit_8.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_15;
					  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_7.w = tmpvar_15.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_7.xyz = (((
					    (tmpvar_15.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_16;
					  lowp vec4 c_17;
					  lowp float diff_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_18 = tmpvar_19;
					  c_17.xyz = (((tex_7 * lit_8).xyz * tmpvar_1) * diff_18);
					  c_17.w = 0.0;
					  c_16.w = c_17.w;
					  c_16.xyz = c_17.xyz;
					  c_3.xyz = c_16.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec4 tex_7;
					  lowp vec4 lit_8;
					  lit_8.w = xlv_COLOR0.w;
					  highp float tmpvar_9;
					  tmpvar_9 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_8.x = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_8.y = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_8.z = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = max (lit_8.x, _AmbientLight.x);
					  lit_8.x = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = max (lit_8.y, _AmbientLight.y);
					  lit_8.y = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = max (lit_8.z, _AmbientLight.z);
					  lit_8.z = tmpvar_14;
					  lit_8.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_8.xyz = (((
					    (lit_8.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_15;
					  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_7.w = tmpvar_15.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_7.xyz = (((
					    (tmpvar_15.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_16;
					  lowp vec4 c_17;
					  lowp float diff_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_18 = tmpvar_19;
					  c_17.xyz = (((tex_7 * lit_8).xyz * tmpvar_1) * diff_18);
					  c_17.w = 0.0;
					  c_16.w = c_17.w;
					  c_16.xyz = c_17.xyz;
					  c_3.xyz = c_16.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec4 tex_7;
					  lowp vec4 lit_8;
					  lit_8.w = xlv_COLOR0.w;
					  highp float tmpvar_9;
					  tmpvar_9 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_8.x = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_8.y = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_8.z = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = max (lit_8.x, _AmbientLight.x);
					  lit_8.x = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = max (lit_8.y, _AmbientLight.y);
					  lit_8.y = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = max (lit_8.z, _AmbientLight.z);
					  lit_8.z = tmpvar_14;
					  lit_8.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_8.xyz = (((
					    (lit_8.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_15;
					  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_7.w = tmpvar_15.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_7.xyz = (((
					    (tmpvar_15.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  lowp vec4 c_16;
					  lowp vec4 c_17;
					  lowp float diff_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_18 = tmpvar_19;
					  c_17.xyz = (((tex_7 * lit_8).xyz * tmpvar_1) * diff_18);
					  c_17.w = 0.0;
					  c_16.w = c_17.w;
					  c_16.xyz = c_17.xyz;
					  c_3.xyz = c_16.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					mediump float u_xlat16_15;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat12 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat12 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat16_3.xyz = u_xlat10_2.xyz * _LightColor0.xyz;
					    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_15 = max(u_xlat16_15, 0.0);
					    u_xlat16_3.xyz = vec3(u_xlat16_15) * u_xlat16_3.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					mediump float u_xlat16_15;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat12 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat12 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat16_3.xyz = u_xlat10_2.xyz * _LightColor0.xyz;
					    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_15 = max(u_xlat16_15, 0.0);
					    u_xlat16_3.xyz = vec3(u_xlat16_15) * u_xlat16_3.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					mediump float u_xlat16_15;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat12 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat12 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat16_3.xyz = u_xlat10_2.xyz * _LightColor0.xyz;
					    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_15 = max(u_xlat16_15, 0.0);
					    u_xlat16_3.xyz = vec3(u_xlat16_15) * u_xlat16_3.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp float atten_4;
					  lowp vec3 tmpvar_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_6 = tmpvar_7;
					  tmpvar_5 = xlv_TEXCOORD1;
					  lowp vec4 tex_8;
					  lowp vec4 lit_9;
					  lit_9.w = xlv_COLOR0.w;
					  highp float tmpvar_10;
					  tmpvar_10 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_9.x = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_9.y = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_9.z = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = max (lit_9.x, _AmbientLight.x);
					  lit_9.x = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = max (lit_9.y, _AmbientLight.y);
					  lit_9.y = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = max (lit_9.z, _AmbientLight.z);
					  lit_9.z = tmpvar_15;
					  lit_9.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_9.xyz = (((
					    (lit_9.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_16;
					  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_8.w = tmpvar_16.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_8.xyz = (((
					    (tmpvar_16.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  highp vec4 tmpvar_17;
					  tmpvar_17.w = 1.0;
					  tmpvar_17.xyz = xlv_TEXCOORD2;
					  highp vec4 tmpvar_18;
					  tmpvar_18 = (unity_WorldToLight * tmpvar_17);
					  lowp vec4 tmpvar_19;
					  highp vec2 P_20;
					  P_20 = ((tmpvar_18.xy / tmpvar_18.w) + 0.5);
					  tmpvar_19 = texture2D (_LightTexture0, P_20);
					  highp float tmpvar_21;
					  tmpvar_21 = dot (tmpvar_18.xyz, tmpvar_18.xyz);
					  lowp vec4 tmpvar_22;
					  tmpvar_22 = texture2D (_LightTextureB0, vec2(tmpvar_21));
					  highp float tmpvar_23;
					  tmpvar_23 = ((float(
					    (tmpvar_18.z > 0.0)
					  ) * tmpvar_19.w) * tmpvar_22.w);
					  atten_4 = tmpvar_23;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * atten_4);
					  lowp vec4 c_24;
					  lowp vec4 c_25;
					  lowp float diff_26;
					  mediump float tmpvar_27;
					  tmpvar_27 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_26 = tmpvar_27;
					  c_25.xyz = (((tex_8 * lit_9).xyz * tmpvar_1) * diff_26);
					  c_25.w = 0.0;
					  c_24.w = c_25.w;
					  c_24.xyz = c_25.xyz;
					  c_3.xyz = c_24.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp float atten_4;
					  lowp vec3 tmpvar_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_6 = tmpvar_7;
					  tmpvar_5 = xlv_TEXCOORD1;
					  lowp vec4 tex_8;
					  lowp vec4 lit_9;
					  lit_9.w = xlv_COLOR0.w;
					  highp float tmpvar_10;
					  tmpvar_10 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_9.x = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_9.y = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_9.z = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = max (lit_9.x, _AmbientLight.x);
					  lit_9.x = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = max (lit_9.y, _AmbientLight.y);
					  lit_9.y = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = max (lit_9.z, _AmbientLight.z);
					  lit_9.z = tmpvar_15;
					  lit_9.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_9.xyz = (((
					    (lit_9.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_16;
					  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_8.w = tmpvar_16.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_8.xyz = (((
					    (tmpvar_16.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  highp vec4 tmpvar_17;
					  tmpvar_17.w = 1.0;
					  tmpvar_17.xyz = xlv_TEXCOORD2;
					  highp vec4 tmpvar_18;
					  tmpvar_18 = (unity_WorldToLight * tmpvar_17);
					  lowp vec4 tmpvar_19;
					  highp vec2 P_20;
					  P_20 = ((tmpvar_18.xy / tmpvar_18.w) + 0.5);
					  tmpvar_19 = texture2D (_LightTexture0, P_20);
					  highp float tmpvar_21;
					  tmpvar_21 = dot (tmpvar_18.xyz, tmpvar_18.xyz);
					  lowp vec4 tmpvar_22;
					  tmpvar_22 = texture2D (_LightTextureB0, vec2(tmpvar_21));
					  highp float tmpvar_23;
					  tmpvar_23 = ((float(
					    (tmpvar_18.z > 0.0)
					  ) * tmpvar_19.w) * tmpvar_22.w);
					  atten_4 = tmpvar_23;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * atten_4);
					  lowp vec4 c_24;
					  lowp vec4 c_25;
					  lowp float diff_26;
					  mediump float tmpvar_27;
					  tmpvar_27 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_26 = tmpvar_27;
					  c_25.xyz = (((tex_8 * lit_9).xyz * tmpvar_1) * diff_26);
					  c_25.w = 0.0;
					  c_24.w = c_25.w;
					  c_24.xyz = c_25.xyz;
					  c_3.xyz = c_24.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {
Keywords { "SPOT" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp float atten_4;
					  lowp vec3 tmpvar_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_6 = tmpvar_7;
					  tmpvar_5 = xlv_TEXCOORD1;
					  lowp vec4 tex_8;
					  lowp vec4 lit_9;
					  lit_9.w = xlv_COLOR0.w;
					  highp float tmpvar_10;
					  tmpvar_10 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_9.x = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_9.y = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_9.z = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = max (lit_9.x, _AmbientLight.x);
					  lit_9.x = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = max (lit_9.y, _AmbientLight.y);
					  lit_9.y = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = max (lit_9.z, _AmbientLight.z);
					  lit_9.z = tmpvar_15;
					  lit_9.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_9.xyz = (((
					    (lit_9.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_16;
					  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_8.w = tmpvar_16.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_8.xyz = (((
					    (tmpvar_16.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  highp vec4 tmpvar_17;
					  tmpvar_17.w = 1.0;
					  tmpvar_17.xyz = xlv_TEXCOORD2;
					  highp vec4 tmpvar_18;
					  tmpvar_18 = (unity_WorldToLight * tmpvar_17);
					  lowp vec4 tmpvar_19;
					  highp vec2 P_20;
					  P_20 = ((tmpvar_18.xy / tmpvar_18.w) + 0.5);
					  tmpvar_19 = texture2D (_LightTexture0, P_20);
					  highp float tmpvar_21;
					  tmpvar_21 = dot (tmpvar_18.xyz, tmpvar_18.xyz);
					  lowp vec4 tmpvar_22;
					  tmpvar_22 = texture2D (_LightTextureB0, vec2(tmpvar_21));
					  highp float tmpvar_23;
					  tmpvar_23 = ((float(
					    (tmpvar_18.z > 0.0)
					  ) * tmpvar_19.w) * tmpvar_22.w);
					  atten_4 = tmpvar_23;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * atten_4);
					  lowp vec4 c_24;
					  lowp vec4 c_25;
					  lowp float diff_26;
					  mediump float tmpvar_27;
					  tmpvar_27 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_26 = tmpvar_27;
					  c_25.xyz = (((tex_8 * lit_9).xyz * tmpvar_1) * diff_26);
					  c_25.w = 0.0;
					  c_24.w = c_25.w;
					  c_24.xyz = c_25.xyz;
					  c_3.xyz = c_24.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPOT" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	vec4 hlslcc_mtx4unity_WorldToLight[4];
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _LightTexture0;
					uniform lowp sampler2D _LightTextureB0;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp float u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					bool u_xlatb1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					lowp float u_xlat10_12;
					mediump float u_xlat16_15;
					void main()
					{
					    u_xlat0 = vs_TEXCOORD2.yyyy * hlslcc_mtx4unity_WorldToLight[1];
					    u_xlat0 = hlslcc_mtx4unity_WorldToLight[0] * vs_TEXCOORD2.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_WorldToLight[2] * vs_TEXCOORD2.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4unity_WorldToLight[3];
					    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
					    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
					    u_xlat10_12 = texture(_LightTexture0, u_xlat1.xy).w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(0.0<u_xlat0.z);
					#else
					    u_xlatb1 = 0.0<u_xlat0.z;
					#endif
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat10_0 = texture(_LightTextureB0, u_xlat0.xx).w;
					    u_xlat10_2.x = (u_xlatb1) ? 1.0 : 0.0;
					    u_xlat10_2.x = u_xlat10_12 * u_xlat10_2.x;
					    u_xlat10_2.x = u_xlat10_0 * u_xlat10_2.x;
					    u_xlat16_3.xyz = u_xlat10_2.xxx * _LightColor0.xyz;
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat12 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat12 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_2.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat16_15 = max(u_xlat16_15, 0.0);
					    u_xlat16_3.xyz = vec3(u_xlat16_15) * u_xlat16_3.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPOT" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	vec4 hlslcc_mtx4unity_WorldToLight[4];
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _LightTexture0;
					uniform lowp sampler2D _LightTextureB0;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp float u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					bool u_xlatb1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					lowp float u_xlat10_12;
					mediump float u_xlat16_15;
					void main()
					{
					    u_xlat0 = vs_TEXCOORD2.yyyy * hlslcc_mtx4unity_WorldToLight[1];
					    u_xlat0 = hlslcc_mtx4unity_WorldToLight[0] * vs_TEXCOORD2.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_WorldToLight[2] * vs_TEXCOORD2.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4unity_WorldToLight[3];
					    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
					    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
					    u_xlat10_12 = texture(_LightTexture0, u_xlat1.xy).w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(0.0<u_xlat0.z);
					#else
					    u_xlatb1 = 0.0<u_xlat0.z;
					#endif
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat10_0 = texture(_LightTextureB0, u_xlat0.xx).w;
					    u_xlat10_2.x = (u_xlatb1) ? 1.0 : 0.0;
					    u_xlat10_2.x = u_xlat10_12 * u_xlat10_2.x;
					    u_xlat10_2.x = u_xlat10_0 * u_xlat10_2.x;
					    u_xlat16_3.xyz = u_xlat10_2.xxx * _LightColor0.xyz;
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat12 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat12 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_2.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat16_15 = max(u_xlat16_15, 0.0);
					    u_xlat16_3.xyz = vec3(u_xlat16_15) * u_xlat16_3.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier03 " {
Keywords { "SPOT" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	vec4 hlslcc_mtx4unity_WorldToLight[4];
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _LightTexture0;
					uniform lowp sampler2D _LightTextureB0;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp float u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					bool u_xlatb1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					lowp float u_xlat10_12;
					mediump float u_xlat16_15;
					void main()
					{
					    u_xlat0 = vs_TEXCOORD2.yyyy * hlslcc_mtx4unity_WorldToLight[1];
					    u_xlat0 = hlslcc_mtx4unity_WorldToLight[0] * vs_TEXCOORD2.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_WorldToLight[2] * vs_TEXCOORD2.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4unity_WorldToLight[3];
					    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
					    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
					    u_xlat10_12 = texture(_LightTexture0, u_xlat1.xy).w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(0.0<u_xlat0.z);
					#else
					    u_xlatb1 = 0.0<u_xlat0.z;
					#endif
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat10_0 = texture(_LightTextureB0, u_xlat0.xx).w;
					    u_xlat10_2.x = (u_xlatb1) ? 1.0 : 0.0;
					    u_xlat10_2.x = u_xlat10_12 * u_xlat10_2.x;
					    u_xlat10_2.x = u_xlat10_0 * u_xlat10_2.x;
					    u_xlat16_3.xyz = u_xlat10_2.xxx * _LightColor0.xyz;
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat12 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat12 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat10_2.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat16_15 = max(u_xlat16_15, 0.0);
					    u_xlat16_3.xyz = vec3(u_xlat16_15) * u_xlat16_3.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp samplerCube _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec4 tex_7;
					  lowp vec4 lit_8;
					  lit_8.w = xlv_COLOR0.w;
					  highp float tmpvar_9;
					  tmpvar_9 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_8.x = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_8.y = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_8.z = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = max (lit_8.x, _AmbientLight.x);
					  lit_8.x = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = max (lit_8.y, _AmbientLight.y);
					  lit_8.y = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = max (lit_8.z, _AmbientLight.z);
					  lit_8.z = tmpvar_14;
					  lit_8.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_8.xyz = (((
					    (lit_8.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_15;
					  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_7.w = tmpvar_15.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_7.xyz = (((
					    (tmpvar_15.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  highp vec4 tmpvar_16;
					  tmpvar_16.w = 1.0;
					  tmpvar_16.xyz = xlv_TEXCOORD2;
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (unity_WorldToLight * tmpvar_16).xyz;
					  highp float tmpvar_18;
					  tmpvar_18 = dot (tmpvar_17, tmpvar_17);
					  lowp float tmpvar_19;
					  tmpvar_19 = (texture2D (_LightTextureB0, vec2(tmpvar_18)).w * textureCube (_LightTexture0, tmpvar_17).w);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  tmpvar_1 = (tmpvar_1 * tmpvar_19);
					  lowp vec4 c_20;
					  lowp vec4 c_21;
					  lowp float diff_22;
					  mediump float tmpvar_23;
					  tmpvar_23 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_22 = tmpvar_23;
					  c_21.xyz = (((tex_7 * lit_8).xyz * tmpvar_1) * diff_22);
					  c_21.w = 0.0;
					  c_20.w = c_21.w;
					  c_20.xyz = c_21.xyz;
					  c_3.xyz = c_20.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp samplerCube _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec4 tex_7;
					  lowp vec4 lit_8;
					  lit_8.w = xlv_COLOR0.w;
					  highp float tmpvar_9;
					  tmpvar_9 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_8.x = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_8.y = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_8.z = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = max (lit_8.x, _AmbientLight.x);
					  lit_8.x = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = max (lit_8.y, _AmbientLight.y);
					  lit_8.y = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = max (lit_8.z, _AmbientLight.z);
					  lit_8.z = tmpvar_14;
					  lit_8.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_8.xyz = (((
					    (lit_8.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_15;
					  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_7.w = tmpvar_15.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_7.xyz = (((
					    (tmpvar_15.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  highp vec4 tmpvar_16;
					  tmpvar_16.w = 1.0;
					  tmpvar_16.xyz = xlv_TEXCOORD2;
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (unity_WorldToLight * tmpvar_16).xyz;
					  highp float tmpvar_18;
					  tmpvar_18 = dot (tmpvar_17, tmpvar_17);
					  lowp float tmpvar_19;
					  tmpvar_19 = (texture2D (_LightTextureB0, vec2(tmpvar_18)).w * textureCube (_LightTexture0, tmpvar_17).w);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  tmpvar_1 = (tmpvar_1 * tmpvar_19);
					  lowp vec4 c_20;
					  lowp vec4 c_21;
					  lowp float diff_22;
					  mediump float tmpvar_23;
					  tmpvar_23 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_22 = tmpvar_23;
					  c_21.xyz = (((tex_7 * lit_8).xyz * tmpvar_1) * diff_22);
					  c_21.w = 0.0;
					  c_20.w = c_21.w;
					  c_20.xyz = c_21.xyz;
					  c_3.xyz = c_20.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {
Keywords { "POINT_COOKIE" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp samplerCube _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec4 tex_7;
					  lowp vec4 lit_8;
					  lit_8.w = xlv_COLOR0.w;
					  highp float tmpvar_9;
					  tmpvar_9 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_8.x = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_8.y = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_8.z = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = max (lit_8.x, _AmbientLight.x);
					  lit_8.x = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = max (lit_8.y, _AmbientLight.y);
					  lit_8.y = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = max (lit_8.z, _AmbientLight.z);
					  lit_8.z = tmpvar_14;
					  lit_8.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_8.xyz = (((
					    (lit_8.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_15;
					  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_7.w = tmpvar_15.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_7.xyz = (((
					    (tmpvar_15.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  highp vec4 tmpvar_16;
					  tmpvar_16.w = 1.0;
					  tmpvar_16.xyz = xlv_TEXCOORD2;
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (unity_WorldToLight * tmpvar_16).xyz;
					  highp float tmpvar_18;
					  tmpvar_18 = dot (tmpvar_17, tmpvar_17);
					  lowp float tmpvar_19;
					  tmpvar_19 = (texture2D (_LightTextureB0, vec2(tmpvar_18)).w * textureCube (_LightTexture0, tmpvar_17).w);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  tmpvar_1 = (tmpvar_1 * tmpvar_19);
					  lowp vec4 c_20;
					  lowp vec4 c_21;
					  lowp float diff_22;
					  mediump float tmpvar_23;
					  tmpvar_23 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_22 = tmpvar_23;
					  c_21.xyz = (((tex_7 * lit_8).xyz * tmpvar_1) * diff_22);
					  c_21.w = 0.0;
					  c_20.w = c_21.w;
					  c_20.xyz = c_21.xyz;
					  c_3.xyz = c_20.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT_COOKIE" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	vec4 hlslcc_mtx4unity_WorldToLight[4];
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _LightTextureB0;
					uniform lowp samplerCube _LightTexture0;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump float u_xlat16_0;
					lowp float u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					lowp float u_xlat10_4;
					float u_xlat12;
					mediump float u_xlat16_15;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat12 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat12 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4unity_WorldToLight[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4unity_WorldToLight[3].xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat10_0 = texture(_LightTexture0, u_xlat0.xyz).w;
					    u_xlat10_4 = texture(_LightTextureB0, vec2(u_xlat12)).w;
					    u_xlat16_0 = u_xlat10_0 * u_xlat10_4;
					    u_xlat16_3.xyz = vec3(u_xlat16_0) * _LightColor0.xyz;
					    u_xlat16_3.xyz = u_xlat10_2.xyz * u_xlat16_3.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat16_15 = max(u_xlat16_15, 0.0);
					    u_xlat16_3.xyz = vec3(u_xlat16_15) * u_xlat16_3.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT_COOKIE" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	vec4 hlslcc_mtx4unity_WorldToLight[4];
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _LightTextureB0;
					uniform lowp samplerCube _LightTexture0;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump float u_xlat16_0;
					lowp float u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					lowp float u_xlat10_4;
					float u_xlat12;
					mediump float u_xlat16_15;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat12 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat12 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4unity_WorldToLight[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4unity_WorldToLight[3].xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat10_0 = texture(_LightTexture0, u_xlat0.xyz).w;
					    u_xlat10_4 = texture(_LightTextureB0, vec2(u_xlat12)).w;
					    u_xlat16_0 = u_xlat10_0 * u_xlat10_4;
					    u_xlat16_3.xyz = vec3(u_xlat16_0) * _LightColor0.xyz;
					    u_xlat16_3.xyz = u_xlat10_2.xyz * u_xlat16_3.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat16_15 = max(u_xlat16_15, 0.0);
					    u_xlat16_3.xyz = vec3(u_xlat16_15) * u_xlat16_3.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier03 " {
Keywords { "POINT_COOKIE" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	vec4 hlslcc_mtx4unity_WorldToLight[4];
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _LightTextureB0;
					uniform lowp samplerCube _LightTexture0;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump float u_xlat16_0;
					lowp float u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					lowp float u_xlat10_4;
					float u_xlat12;
					mediump float u_xlat16_15;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat12 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat12 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4unity_WorldToLight[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4unity_WorldToLight[3].xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat10_0 = texture(_LightTexture0, u_xlat0.xyz).w;
					    u_xlat10_4 = texture(_LightTextureB0, vec2(u_xlat12)).w;
					    u_xlat16_0 = u_xlat10_0 * u_xlat10_4;
					    u_xlat16_3.xyz = vec3(u_xlat16_0) * _LightColor0.xyz;
					    u_xlat16_3.xyz = u_xlat10_2.xyz * u_xlat16_3.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat16_15 = max(u_xlat16_15, 0.0);
					    u_xlat16_3.xyz = vec3(u_xlat16_15) * u_xlat16_3.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec4 tex_7;
					  lowp vec4 lit_8;
					  lit_8.w = xlv_COLOR0.w;
					  highp float tmpvar_9;
					  tmpvar_9 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_8.x = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_8.y = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_8.z = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = max (lit_8.x, _AmbientLight.x);
					  lit_8.x = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = max (lit_8.y, _AmbientLight.y);
					  lit_8.y = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = max (lit_8.z, _AmbientLight.z);
					  lit_8.z = tmpvar_14;
					  lit_8.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_8.xyz = (((
					    (lit_8.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_15;
					  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_7.w = tmpvar_15.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_7.xyz = (((
					    (tmpvar_15.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  highp vec4 tmpvar_16;
					  tmpvar_16.w = 1.0;
					  tmpvar_16.xyz = xlv_TEXCOORD2;
					  highp vec2 tmpvar_17;
					  tmpvar_17 = (unity_WorldToLight * tmpvar_16).xy;
					  lowp float tmpvar_18;
					  tmpvar_18 = texture2D (_LightTexture0, tmpvar_17).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  tmpvar_1 = (tmpvar_1 * tmpvar_18);
					  lowp vec4 c_19;
					  lowp vec4 c_20;
					  lowp float diff_21;
					  mediump float tmpvar_22;
					  tmpvar_22 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_21 = tmpvar_22;
					  c_20.xyz = (((tex_7 * lit_8).xyz * tmpvar_1) * diff_21);
					  c_20.w = 0.0;
					  c_19.w = c_20.w;
					  c_19.xyz = c_20.xyz;
					  c_3.xyz = c_19.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec4 tex_7;
					  lowp vec4 lit_8;
					  lit_8.w = xlv_COLOR0.w;
					  highp float tmpvar_9;
					  tmpvar_9 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_8.x = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_8.y = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_8.z = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = max (lit_8.x, _AmbientLight.x);
					  lit_8.x = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = max (lit_8.y, _AmbientLight.y);
					  lit_8.y = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = max (lit_8.z, _AmbientLight.z);
					  lit_8.z = tmpvar_14;
					  lit_8.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_8.xyz = (((
					    (lit_8.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_15;
					  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_7.w = tmpvar_15.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_7.xyz = (((
					    (tmpvar_15.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  highp vec4 tmpvar_16;
					  tmpvar_16.w = 1.0;
					  tmpvar_16.xyz = xlv_TEXCOORD2;
					  highp vec2 tmpvar_17;
					  tmpvar_17 = (unity_WorldToLight * tmpvar_16).xy;
					  lowp float tmpvar_18;
					  tmpvar_18 = texture2D (_LightTexture0, tmpvar_17).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  tmpvar_1 = (tmpvar_1 * tmpvar_18);
					  lowp vec4 c_19;
					  lowp vec4 c_20;
					  lowp float diff_21;
					  mediump float tmpvar_22;
					  tmpvar_22 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_21 = tmpvar_22;
					  c_20.xyz = (((tex_7 * lit_8).xyz * tmpvar_1) * diff_21);
					  c_20.w = 0.0;
					  c_19.w = c_20.w;
					  c_19.xyz = c_20.xyz;
					  c_3.xyz = c_19.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL_COOKIE" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec4 c_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 lightDir_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_5 = tmpvar_6;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec4 tex_7;
					  lowp vec4 lit_8;
					  lit_8.w = xlv_COLOR0.w;
					  highp float tmpvar_9;
					  tmpvar_9 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_8.x = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_8.y = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_8.z = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = max (lit_8.x, _AmbientLight.x);
					  lit_8.x = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = max (lit_8.y, _AmbientLight.y);
					  lit_8.y = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = max (lit_8.z, _AmbientLight.z);
					  lit_8.z = tmpvar_14;
					  lit_8.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_8.xyz = (((
					    (lit_8.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_15;
					  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_7.w = tmpvar_15.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_7.xyz = (((
					    (tmpvar_15.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  highp vec4 tmpvar_16;
					  tmpvar_16.w = 1.0;
					  tmpvar_16.xyz = xlv_TEXCOORD2;
					  highp vec2 tmpvar_17;
					  tmpvar_17 = (unity_WorldToLight * tmpvar_16).xy;
					  lowp float tmpvar_18;
					  tmpvar_18 = texture2D (_LightTexture0, tmpvar_17).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  tmpvar_1 = (tmpvar_1 * tmpvar_18);
					  lowp vec4 c_19;
					  lowp vec4 c_20;
					  lowp float diff_21;
					  mediump float tmpvar_22;
					  tmpvar_22 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_21 = tmpvar_22;
					  c_20.xyz = (((tex_7 * lit_8).xyz * tmpvar_1) * diff_21);
					  c_20.w = 0.0;
					  c_19.w = c_20.w;
					  c_19.xyz = c_20.xyz;
					  c_3.xyz = c_19.xyz;
					  c_3.w = 1.0;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	vec4 hlslcc_mtx4unity_WorldToLight[4];
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _LightTexture0;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					lowp float u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					mediump float u_xlat16_15;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat12 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat12 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xy = vs_TEXCOORD2.yy * hlslcc_mtx4unity_WorldToLight[1].xy;
					    u_xlat0.xy = hlslcc_mtx4unity_WorldToLight[0].xy * vs_TEXCOORD2.xx + u_xlat0.xy;
					    u_xlat0.xy = hlslcc_mtx4unity_WorldToLight[2].xy * vs_TEXCOORD2.zz + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4unity_WorldToLight[3].xy;
					    u_xlat10_0 = texture(_LightTexture0, u_xlat0.xy).w;
					    u_xlat16_3.xyz = vec3(u_xlat10_0) * _LightColor0.xyz;
					    u_xlat16_3.xyz = u_xlat10_2.xyz * u_xlat16_3.xyz;
					    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_15 = max(u_xlat16_15, 0.0);
					    u_xlat16_3.xyz = vec3(u_xlat16_15) * u_xlat16_3.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	vec4 hlslcc_mtx4unity_WorldToLight[4];
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _LightTexture0;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					lowp float u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					mediump float u_xlat16_15;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat12 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat12 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xy = vs_TEXCOORD2.yy * hlslcc_mtx4unity_WorldToLight[1].xy;
					    u_xlat0.xy = hlslcc_mtx4unity_WorldToLight[0].xy * vs_TEXCOORD2.xx + u_xlat0.xy;
					    u_xlat0.xy = hlslcc_mtx4unity_WorldToLight[2].xy * vs_TEXCOORD2.zz + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4unity_WorldToLight[3].xy;
					    u_xlat10_0 = texture(_LightTexture0, u_xlat0.xy).w;
					    u_xlat16_3.xyz = vec3(u_xlat10_0) * _LightColor0.xyz;
					    u_xlat16_3.xyz = u_xlat10_2.xyz * u_xlat16_3.xyz;
					    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_15 = max(u_xlat16_15, 0.0);
					    u_xlat16_3.xyz = vec3(u_xlat16_15) * u_xlat16_3.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL_COOKIE" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	vec4 hlslcc_mtx4unity_WorldToLight[4];
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _LightTexture0;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					lowp float u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					mediump float u_xlat16_15;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat12 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat12 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xy = vs_TEXCOORD2.yy * hlslcc_mtx4unity_WorldToLight[1].xy;
					    u_xlat0.xy = hlslcc_mtx4unity_WorldToLight[0].xy * vs_TEXCOORD2.xx + u_xlat0.xy;
					    u_xlat0.xy = hlslcc_mtx4unity_WorldToLight[2].xy * vs_TEXCOORD2.zz + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4unity_WorldToLight[3].xy;
					    u_xlat10_0 = texture(_LightTexture0, u_xlat0.xy).w;
					    u_xlat16_3.xyz = vec3(u_xlat10_0) * _LightColor0.xyz;
					    u_xlat16_3.xyz = u_xlat10_2.xyz * u_xlat16_3.xyz;
					    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_15 = max(u_xlat16_15, 0.0);
					    u_xlat16_3.xyz = vec3(u_xlat16_15) * u_xlat16_3.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif
}
}
Program "fp" {
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
					
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
					
}
SubProgram "gles hw_tier03 " {
Keywords { "POINT" }
					
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT" }
					
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT" }
					
}
SubProgram "gles3 hw_tier03 " {
Keywords { "POINT" }
					
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
					
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
					
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" }
					
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" }
					
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" }
					
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" }
					
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" }
					
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
					
}
SubProgram "gles hw_tier03 " {
Keywords { "SPOT" }
					
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPOT" }
					
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPOT" }
					
}
SubProgram "gles3 hw_tier03 " {
Keywords { "SPOT" }
					
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" }
					
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" }
					
}
SubProgram "gles hw_tier03 " {
Keywords { "POINT_COOKIE" }
					
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT_COOKIE" }
					
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT_COOKIE" }
					
}
SubProgram "gles3 hw_tier03 " {
Keywords { "POINT_COOKIE" }
					
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
					
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
					
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL_COOKIE" }
					
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
					
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
					
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL_COOKIE" }
					
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassBase" "RenderType"="Opaque" }
  GpuProgramID 163328
Program "vp" {
SubProgram "gles hw_tier01 " {

					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					varying mediump vec3 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					varying mediump vec3 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 res_1;
					  lowp vec3 tmpvar_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3.x = 1.0;
					  tmpvar_2 = xlv_TEXCOORD0;
					  lowp vec4 lit_4;
					  lit_4.w = tmpvar_3.w;
					  highp float tmpvar_5;
					  tmpvar_5 = max (1.0, (_SkyLight.x * tmpvar_3.w));
					  lit_4.x = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = max (tmpvar_3.y, (_SkyLight.y * tmpvar_3.w));
					  lit_4.y = tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = max (tmpvar_3.z, (_SkyLight.z * tmpvar_3.w));
					  lit_4.z = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = max (lit_4.x, _AmbientLight.x);
					  lit_4.x = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = max (lit_4.y, _AmbientLight.y);
					  lit_4.y = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = max (lit_4.z, _AmbientLight.z);
					  lit_4.z = tmpvar_10;
					  lit_4.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_4.xyz = (((
					    (lit_4.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  res_1.xyz = ((tmpvar_2 * 0.5) + 0.5);
					  res_1.w = 0.0;
					  gl_FragData[0] = res_1;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {

					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					varying mediump vec3 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					varying mediump vec3 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 res_1;
					  lowp vec3 tmpvar_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3.x = 1.0;
					  tmpvar_2 = xlv_TEXCOORD0;
					  lowp vec4 lit_4;
					  lit_4.w = tmpvar_3.w;
					  highp float tmpvar_5;
					  tmpvar_5 = max (1.0, (_SkyLight.x * tmpvar_3.w));
					  lit_4.x = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = max (tmpvar_3.y, (_SkyLight.y * tmpvar_3.w));
					  lit_4.y = tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = max (tmpvar_3.z, (_SkyLight.z * tmpvar_3.w));
					  lit_4.z = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = max (lit_4.x, _AmbientLight.x);
					  lit_4.x = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = max (lit_4.y, _AmbientLight.y);
					  lit_4.y = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = max (lit_4.z, _AmbientLight.z);
					  lit_4.z = tmpvar_10;
					  lit_4.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_4.xyz = (((
					    (lit_4.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  res_1.xyz = ((tmpvar_2 * 0.5) + 0.5);
					  res_1.w = 0.0;
					  gl_FragData[0] = res_1;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {

					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					varying mediump vec3 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					varying mediump vec3 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 res_1;
					  lowp vec3 tmpvar_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3.x = 1.0;
					  tmpvar_2 = xlv_TEXCOORD0;
					  lowp vec4 lit_4;
					  lit_4.w = tmpvar_3.w;
					  highp float tmpvar_5;
					  tmpvar_5 = max (1.0, (_SkyLight.x * tmpvar_3.w));
					  lit_4.x = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = max (tmpvar_3.y, (_SkyLight.y * tmpvar_3.w));
					  lit_4.y = tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = max (tmpvar_3.z, (_SkyLight.z * tmpvar_3.w));
					  lit_4.z = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = max (lit_4.x, _AmbientLight.x);
					  lit_4.x = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = max (lit_4.y, _AmbientLight.y);
					  lit_4.y = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = max (lit_4.z, _AmbientLight.z);
					  lit_4.z = tmpvar_10;
					  lit_4.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_4.xyz = (((
					    (lit_4.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  res_1.xyz = ((tmpvar_2 * 0.5) + 0.5);
					  res_1.w = 0.0;
					  gl_FragData[0] = res_1;
					}
					
					
					#endif
}
SubProgram "gles3 hw_tier01 " {

					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out mediump vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					in mediump vec3 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					void main()
					{
					    SV_Target0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target0.w = 0.0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier02 " {

					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out mediump vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					in mediump vec3 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					void main()
					{
					    SV_Target0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target0.w = 0.0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier03 " {

					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					out mediump vec3 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					in mediump vec3 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					void main()
					{
					    SV_Target0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target0.w = 0.0;
					    return;
					}
					#endif
}
}
Program "fp" {
SubProgram "gles hw_tier01 " {

}
SubProgram "gles hw_tier02 " {

}
SubProgram "gles hw_tier03 " {

}
SubProgram "gles3 hw_tier01 " {

}
SubProgram "gles3 hw_tier02 " {

}
SubProgram "gles3 hw_tier03 " {

}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassFinal" "RenderType"="Opaque" }
  ZWrite Off
  GpuProgramID 222539
Program "vp" {
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 o_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (tmpvar_3 * 0.5);
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = tmpvar_6.x;
					  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
					  o_5.xy = (tmpvar_7 + tmpvar_6.w);
					  o_5.zw = tmpvar_3.zw;
					  tmpvar_1.zw = vec2(0.0, 0.0);
					  tmpvar_1.xy = vec2(0.0, 0.0);
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].x;
					  v_8.y = unity_WorldToObject[1].x;
					  v_8.z = unity_WorldToObject[2].x;
					  v_8.w = unity_WorldToObject[3].x;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].y;
					  v_9.y = unity_WorldToObject[1].y;
					  v_9.z = unity_WorldToObject[2].y;
					  v_9.w = unity_WorldToObject[3].y;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].z;
					  v_10.y = unity_WorldToObject[1].z;
					  v_10.z = unity_WorldToObject[2].z;
					  v_10.w = unity_WorldToObject[3].z;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = normalize(((
					    (v_8.xyz * _glesNormal.x)
					   + 
					    (v_9.xyz * _glesNormal.y)
					  ) + (v_10.xyz * _glesNormal.z)));
					  mediump vec4 normal_12;
					  normal_12 = tmpvar_11;
					  mediump vec3 res_13;
					  mediump vec3 x_14;
					  x_14.x = dot (unity_SHAr, normal_12);
					  x_14.y = dot (unity_SHAg, normal_12);
					  x_14.z = dot (unity_SHAb, normal_12);
					  mediump vec3 x1_15;
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
					  x1_15.x = dot (unity_SHBr, tmpvar_16);
					  x1_15.y = dot (unity_SHBg, tmpvar_16);
					  x1_15.z = dot (unity_SHBb, tmpvar_16);
					  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
					    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
					  )));
					  res_13 = max (((1.055 * 
					    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_2 = res_13;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD2 = o_5;
					  xlv_TEXCOORD3 = tmpvar_1;
					  xlv_TEXCOORD4 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					uniform sampler2D _LightBuffer;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec4 tex_4;
					  lowp vec4 lit_5;
					  lit_5.w = xlv_COLOR0.w;
					  highp float tmpvar_6;
					  tmpvar_6 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_5.x = tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_5.y = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_5.z = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = max (lit_5.x, _AmbientLight.x);
					  lit_5.x = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = max (lit_5.y, _AmbientLight.y);
					  lit_5.y = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (lit_5.z, _AmbientLight.z);
					  lit_5.z = tmpvar_11;
					  lit_5.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_5.xyz = (((
					    (lit_5.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_12;
					  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_4.w = tmpvar_12.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_4.xyz = (((
					    (tmpvar_12.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  lowp vec4 tmpvar_13;
					  tmpvar_13 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_3 = tmpvar_13;
					  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
					  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
					  lowp vec4 c_14;
					  c_14.xyz = ((tex_4 * lit_5).xyz * light_3.xyz);
					  c_14.w = 0.0;
					  c_2.xyz = c_14.xyz;
					  c_2.w = 1.0;
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 o_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (tmpvar_3 * 0.5);
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = tmpvar_6.x;
					  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
					  o_5.xy = (tmpvar_7 + tmpvar_6.w);
					  o_5.zw = tmpvar_3.zw;
					  tmpvar_1.zw = vec2(0.0, 0.0);
					  tmpvar_1.xy = vec2(0.0, 0.0);
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].x;
					  v_8.y = unity_WorldToObject[1].x;
					  v_8.z = unity_WorldToObject[2].x;
					  v_8.w = unity_WorldToObject[3].x;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].y;
					  v_9.y = unity_WorldToObject[1].y;
					  v_9.z = unity_WorldToObject[2].y;
					  v_9.w = unity_WorldToObject[3].y;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].z;
					  v_10.y = unity_WorldToObject[1].z;
					  v_10.z = unity_WorldToObject[2].z;
					  v_10.w = unity_WorldToObject[3].z;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = normalize(((
					    (v_8.xyz * _glesNormal.x)
					   + 
					    (v_9.xyz * _glesNormal.y)
					  ) + (v_10.xyz * _glesNormal.z)));
					  mediump vec4 normal_12;
					  normal_12 = tmpvar_11;
					  mediump vec3 res_13;
					  mediump vec3 x_14;
					  x_14.x = dot (unity_SHAr, normal_12);
					  x_14.y = dot (unity_SHAg, normal_12);
					  x_14.z = dot (unity_SHAb, normal_12);
					  mediump vec3 x1_15;
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
					  x1_15.x = dot (unity_SHBr, tmpvar_16);
					  x1_15.y = dot (unity_SHBg, tmpvar_16);
					  x1_15.z = dot (unity_SHBb, tmpvar_16);
					  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
					    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
					  )));
					  res_13 = max (((1.055 * 
					    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_2 = res_13;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD2 = o_5;
					  xlv_TEXCOORD3 = tmpvar_1;
					  xlv_TEXCOORD4 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					uniform sampler2D _LightBuffer;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec4 tex_4;
					  lowp vec4 lit_5;
					  lit_5.w = xlv_COLOR0.w;
					  highp float tmpvar_6;
					  tmpvar_6 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_5.x = tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_5.y = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_5.z = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = max (lit_5.x, _AmbientLight.x);
					  lit_5.x = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = max (lit_5.y, _AmbientLight.y);
					  lit_5.y = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (lit_5.z, _AmbientLight.z);
					  lit_5.z = tmpvar_11;
					  lit_5.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_5.xyz = (((
					    (lit_5.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_12;
					  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_4.w = tmpvar_12.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_4.xyz = (((
					    (tmpvar_12.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  lowp vec4 tmpvar_13;
					  tmpvar_13 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_3 = tmpvar_13;
					  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
					  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
					  lowp vec4 c_14;
					  c_14.xyz = ((tex_4 * lit_5).xyz * light_3.xyz);
					  c_14.w = 0.0;
					  c_2.xyz = c_14.xyz;
					  c_2.w = 1.0;
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 o_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (tmpvar_3 * 0.5);
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = tmpvar_6.x;
					  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
					  o_5.xy = (tmpvar_7 + tmpvar_6.w);
					  o_5.zw = tmpvar_3.zw;
					  tmpvar_1.zw = vec2(0.0, 0.0);
					  tmpvar_1.xy = vec2(0.0, 0.0);
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].x;
					  v_8.y = unity_WorldToObject[1].x;
					  v_8.z = unity_WorldToObject[2].x;
					  v_8.w = unity_WorldToObject[3].x;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].y;
					  v_9.y = unity_WorldToObject[1].y;
					  v_9.z = unity_WorldToObject[2].y;
					  v_9.w = unity_WorldToObject[3].y;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].z;
					  v_10.y = unity_WorldToObject[1].z;
					  v_10.z = unity_WorldToObject[2].z;
					  v_10.w = unity_WorldToObject[3].z;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = normalize(((
					    (v_8.xyz * _glesNormal.x)
					   + 
					    (v_9.xyz * _glesNormal.y)
					  ) + (v_10.xyz * _glesNormal.z)));
					  mediump vec4 normal_12;
					  normal_12 = tmpvar_11;
					  mediump vec3 res_13;
					  mediump vec3 x_14;
					  x_14.x = dot (unity_SHAr, normal_12);
					  x_14.y = dot (unity_SHAg, normal_12);
					  x_14.z = dot (unity_SHAb, normal_12);
					  mediump vec3 x1_15;
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
					  x1_15.x = dot (unity_SHBr, tmpvar_16);
					  x1_15.y = dot (unity_SHBg, tmpvar_16);
					  x1_15.z = dot (unity_SHBb, tmpvar_16);
					  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
					    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
					  )));
					  res_13 = max (((1.055 * 
					    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_2 = res_13;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD2 = o_5;
					  xlv_TEXCOORD3 = tmpvar_1;
					  xlv_TEXCOORD4 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					uniform sampler2D _LightBuffer;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec4 tex_4;
					  lowp vec4 lit_5;
					  lit_5.w = xlv_COLOR0.w;
					  highp float tmpvar_6;
					  tmpvar_6 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_5.x = tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_5.y = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_5.z = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = max (lit_5.x, _AmbientLight.x);
					  lit_5.x = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = max (lit_5.y, _AmbientLight.y);
					  lit_5.y = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (lit_5.z, _AmbientLight.z);
					  lit_5.z = tmpvar_11;
					  lit_5.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_5.xyz = (((
					    (lit_5.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_12;
					  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_4.w = tmpvar_12.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_4.xyz = (((
					    (tmpvar_12.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  lowp vec4 tmpvar_13;
					  tmpvar_13 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_3 = tmpvar_13;
					  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
					  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
					  lowp vec4 c_14;
					  c_14.xyz = ((tex_4 * lit_5).xyz * light_3.xyz);
					  c_14.w = 0.0;
					  c_2.xyz = c_14.xyz;
					  c_2.w = 1.0;
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out lowp vec4 vs_COLOR0;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD2.zw = u_xlat0.zw;
					    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _LightBuffer;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					in highp vec4 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump float u_xlat16_0;
					lowp float u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat12 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat12 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat10_0 = texture(_LightBuffer, u_xlat0.xy).x;
					    u_xlat16_0 = max(u_xlat10_0, 0.00100000005);
					    u_xlat16_3.x = log2(u_xlat16_0);
					    u_xlat0.xyz = (-u_xlat16_3.xxx) + vs_TEXCOORD4.xyz;
					    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat10_2.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out lowp vec4 vs_COLOR0;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD2.zw = u_xlat0.zw;
					    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _LightBuffer;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					in highp vec4 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump float u_xlat16_0;
					lowp float u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat12 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat12 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat10_0 = texture(_LightBuffer, u_xlat0.xy).x;
					    u_xlat16_0 = max(u_xlat10_0, 0.00100000005);
					    u_xlat16_3.x = log2(u_xlat16_0);
					    u_xlat0.xyz = (-u_xlat16_3.xxx) + vs_TEXCOORD4.xyz;
					    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat10_2.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier03 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out lowp vec4 vs_COLOR0;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD2.zw = u_xlat0.zw;
					    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _LightBuffer;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					in highp vec4 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump float u_xlat16_0;
					lowp float u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat12 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat12 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat10_0 = texture(_LightBuffer, u_xlat0.xy).x;
					    u_xlat16_0 = max(u_xlat10_0, 0.00100000005);
					    u_xlat16_3.x = log2(u_xlat16_0);
					    u_xlat0.xyz = (-u_xlat16_3.xxx) + vs_TEXCOORD4.xyz;
					    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat10_2.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 o_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (tmpvar_3 * 0.5);
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = tmpvar_6.x;
					  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
					  o_5.xy = (tmpvar_7 + tmpvar_6.w);
					  o_5.zw = tmpvar_3.zw;
					  tmpvar_1.zw = vec2(0.0, 0.0);
					  tmpvar_1.xy = vec2(0.0, 0.0);
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].x;
					  v_8.y = unity_WorldToObject[1].x;
					  v_8.z = unity_WorldToObject[2].x;
					  v_8.w = unity_WorldToObject[3].x;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].y;
					  v_9.y = unity_WorldToObject[1].y;
					  v_9.z = unity_WorldToObject[2].y;
					  v_9.w = unity_WorldToObject[3].y;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].z;
					  v_10.y = unity_WorldToObject[1].z;
					  v_10.z = unity_WorldToObject[2].z;
					  v_10.w = unity_WorldToObject[3].z;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = normalize(((
					    (v_8.xyz * _glesNormal.x)
					   + 
					    (v_9.xyz * _glesNormal.y)
					  ) + (v_10.xyz * _glesNormal.z)));
					  mediump vec4 normal_12;
					  normal_12 = tmpvar_11;
					  mediump vec3 res_13;
					  mediump vec3 x_14;
					  x_14.x = dot (unity_SHAr, normal_12);
					  x_14.y = dot (unity_SHAg, normal_12);
					  x_14.z = dot (unity_SHAb, normal_12);
					  mediump vec3 x1_15;
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
					  x1_15.x = dot (unity_SHBr, tmpvar_16);
					  x1_15.y = dot (unity_SHBg, tmpvar_16);
					  x1_15.z = dot (unity_SHBb, tmpvar_16);
					  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
					    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
					  )));
					  res_13 = max (((1.055 * 
					    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_2 = res_13;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD2 = o_5;
					  xlv_TEXCOORD3 = tmpvar_1;
					  xlv_TEXCOORD4 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					uniform sampler2D _LightBuffer;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec4 tex_4;
					  lowp vec4 lit_5;
					  lit_5.w = xlv_COLOR0.w;
					  highp float tmpvar_6;
					  tmpvar_6 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_5.x = tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_5.y = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_5.z = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = max (lit_5.x, _AmbientLight.x);
					  lit_5.x = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = max (lit_5.y, _AmbientLight.y);
					  lit_5.y = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (lit_5.z, _AmbientLight.z);
					  lit_5.z = tmpvar_11;
					  lit_5.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_5.xyz = (((
					    (lit_5.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_12;
					  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_4.w = tmpvar_12.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_4.xyz = (((
					    (tmpvar_12.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  lowp vec4 tmpvar_13;
					  tmpvar_13 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_3 = tmpvar_13;
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
					  light_3.w = tmpvar_14.w;
					  light_3.xyz = (tmpvar_14.xyz + xlv_TEXCOORD4);
					  lowp vec4 c_15;
					  c_15.xyz = ((tex_4 * lit_5).xyz * light_3.xyz);
					  c_15.w = 0.0;
					  c_2.xyz = c_15.xyz;
					  c_2.w = 1.0;
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 o_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (tmpvar_3 * 0.5);
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = tmpvar_6.x;
					  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
					  o_5.xy = (tmpvar_7 + tmpvar_6.w);
					  o_5.zw = tmpvar_3.zw;
					  tmpvar_1.zw = vec2(0.0, 0.0);
					  tmpvar_1.xy = vec2(0.0, 0.0);
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].x;
					  v_8.y = unity_WorldToObject[1].x;
					  v_8.z = unity_WorldToObject[2].x;
					  v_8.w = unity_WorldToObject[3].x;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].y;
					  v_9.y = unity_WorldToObject[1].y;
					  v_9.z = unity_WorldToObject[2].y;
					  v_9.w = unity_WorldToObject[3].y;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].z;
					  v_10.y = unity_WorldToObject[1].z;
					  v_10.z = unity_WorldToObject[2].z;
					  v_10.w = unity_WorldToObject[3].z;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = normalize(((
					    (v_8.xyz * _glesNormal.x)
					   + 
					    (v_9.xyz * _glesNormal.y)
					  ) + (v_10.xyz * _glesNormal.z)));
					  mediump vec4 normal_12;
					  normal_12 = tmpvar_11;
					  mediump vec3 res_13;
					  mediump vec3 x_14;
					  x_14.x = dot (unity_SHAr, normal_12);
					  x_14.y = dot (unity_SHAg, normal_12);
					  x_14.z = dot (unity_SHAb, normal_12);
					  mediump vec3 x1_15;
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
					  x1_15.x = dot (unity_SHBr, tmpvar_16);
					  x1_15.y = dot (unity_SHBg, tmpvar_16);
					  x1_15.z = dot (unity_SHBb, tmpvar_16);
					  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
					    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
					  )));
					  res_13 = max (((1.055 * 
					    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_2 = res_13;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD2 = o_5;
					  xlv_TEXCOORD3 = tmpvar_1;
					  xlv_TEXCOORD4 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					uniform sampler2D _LightBuffer;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec4 tex_4;
					  lowp vec4 lit_5;
					  lit_5.w = xlv_COLOR0.w;
					  highp float tmpvar_6;
					  tmpvar_6 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_5.x = tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_5.y = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_5.z = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = max (lit_5.x, _AmbientLight.x);
					  lit_5.x = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = max (lit_5.y, _AmbientLight.y);
					  lit_5.y = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (lit_5.z, _AmbientLight.z);
					  lit_5.z = tmpvar_11;
					  lit_5.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_5.xyz = (((
					    (lit_5.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_12;
					  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_4.w = tmpvar_12.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_4.xyz = (((
					    (tmpvar_12.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  lowp vec4 tmpvar_13;
					  tmpvar_13 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_3 = tmpvar_13;
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
					  light_3.w = tmpvar_14.w;
					  light_3.xyz = (tmpvar_14.xyz + xlv_TEXCOORD4);
					  lowp vec4 c_15;
					  c_15.xyz = ((tex_4 * lit_5).xyz * light_3.xyz);
					  c_15.w = 0.0;
					  c_2.xyz = c_15.xyz;
					  c_2.w = 1.0;
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 o_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (tmpvar_3 * 0.5);
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = tmpvar_6.x;
					  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
					  o_5.xy = (tmpvar_7 + tmpvar_6.w);
					  o_5.zw = tmpvar_3.zw;
					  tmpvar_1.zw = vec2(0.0, 0.0);
					  tmpvar_1.xy = vec2(0.0, 0.0);
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].x;
					  v_8.y = unity_WorldToObject[1].x;
					  v_8.z = unity_WorldToObject[2].x;
					  v_8.w = unity_WorldToObject[3].x;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].y;
					  v_9.y = unity_WorldToObject[1].y;
					  v_9.z = unity_WorldToObject[2].y;
					  v_9.w = unity_WorldToObject[3].y;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].z;
					  v_10.y = unity_WorldToObject[1].z;
					  v_10.z = unity_WorldToObject[2].z;
					  v_10.w = unity_WorldToObject[3].z;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = normalize(((
					    (v_8.xyz * _glesNormal.x)
					   + 
					    (v_9.xyz * _glesNormal.y)
					  ) + (v_10.xyz * _glesNormal.z)));
					  mediump vec4 normal_12;
					  normal_12 = tmpvar_11;
					  mediump vec3 res_13;
					  mediump vec3 x_14;
					  x_14.x = dot (unity_SHAr, normal_12);
					  x_14.y = dot (unity_SHAg, normal_12);
					  x_14.z = dot (unity_SHAb, normal_12);
					  mediump vec3 x1_15;
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
					  x1_15.x = dot (unity_SHBr, tmpvar_16);
					  x1_15.y = dot (unity_SHBg, tmpvar_16);
					  x1_15.z = dot (unity_SHBb, tmpvar_16);
					  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
					    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
					  )));
					  res_13 = max (((1.055 * 
					    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_2 = res_13;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD2 = o_5;
					  xlv_TEXCOORD3 = tmpvar_1;
					  xlv_TEXCOORD4 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					uniform sampler2D _LightBuffer;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec4 tex_4;
					  lowp vec4 lit_5;
					  lit_5.w = xlv_COLOR0.w;
					  highp float tmpvar_6;
					  tmpvar_6 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_5.x = tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_5.y = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_5.z = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = max (lit_5.x, _AmbientLight.x);
					  lit_5.x = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = max (lit_5.y, _AmbientLight.y);
					  lit_5.y = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (lit_5.z, _AmbientLight.z);
					  lit_5.z = tmpvar_11;
					  lit_5.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_5.xyz = (((
					    (lit_5.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_12;
					  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_4.w = tmpvar_12.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_4.xyz = (((
					    (tmpvar_12.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  lowp vec4 tmpvar_13;
					  tmpvar_13 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_3 = tmpvar_13;
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
					  light_3.w = tmpvar_14.w;
					  light_3.xyz = (tmpvar_14.xyz + xlv_TEXCOORD4);
					  lowp vec4 c_15;
					  c_15.xyz = ((tex_4 * lit_5).xyz * light_3.xyz);
					  c_15.w = 0.0;
					  c_2.xyz = c_15.xyz;
					  c_2.w = 1.0;
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out lowp vec4 vs_COLOR0;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD2.zw = u_xlat0.zw;
					    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _LightBuffer;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					in highp vec4 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump float u_xlat16_0;
					lowp float u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat12 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat12 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat10_0 = texture(_LightBuffer, u_xlat0.xy).x;
					    u_xlat16_0 = max(u_xlat10_0, 0.00100000005);
					    u_xlat0.xyz = vec3(u_xlat16_0) + vs_TEXCOORD4.xyz;
					    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat10_2.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out lowp vec4 vs_COLOR0;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD2.zw = u_xlat0.zw;
					    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _LightBuffer;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					in highp vec4 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump float u_xlat16_0;
					lowp float u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat12 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat12 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat10_0 = texture(_LightBuffer, u_xlat0.xy).x;
					    u_xlat16_0 = max(u_xlat10_0, 0.00100000005);
					    u_xlat0.xyz = vec3(u_xlat16_0) + vs_TEXCOORD4.xyz;
					    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat10_2.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier03 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out lowp vec4 vs_COLOR0;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD2.zw = u_xlat0.zw;
					    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _LightBuffer;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					in highp vec4 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump float u_xlat16_0;
					lowp float u_xlat10_0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat12 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat12 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat10_0 = texture(_LightBuffer, u_xlat0.xy).x;
					    u_xlat16_0 = max(u_xlat10_0, 0.00100000005);
					    u_xlat0.xyz = vec3(u_xlat16_0) + vs_TEXCOORD4.xyz;
					    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat10_2.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif
}
}
Program "fp" {
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
}
SubProgram "gles hw_tier03 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
}
SubProgram "gles3 hw_tier03 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
					
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
					
}
SubProgram "gles hw_tier03 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
					
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
					
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
					
}
SubProgram "gles3 hw_tier03 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
					
}
}
 }
 Pass {
  Name "DEFERRED"
  Tags { "LIGHTMODE"="Deferred" "RenderType"="Opaque" }
  GpuProgramID 323037
Program "vp" {
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD3;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  tmpvar_3.zw = vec2(0.0, 0.0);
					  tmpvar_3.xy = vec2(0.0, 0.0);
					  mediump vec3 normal_9;
					  normal_9 = worldNormal_1;
					  mediump vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = normal_9;
					  mediump vec3 res_11;
					  mediump vec3 x_12;
					  x_12.x = dot (unity_SHAr, tmpvar_10);
					  x_12.y = dot (unity_SHAg, tmpvar_10);
					  x_12.z = dot (unity_SHAb, tmpvar_10);
					  mediump vec3 x1_13;
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = (normal_9.xyzz * normal_9.yzzx);
					  x1_13.x = dot (unity_SHBr, tmpvar_14);
					  x1_13.y = dot (unity_SHBg, tmpvar_14);
					  x1_13.z = dot (unity_SHBb, tmpvar_14);
					  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
					    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
					  )));
					  res_11 = max (((1.055 * 
					    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  gl_Position = (glstate_matrix_mvp * tmpvar_4);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD3 = tmpvar_3;
					  xlv_TEXCOORD4 = max (vec3(0.0, 0.0, 0.0), res_11);
					}
					
					
					#endif
					#ifdef FRAGMENT
					#extension GL_EXT_draw_buffers : enable
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 outDiffuse_1;
					  mediump vec4 outEmission_2;
					  lowp vec3 tmpvar_3;
					  tmpvar_3 = xlv_TEXCOORD1;
					  lowp vec4 tex_4;
					  lowp vec4 lit_5;
					  lit_5.w = xlv_COLOR0.w;
					  highp float tmpvar_6;
					  tmpvar_6 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_5.x = tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_5.y = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_5.z = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = max (lit_5.x, _AmbientLight.x);
					  lit_5.x = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = max (lit_5.y, _AmbientLight.y);
					  lit_5.y = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (lit_5.z, _AmbientLight.z);
					  lit_5.z = tmpvar_11;
					  lit_5.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_5.xyz = (((
					    (lit_5.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_12;
					  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_4.w = tmpvar_12.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_4.xyz = (((
					    (tmpvar_12.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  lowp vec4 tmpvar_13;
					  tmpvar_13 = (tex_4 * lit_5);
					  mediump vec4 outDiffuseOcclusion_14;
					  mediump vec4 outNormal_15;
					  mediump vec4 emission_16;
					  lowp vec4 tmpvar_17;
					  tmpvar_17.w = 1.0;
					  tmpvar_17.xyz = tmpvar_13.xyz;
					  outDiffuseOcclusion_14 = tmpvar_17;
					  lowp vec4 tmpvar_18;
					  tmpvar_18.w = 1.0;
					  tmpvar_18.xyz = ((tmpvar_3 * 0.5) + 0.5);
					  outNormal_15 = tmpvar_18;
					  lowp vec4 tmpvar_19;
					  tmpvar_19.w = 1.0;
					  tmpvar_19.xyz = vec3(0.0, 0.0, 0.0);
					  emission_16 = tmpvar_19;
					  emission_16.xyz = (emission_16.xyz + (tmpvar_13.xyz * xlv_TEXCOORD4));
					  outDiffuse_1.xyz = outDiffuseOcclusion_14.xyz;
					  outEmission_2.w = emission_16.w;
					  outEmission_2.xyz = exp2(-(emission_16.xyz));
					  outDiffuse_1.w = 1.0;
					  gl_FragData[0] = outDiffuse_1;
					  gl_FragData[1] = vec4(0.0, 0.0, 0.0, 0.0);
					  gl_FragData[2] = outNormal_15;
					  gl_FragData[3] = outEmission_2;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD3;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  tmpvar_3.zw = vec2(0.0, 0.0);
					  tmpvar_3.xy = vec2(0.0, 0.0);
					  mediump vec3 normal_9;
					  normal_9 = worldNormal_1;
					  mediump vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = normal_9;
					  mediump vec3 res_11;
					  mediump vec3 x_12;
					  x_12.x = dot (unity_SHAr, tmpvar_10);
					  x_12.y = dot (unity_SHAg, tmpvar_10);
					  x_12.z = dot (unity_SHAb, tmpvar_10);
					  mediump vec3 x1_13;
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = (normal_9.xyzz * normal_9.yzzx);
					  x1_13.x = dot (unity_SHBr, tmpvar_14);
					  x1_13.y = dot (unity_SHBg, tmpvar_14);
					  x1_13.z = dot (unity_SHBb, tmpvar_14);
					  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
					    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
					  )));
					  res_11 = max (((1.055 * 
					    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  gl_Position = (glstate_matrix_mvp * tmpvar_4);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD3 = tmpvar_3;
					  xlv_TEXCOORD4 = max (vec3(0.0, 0.0, 0.0), res_11);
					}
					
					
					#endif
					#ifdef FRAGMENT
					#extension GL_EXT_draw_buffers : enable
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 outDiffuse_1;
					  mediump vec4 outEmission_2;
					  lowp vec3 tmpvar_3;
					  tmpvar_3 = xlv_TEXCOORD1;
					  lowp vec4 tex_4;
					  lowp vec4 lit_5;
					  lit_5.w = xlv_COLOR0.w;
					  highp float tmpvar_6;
					  tmpvar_6 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_5.x = tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_5.y = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_5.z = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = max (lit_5.x, _AmbientLight.x);
					  lit_5.x = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = max (lit_5.y, _AmbientLight.y);
					  lit_5.y = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (lit_5.z, _AmbientLight.z);
					  lit_5.z = tmpvar_11;
					  lit_5.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_5.xyz = (((
					    (lit_5.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_12;
					  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_4.w = tmpvar_12.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_4.xyz = (((
					    (tmpvar_12.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  lowp vec4 tmpvar_13;
					  tmpvar_13 = (tex_4 * lit_5);
					  mediump vec4 outDiffuseOcclusion_14;
					  mediump vec4 outNormal_15;
					  mediump vec4 emission_16;
					  lowp vec4 tmpvar_17;
					  tmpvar_17.w = 1.0;
					  tmpvar_17.xyz = tmpvar_13.xyz;
					  outDiffuseOcclusion_14 = tmpvar_17;
					  lowp vec4 tmpvar_18;
					  tmpvar_18.w = 1.0;
					  tmpvar_18.xyz = ((tmpvar_3 * 0.5) + 0.5);
					  outNormal_15 = tmpvar_18;
					  lowp vec4 tmpvar_19;
					  tmpvar_19.w = 1.0;
					  tmpvar_19.xyz = vec3(0.0, 0.0, 0.0);
					  emission_16 = tmpvar_19;
					  emission_16.xyz = (emission_16.xyz + (tmpvar_13.xyz * xlv_TEXCOORD4));
					  outDiffuse_1.xyz = outDiffuseOcclusion_14.xyz;
					  outEmission_2.w = emission_16.w;
					  outEmission_2.xyz = exp2(-(emission_16.xyz));
					  outDiffuse_1.w = 1.0;
					  gl_FragData[0] = outDiffuse_1;
					  gl_FragData[1] = vec4(0.0, 0.0, 0.0, 0.0);
					  gl_FragData[2] = outNormal_15;
					  gl_FragData[3] = outEmission_2;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD3;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  tmpvar_3.zw = vec2(0.0, 0.0);
					  tmpvar_3.xy = vec2(0.0, 0.0);
					  mediump vec3 normal_9;
					  normal_9 = worldNormal_1;
					  mediump vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = normal_9;
					  mediump vec3 res_11;
					  mediump vec3 x_12;
					  x_12.x = dot (unity_SHAr, tmpvar_10);
					  x_12.y = dot (unity_SHAg, tmpvar_10);
					  x_12.z = dot (unity_SHAb, tmpvar_10);
					  mediump vec3 x1_13;
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = (normal_9.xyzz * normal_9.yzzx);
					  x1_13.x = dot (unity_SHBr, tmpvar_14);
					  x1_13.y = dot (unity_SHBg, tmpvar_14);
					  x1_13.z = dot (unity_SHBb, tmpvar_14);
					  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
					    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
					  )));
					  res_11 = max (((1.055 * 
					    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  gl_Position = (glstate_matrix_mvp * tmpvar_4);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD3 = tmpvar_3;
					  xlv_TEXCOORD4 = max (vec3(0.0, 0.0, 0.0), res_11);
					}
					
					
					#endif
					#ifdef FRAGMENT
					#extension GL_EXT_draw_buffers : enable
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 outDiffuse_1;
					  mediump vec4 outEmission_2;
					  lowp vec3 tmpvar_3;
					  tmpvar_3 = xlv_TEXCOORD1;
					  lowp vec4 tex_4;
					  lowp vec4 lit_5;
					  lit_5.w = xlv_COLOR0.w;
					  highp float tmpvar_6;
					  tmpvar_6 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_5.x = tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_5.y = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_5.z = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = max (lit_5.x, _AmbientLight.x);
					  lit_5.x = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = max (lit_5.y, _AmbientLight.y);
					  lit_5.y = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = max (lit_5.z, _AmbientLight.z);
					  lit_5.z = tmpvar_11;
					  lit_5.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_5.xyz = (((
					    (lit_5.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_12;
					  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_4.w = tmpvar_12.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_4.xyz = (((
					    (tmpvar_12.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  lowp vec4 tmpvar_13;
					  tmpvar_13 = (tex_4 * lit_5);
					  mediump vec4 outDiffuseOcclusion_14;
					  mediump vec4 outNormal_15;
					  mediump vec4 emission_16;
					  lowp vec4 tmpvar_17;
					  tmpvar_17.w = 1.0;
					  tmpvar_17.xyz = tmpvar_13.xyz;
					  outDiffuseOcclusion_14 = tmpvar_17;
					  lowp vec4 tmpvar_18;
					  tmpvar_18.w = 1.0;
					  tmpvar_18.xyz = ((tmpvar_3 * 0.5) + 0.5);
					  outNormal_15 = tmpvar_18;
					  lowp vec4 tmpvar_19;
					  tmpvar_19.w = 1.0;
					  tmpvar_19.xyz = vec3(0.0, 0.0, 0.0);
					  emission_16 = tmpvar_19;
					  emission_16.xyz = (emission_16.xyz + (tmpvar_13.xyz * xlv_TEXCOORD4));
					  outDiffuse_1.xyz = outDiffuseOcclusion_14.xyz;
					  outEmission_2.w = emission_16.w;
					  outEmission_2.xyz = exp2(-(emission_16.xyz));
					  outDiffuse_1.w = 1.0;
					  gl_FragData[0] = outDiffuse_1;
					  gl_FragData[1] = vec4(0.0, 0.0, 0.0, 0.0);
					  gl_FragData[2] = outNormal_15;
					  gl_FragData[3] = outEmission_2;
					}
					
					
					#endif
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					out highp vec4 vs_TEXCOORD3;
					out mediump vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD4.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat12 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat12 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.xyz = u_xlat10_2.xyz;
					    u_xlat16_3.xyz = u_xlat10_2.xyz * vs_TEXCOORD4.xyz;
					    SV_Target3.xyz = exp2((-u_xlat16_3.xyz));
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat10_2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.xyz = u_xlat10_2.xyz;
					    SV_Target2.w = 1.0;
					    SV_Target3.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					out highp vec4 vs_TEXCOORD3;
					out mediump vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD4.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat12 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat12 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.xyz = u_xlat10_2.xyz;
					    u_xlat16_3.xyz = u_xlat10_2.xyz * vs_TEXCOORD4.xyz;
					    SV_Target3.xyz = exp2((-u_xlat16_3.xyz));
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat10_2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.xyz = u_xlat10_2.xyz;
					    SV_Target2.w = 1.0;
					    SV_Target3.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier03 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					out highp vec4 vs_TEXCOORD3;
					out mediump vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD4.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat12 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat12 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.xyz = u_xlat10_2.xyz;
					    u_xlat16_3.xyz = u_xlat10_2.xyz * vs_TEXCOORD4.xyz;
					    SV_Target3.xyz = exp2((-u_xlat16_3.xyz));
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat10_2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.xyz = u_xlat10_2.xyz;
					    SV_Target2.w = 1.0;
					    SV_Target3.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD3;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  tmpvar_3.zw = vec2(0.0, 0.0);
					  tmpvar_3.xy = vec2(0.0, 0.0);
					  mediump vec3 normal_9;
					  normal_9 = worldNormal_1;
					  mediump vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = normal_9;
					  mediump vec3 res_11;
					  mediump vec3 x_12;
					  x_12.x = dot (unity_SHAr, tmpvar_10);
					  x_12.y = dot (unity_SHAg, tmpvar_10);
					  x_12.z = dot (unity_SHAb, tmpvar_10);
					  mediump vec3 x1_13;
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = (normal_9.xyzz * normal_9.yzzx);
					  x1_13.x = dot (unity_SHBr, tmpvar_14);
					  x1_13.y = dot (unity_SHBg, tmpvar_14);
					  x1_13.z = dot (unity_SHBb, tmpvar_14);
					  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
					    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
					  )));
					  res_11 = max (((1.055 * 
					    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  gl_Position = (glstate_matrix_mvp * tmpvar_4);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD3 = tmpvar_3;
					  xlv_TEXCOORD4 = max (vec3(0.0, 0.0, 0.0), res_11);
					}
					
					
					#endif
					#ifdef FRAGMENT
					#extension GL_EXT_draw_buffers : enable
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 outDiffuse_1;
					  lowp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD1;
					  lowp vec4 tex_3;
					  lowp vec4 lit_4;
					  lit_4.w = xlv_COLOR0.w;
					  highp float tmpvar_5;
					  tmpvar_5 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_4.x = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_4.y = tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_4.z = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = max (lit_4.x, _AmbientLight.x);
					  lit_4.x = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = max (lit_4.y, _AmbientLight.y);
					  lit_4.y = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = max (lit_4.z, _AmbientLight.z);
					  lit_4.z = tmpvar_10;
					  lit_4.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_4.xyz = (((
					    (lit_4.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_3.w = tmpvar_11.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_3.xyz = (((
					    (tmpvar_11.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  lowp vec4 tmpvar_12;
					  tmpvar_12 = (tex_3 * lit_4);
					  mediump vec4 outDiffuseOcclusion_13;
					  mediump vec4 outNormal_14;
					  mediump vec4 emission_15;
					  lowp vec4 tmpvar_16;
					  tmpvar_16.w = 1.0;
					  tmpvar_16.xyz = tmpvar_12.xyz;
					  outDiffuseOcclusion_13 = tmpvar_16;
					  lowp vec4 tmpvar_17;
					  tmpvar_17.w = 1.0;
					  tmpvar_17.xyz = ((tmpvar_2 * 0.5) + 0.5);
					  outNormal_14 = tmpvar_17;
					  lowp vec4 tmpvar_18;
					  tmpvar_18.w = 1.0;
					  tmpvar_18.xyz = vec3(0.0, 0.0, 0.0);
					  emission_15 = tmpvar_18;
					  emission_15.xyz = (emission_15.xyz + (tmpvar_12.xyz * xlv_TEXCOORD4));
					  outDiffuse_1.xyz = outDiffuseOcclusion_13.xyz;
					  outDiffuse_1.w = 1.0;
					  gl_FragData[0] = outDiffuse_1;
					  gl_FragData[1] = vec4(0.0, 0.0, 0.0, 0.0);
					  gl_FragData[2] = outNormal_14;
					  gl_FragData[3] = emission_15;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD3;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  tmpvar_3.zw = vec2(0.0, 0.0);
					  tmpvar_3.xy = vec2(0.0, 0.0);
					  mediump vec3 normal_9;
					  normal_9 = worldNormal_1;
					  mediump vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = normal_9;
					  mediump vec3 res_11;
					  mediump vec3 x_12;
					  x_12.x = dot (unity_SHAr, tmpvar_10);
					  x_12.y = dot (unity_SHAg, tmpvar_10);
					  x_12.z = dot (unity_SHAb, tmpvar_10);
					  mediump vec3 x1_13;
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = (normal_9.xyzz * normal_9.yzzx);
					  x1_13.x = dot (unity_SHBr, tmpvar_14);
					  x1_13.y = dot (unity_SHBg, tmpvar_14);
					  x1_13.z = dot (unity_SHBb, tmpvar_14);
					  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
					    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
					  )));
					  res_11 = max (((1.055 * 
					    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  gl_Position = (glstate_matrix_mvp * tmpvar_4);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD3 = tmpvar_3;
					  xlv_TEXCOORD4 = max (vec3(0.0, 0.0, 0.0), res_11);
					}
					
					
					#endif
					#ifdef FRAGMENT
					#extension GL_EXT_draw_buffers : enable
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 outDiffuse_1;
					  lowp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD1;
					  lowp vec4 tex_3;
					  lowp vec4 lit_4;
					  lit_4.w = xlv_COLOR0.w;
					  highp float tmpvar_5;
					  tmpvar_5 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_4.x = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_4.y = tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_4.z = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = max (lit_4.x, _AmbientLight.x);
					  lit_4.x = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = max (lit_4.y, _AmbientLight.y);
					  lit_4.y = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = max (lit_4.z, _AmbientLight.z);
					  lit_4.z = tmpvar_10;
					  lit_4.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_4.xyz = (((
					    (lit_4.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_3.w = tmpvar_11.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_3.xyz = (((
					    (tmpvar_11.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  lowp vec4 tmpvar_12;
					  tmpvar_12 = (tex_3 * lit_4);
					  mediump vec4 outDiffuseOcclusion_13;
					  mediump vec4 outNormal_14;
					  mediump vec4 emission_15;
					  lowp vec4 tmpvar_16;
					  tmpvar_16.w = 1.0;
					  tmpvar_16.xyz = tmpvar_12.xyz;
					  outDiffuseOcclusion_13 = tmpvar_16;
					  lowp vec4 tmpvar_17;
					  tmpvar_17.w = 1.0;
					  tmpvar_17.xyz = ((tmpvar_2 * 0.5) + 0.5);
					  outNormal_14 = tmpvar_17;
					  lowp vec4 tmpvar_18;
					  tmpvar_18.w = 1.0;
					  tmpvar_18.xyz = vec3(0.0, 0.0, 0.0);
					  emission_15 = tmpvar_18;
					  emission_15.xyz = (emission_15.xyz + (tmpvar_12.xyz * xlv_TEXCOORD4));
					  outDiffuse_1.xyz = outDiffuseOcclusion_13.xyz;
					  outDiffuse_1.w = 1.0;
					  gl_FragData[0] = outDiffuse_1;
					  gl_FragData[1] = vec4(0.0, 0.0, 0.0, 0.0);
					  gl_FragData[2] = outNormal_14;
					  gl_FragData[3] = emission_15;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD3;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  tmpvar_3.zw = vec2(0.0, 0.0);
					  tmpvar_3.xy = vec2(0.0, 0.0);
					  mediump vec3 normal_9;
					  normal_9 = worldNormal_1;
					  mediump vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = normal_9;
					  mediump vec3 res_11;
					  mediump vec3 x_12;
					  x_12.x = dot (unity_SHAr, tmpvar_10);
					  x_12.y = dot (unity_SHAg, tmpvar_10);
					  x_12.z = dot (unity_SHAb, tmpvar_10);
					  mediump vec3 x1_13;
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = (normal_9.xyzz * normal_9.yzzx);
					  x1_13.x = dot (unity_SHBr, tmpvar_14);
					  x1_13.y = dot (unity_SHBg, tmpvar_14);
					  x1_13.z = dot (unity_SHBb, tmpvar_14);
					  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
					    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
					  )));
					  res_11 = max (((1.055 * 
					    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  gl_Position = (glstate_matrix_mvp * tmpvar_4);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD3 = tmpvar_3;
					  xlv_TEXCOORD4 = max (vec3(0.0, 0.0, 0.0), res_11);
					}
					
					
					#endif
					#ifdef FRAGMENT
					#extension GL_EXT_draw_buffers : enable
					uniform sampler2D _MainTex;
					uniform highp float _TexBrightness;
					uniform highp float _TexContrast;
					uniform highp float _TexContrastOffset;
					uniform highp vec4 _SkyLight;
					uniform highp vec4 _AmbientLight;
					uniform highp float _LitBrightness;
					uniform highp float _LitContrast;
					uniform highp float _LitContrastOffset;
					highp float xlat_mutable_LitContrast;
					highp float xlat_mutable_TexContrast;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 outDiffuse_1;
					  lowp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD1;
					  lowp vec4 tex_3;
					  lowp vec4 lit_4;
					  lit_4.w = xlv_COLOR0.w;
					  highp float tmpvar_5;
					  tmpvar_5 = max (xlv_COLOR0.x, (_SkyLight.x * xlv_COLOR0.w));
					  lit_4.x = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = max (xlv_COLOR0.y, (_SkyLight.y * xlv_COLOR0.w));
					  lit_4.y = tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = max (xlv_COLOR0.z, (_SkyLight.z * xlv_COLOR0.w));
					  lit_4.z = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = max (lit_4.x, _AmbientLight.x);
					  lit_4.x = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = max (lit_4.y, _AmbientLight.y);
					  lit_4.y = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = max (lit_4.z, _AmbientLight.z);
					  lit_4.z = tmpvar_10;
					  lit_4.w = 1.0;
					  xlat_mutable_LitContrast = (_LitContrast * _LitContrast);
					  lit_4.xyz = (((
					    (lit_4.xyz - vec3(_LitContrastOffset))
					   + vec3(_LitBrightness)) * vec3(xlat_mutable_LitContrast)) + vec3(_LitContrastOffset));
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_3.w = tmpvar_11.w;
					  xlat_mutable_TexContrast = (_TexContrast * _TexContrast);
					  tex_3.xyz = (((
					    (tmpvar_11.xyz - vec3(_TexContrastOffset))
					   + vec3(_TexBrightness)) * vec3(xlat_mutable_TexContrast)) + vec3(_TexContrastOffset));
					  lowp vec4 tmpvar_12;
					  tmpvar_12 = (tex_3 * lit_4);
					  mediump vec4 outDiffuseOcclusion_13;
					  mediump vec4 outNormal_14;
					  mediump vec4 emission_15;
					  lowp vec4 tmpvar_16;
					  tmpvar_16.w = 1.0;
					  tmpvar_16.xyz = tmpvar_12.xyz;
					  outDiffuseOcclusion_13 = tmpvar_16;
					  lowp vec4 tmpvar_17;
					  tmpvar_17.w = 1.0;
					  tmpvar_17.xyz = ((tmpvar_2 * 0.5) + 0.5);
					  outNormal_14 = tmpvar_17;
					  lowp vec4 tmpvar_18;
					  tmpvar_18.w = 1.0;
					  tmpvar_18.xyz = vec3(0.0, 0.0, 0.0);
					  emission_15 = tmpvar_18;
					  emission_15.xyz = (emission_15.xyz + (tmpvar_12.xyz * xlv_TEXCOORD4));
					  outDiffuse_1.xyz = outDiffuseOcclusion_13.xyz;
					  outDiffuse_1.w = 1.0;
					  gl_FragData[0] = outDiffuse_1;
					  gl_FragData[1] = vec4(0.0, 0.0, 0.0, 0.0);
					  gl_FragData[2] = outNormal_14;
					  gl_FragData[3] = emission_15;
					}
					
					
					#endif
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					out highp vec4 vs_TEXCOORD3;
					out mediump vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD4.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat9 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat9 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.xyz = u_xlat10_2.xyz;
					    SV_Target3.xyz = u_xlat10_2.xyz * vs_TEXCOORD4.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat10_2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.xyz = u_xlat10_2.xyz;
					    SV_Target2.w = 1.0;
					    SV_Target3.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					out highp vec4 vs_TEXCOORD3;
					out mediump vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD4.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat9 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat9 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.xyz = u_xlat10_2.xyz;
					    SV_Target3.xyz = u_xlat10_2.xyz * vs_TEXCOORD4.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat10_2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.xyz = u_xlat10_2.xyz;
					    SV_Target2.w = 1.0;
					    SV_Target3.w = 1.0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier03 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					out highp vec4 vs_TEXCOORD3;
					out mediump vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD4.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float _TexBrightness;
					uniform 	float _TexContrast;
					uniform 	float _TexContrastOffset;
					uniform 	vec4 _SkyLight;
					uniform 	vec4 _AmbientLight;
					uniform 	float _LitBrightness;
					uniform 	float _LitContrast;
					uniform 	float _LitContrastOffset;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.www * _SkyLight.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vs_COLOR0.xyz);
					    u_xlat0.xyz = max(u_xlat0.xyz, _AmbientLight.xyz);
					    u_xlat0.xyz = u_xlat0.xyz + (-vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset)));
					    u_xlat0.xyz = u_xlat0.xyz + vec3(_LitBrightness);
					    u_xlat9 = _LitContrast * _LitContrast;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + vec3(vec3(_LitContrastOffset, _LitContrastOffset, _LitContrastOffset));
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz + (-vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset)));
					    u_xlat1.xyz = u_xlat1.xyz + vec3(_TexBrightness);
					    u_xlat9 = _TexContrast * _TexContrast;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + vec3(vec3(_TexContrastOffset, _TexContrastOffset, _TexContrastOffset));
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.xyz = u_xlat10_2.xyz;
					    SV_Target3.xyz = u_xlat10_2.xyz * vs_TEXCOORD4.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat10_2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.xyz = u_xlat10_2.xyz;
					    SV_Target2.w = 1.0;
					    SV_Target3.w = 1.0;
					    return;
					}
					#endif
}
}
Program "fp" {
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
}
SubProgram "gles hw_tier03 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
}
SubProgram "gles3 hw_tier03 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
					
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
					
}
SubProgram "gles hw_tier03 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
					
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
					
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
					
}
SubProgram "gles3 hw_tier03 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
					
}
}
 }
}
Fallback "Mobile/Diffuse"
}