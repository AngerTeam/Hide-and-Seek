Shader "ProFlares/Demo/Bumped Specular" {
Properties {
 _Color ("Main Color", Color) = (1.000000,1.000000,1.000000,1.000000)
 _SpecColor ("Specular Color", Color) = (0.500000,0.500000,0.500000,1.000000)
 _SpecPower ("SpecPower", Range(0.030000,2.000000)) = 0.078125
 _Shininess ("Shininess", Range(0.030000,1.000000)) = 0.078125
 _MainTex ("Base (RGB) Gloss (A)", 2D) = "white" { }
 _SpecTex ("Spec ", 2D) = "white" { }
 _BumpMap ("Normalmap", 2D) = "bump" { }
}
SubShader { 
 LOD 400
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  GpuProgramID 4888
Program "vp" {
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
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
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp float tangentSign_2;
					  lowp vec3 worldTangent_3;
					  lowp vec3 worldNormal_4;
					  highp vec4 tmpvar_5;
					  lowp vec3 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = _glesVertex.xyz;
					  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].x;
					  v_9.y = unity_WorldToObject[1].x;
					  v_9.z = unity_WorldToObject[2].x;
					  v_9.w = unity_WorldToObject[3].x;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].y;
					  v_10.y = unity_WorldToObject[1].y;
					  v_10.z = unity_WorldToObject[2].y;
					  v_10.w = unity_WorldToObject[3].y;
					  highp vec4 v_11;
					  v_11.x = unity_WorldToObject[0].z;
					  v_11.y = unity_WorldToObject[1].z;
					  v_11.z = unity_WorldToObject[2].z;
					  v_11.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize(((
					    (v_9.xyz * _glesNormal.x)
					   + 
					    (v_10.xyz * _glesNormal.y)
					  ) + (v_11.xyz * _glesNormal.z)));
					  worldNormal_4 = tmpvar_12;
					  highp mat3 tmpvar_13;
					  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
					  worldTangent_3 = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_2 = tmpvar_15;
					  lowp vec3 tmpvar_16;
					  tmpvar_16 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * tangentSign_2);
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_3.x;
					  tmpvar_17.y = tmpvar_16.x;
					  tmpvar_17.z = worldNormal_4.x;
					  tmpvar_17.w = tmpvar_8.x;
					  highp vec4 tmpvar_18;
					  tmpvar_18.x = worldTangent_3.y;
					  tmpvar_18.y = tmpvar_16.y;
					  tmpvar_18.z = worldNormal_4.y;
					  tmpvar_18.w = tmpvar_8.y;
					  highp vec4 tmpvar_19;
					  tmpvar_19.x = worldTangent_3.z;
					  tmpvar_19.y = tmpvar_16.z;
					  tmpvar_19.z = worldNormal_4.z;
					  tmpvar_19.w = tmpvar_8.z;
					  lowp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = worldNormal_4;
					  mediump vec4 normal_21;
					  normal_21 = tmpvar_20;
					  mediump vec3 res_22;
					  mediump vec3 x_23;
					  x_23.x = dot (unity_SHAr, normal_21);
					  x_23.y = dot (unity_SHAg, normal_21);
					  x_23.z = dot (unity_SHAb, normal_21);
					  mediump vec3 x1_24;
					  mediump vec4 tmpvar_25;
					  tmpvar_25 = (normal_21.xyzz * normal_21.yzzx);
					  x1_24.x = dot (unity_SHBr, tmpvar_25);
					  x1_24.y = dot (unity_SHBg, tmpvar_25);
					  x1_24.z = dot (unity_SHBb, tmpvar_25);
					  res_22 = (x_23 + (x1_24 + (unity_SHC.xyz * 
					    ((normal_21.x * normal_21.x) - (normal_21.y * normal_21.y))
					  )));
					  res_22 = max (((1.055 * 
					    pow (max (res_22, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_22;
					  tmpvar_6 = shlight_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_7);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_17;
					  xlv_TEXCOORD2 = tmpvar_18;
					  xlv_TEXCOORD3 = tmpvar_19;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = tmpvar_6;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _MainTex;
					uniform sampler2D _SpecTex;
					uniform sampler2D _BumpMap;
					uniform lowp vec4 _Color;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldN_1;
					  lowp vec4 c_2;
					  lowp vec3 worldViewDir_3;
					  lowp vec3 lightDir_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5.x = xlv_TEXCOORD1.w;
					  tmpvar_5.y = xlv_TEXCOORD2.w;
					  tmpvar_5.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_4 = tmpvar_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_5));
					  worldViewDir_3 = tmpvar_7;
					  lowp vec3 tmpvar_8;
					  mediump float tmpvar_9;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = (texture2D (_SpecTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  tmpvar_8 = (tmpvar_10.xyz * _Color.xyz);
					  tmpvar_9 = tmpvar_10.w;
					  lowp vec3 tmpvar_12;
					  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
					  c_2.w = 0.0;
					  highp float tmpvar_13;
					  tmpvar_13 = dot (xlv_TEXCOORD1.xyz, tmpvar_12);
					  worldN_1.x = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = dot (xlv_TEXCOORD2.xyz, tmpvar_12);
					  worldN_1.y = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = dot (xlv_TEXCOORD3.xyz, tmpvar_12);
					  worldN_1.z = tmpvar_15;
					  c_2.xyz = (tmpvar_8 * xlv_TEXCOORD4);
					  mediump vec4 tmpvar_16;
					  mediump vec3 viewDir_17;
					  viewDir_17 = worldViewDir_3;
					  lowp vec4 c_18;
					  highp float nh_19;
					  mediump float tmpvar_20;
					  tmpvar_20 = max (0.0, dot (worldN_1, normalize(
					    (lightDir_4 + viewDir_17)
					  )));
					  nh_19 = tmpvar_20;
					  mediump float y_21;
					  y_21 = (tmpvar_9 * 128.0);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow (nh_19, y_21) * tmpvar_11.x);
					  c_18.xyz = (((
					    (tmpvar_8 * _LightColor0.xyz)
					   * 
					    max (0.0, dot (worldN_1, lightDir_4))
					  ) + (
					    (_LightColor0.xyz * _SpecColor.xyz)
					   * tmpvar_22)) * 2.0);
					  c_18.w = ((tmpvar_10.w * _Color.w) + ((_LightColor0.w * _SpecColor.w) * tmpvar_22));
					  tmpvar_16 = c_18;
					  c_2.xyz = (c_2 + tmpvar_16).xyz;
					  c_2.w = 1.0;
					  gl_FragData[0] = c_2;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
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
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp float tangentSign_2;
					  lowp vec3 worldTangent_3;
					  lowp vec3 worldNormal_4;
					  highp vec4 tmpvar_5;
					  lowp vec3 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = _glesVertex.xyz;
					  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].x;
					  v_9.y = unity_WorldToObject[1].x;
					  v_9.z = unity_WorldToObject[2].x;
					  v_9.w = unity_WorldToObject[3].x;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].y;
					  v_10.y = unity_WorldToObject[1].y;
					  v_10.z = unity_WorldToObject[2].y;
					  v_10.w = unity_WorldToObject[3].y;
					  highp vec4 v_11;
					  v_11.x = unity_WorldToObject[0].z;
					  v_11.y = unity_WorldToObject[1].z;
					  v_11.z = unity_WorldToObject[2].z;
					  v_11.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize(((
					    (v_9.xyz * _glesNormal.x)
					   + 
					    (v_10.xyz * _glesNormal.y)
					  ) + (v_11.xyz * _glesNormal.z)));
					  worldNormal_4 = tmpvar_12;
					  highp mat3 tmpvar_13;
					  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
					  worldTangent_3 = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_2 = tmpvar_15;
					  lowp vec3 tmpvar_16;
					  tmpvar_16 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * tangentSign_2);
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_3.x;
					  tmpvar_17.y = tmpvar_16.x;
					  tmpvar_17.z = worldNormal_4.x;
					  tmpvar_17.w = tmpvar_8.x;
					  highp vec4 tmpvar_18;
					  tmpvar_18.x = worldTangent_3.y;
					  tmpvar_18.y = tmpvar_16.y;
					  tmpvar_18.z = worldNormal_4.y;
					  tmpvar_18.w = tmpvar_8.y;
					  highp vec4 tmpvar_19;
					  tmpvar_19.x = worldTangent_3.z;
					  tmpvar_19.y = tmpvar_16.z;
					  tmpvar_19.z = worldNormal_4.z;
					  tmpvar_19.w = tmpvar_8.z;
					  lowp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = worldNormal_4;
					  mediump vec4 normal_21;
					  normal_21 = tmpvar_20;
					  mediump vec3 res_22;
					  mediump vec3 x_23;
					  x_23.x = dot (unity_SHAr, normal_21);
					  x_23.y = dot (unity_SHAg, normal_21);
					  x_23.z = dot (unity_SHAb, normal_21);
					  mediump vec3 x1_24;
					  mediump vec4 tmpvar_25;
					  tmpvar_25 = (normal_21.xyzz * normal_21.yzzx);
					  x1_24.x = dot (unity_SHBr, tmpvar_25);
					  x1_24.y = dot (unity_SHBg, tmpvar_25);
					  x1_24.z = dot (unity_SHBb, tmpvar_25);
					  res_22 = (x_23 + (x1_24 + (unity_SHC.xyz * 
					    ((normal_21.x * normal_21.x) - (normal_21.y * normal_21.y))
					  )));
					  res_22 = max (((1.055 * 
					    pow (max (res_22, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_22;
					  tmpvar_6 = shlight_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_7);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_17;
					  xlv_TEXCOORD2 = tmpvar_18;
					  xlv_TEXCOORD3 = tmpvar_19;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = tmpvar_6;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _MainTex;
					uniform sampler2D _SpecTex;
					uniform sampler2D _BumpMap;
					uniform lowp vec4 _Color;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldN_1;
					  lowp vec4 c_2;
					  lowp vec3 worldViewDir_3;
					  lowp vec3 lightDir_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5.x = xlv_TEXCOORD1.w;
					  tmpvar_5.y = xlv_TEXCOORD2.w;
					  tmpvar_5.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_4 = tmpvar_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_5));
					  worldViewDir_3 = tmpvar_7;
					  lowp vec3 tmpvar_8;
					  mediump float tmpvar_9;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = (texture2D (_SpecTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  tmpvar_8 = (tmpvar_10.xyz * _Color.xyz);
					  tmpvar_9 = tmpvar_10.w;
					  lowp vec3 tmpvar_12;
					  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
					  c_2.w = 0.0;
					  highp float tmpvar_13;
					  tmpvar_13 = dot (xlv_TEXCOORD1.xyz, tmpvar_12);
					  worldN_1.x = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = dot (xlv_TEXCOORD2.xyz, tmpvar_12);
					  worldN_1.y = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = dot (xlv_TEXCOORD3.xyz, tmpvar_12);
					  worldN_1.z = tmpvar_15;
					  c_2.xyz = (tmpvar_8 * xlv_TEXCOORD4);
					  mediump vec4 tmpvar_16;
					  mediump vec3 viewDir_17;
					  viewDir_17 = worldViewDir_3;
					  lowp vec4 c_18;
					  highp float nh_19;
					  mediump float tmpvar_20;
					  tmpvar_20 = max (0.0, dot (worldN_1, normalize(
					    (lightDir_4 + viewDir_17)
					  )));
					  nh_19 = tmpvar_20;
					  mediump float y_21;
					  y_21 = (tmpvar_9 * 128.0);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow (nh_19, y_21) * tmpvar_11.x);
					  c_18.xyz = (((
					    (tmpvar_8 * _LightColor0.xyz)
					   * 
					    max (0.0, dot (worldN_1, lightDir_4))
					  ) + (
					    (_LightColor0.xyz * _SpecColor.xyz)
					   * tmpvar_22)) * 2.0);
					  c_18.w = ((tmpvar_10.w * _Color.w) + ((_LightColor0.w * _SpecColor.w) * tmpvar_22));
					  tmpvar_16 = c_18;
					  c_2.xyz = (c_2 + tmpvar_16).xyz;
					  c_2.w = 1.0;
					  gl_FragData[0] = c_2;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
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
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp float tangentSign_2;
					  lowp vec3 worldTangent_3;
					  lowp vec3 worldNormal_4;
					  highp vec4 tmpvar_5;
					  lowp vec3 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = _glesVertex.xyz;
					  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].x;
					  v_9.y = unity_WorldToObject[1].x;
					  v_9.z = unity_WorldToObject[2].x;
					  v_9.w = unity_WorldToObject[3].x;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].y;
					  v_10.y = unity_WorldToObject[1].y;
					  v_10.z = unity_WorldToObject[2].y;
					  v_10.w = unity_WorldToObject[3].y;
					  highp vec4 v_11;
					  v_11.x = unity_WorldToObject[0].z;
					  v_11.y = unity_WorldToObject[1].z;
					  v_11.z = unity_WorldToObject[2].z;
					  v_11.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize(((
					    (v_9.xyz * _glesNormal.x)
					   + 
					    (v_10.xyz * _glesNormal.y)
					  ) + (v_11.xyz * _glesNormal.z)));
					  worldNormal_4 = tmpvar_12;
					  highp mat3 tmpvar_13;
					  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
					  worldTangent_3 = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_2 = tmpvar_15;
					  lowp vec3 tmpvar_16;
					  tmpvar_16 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * tangentSign_2);
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_3.x;
					  tmpvar_17.y = tmpvar_16.x;
					  tmpvar_17.z = worldNormal_4.x;
					  tmpvar_17.w = tmpvar_8.x;
					  highp vec4 tmpvar_18;
					  tmpvar_18.x = worldTangent_3.y;
					  tmpvar_18.y = tmpvar_16.y;
					  tmpvar_18.z = worldNormal_4.y;
					  tmpvar_18.w = tmpvar_8.y;
					  highp vec4 tmpvar_19;
					  tmpvar_19.x = worldTangent_3.z;
					  tmpvar_19.y = tmpvar_16.z;
					  tmpvar_19.z = worldNormal_4.z;
					  tmpvar_19.w = tmpvar_8.z;
					  lowp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = worldNormal_4;
					  mediump vec4 normal_21;
					  normal_21 = tmpvar_20;
					  mediump vec3 res_22;
					  mediump vec3 x_23;
					  x_23.x = dot (unity_SHAr, normal_21);
					  x_23.y = dot (unity_SHAg, normal_21);
					  x_23.z = dot (unity_SHAb, normal_21);
					  mediump vec3 x1_24;
					  mediump vec4 tmpvar_25;
					  tmpvar_25 = (normal_21.xyzz * normal_21.yzzx);
					  x1_24.x = dot (unity_SHBr, tmpvar_25);
					  x1_24.y = dot (unity_SHBg, tmpvar_25);
					  x1_24.z = dot (unity_SHBb, tmpvar_25);
					  res_22 = (x_23 + (x1_24 + (unity_SHC.xyz * 
					    ((normal_21.x * normal_21.x) - (normal_21.y * normal_21.y))
					  )));
					  res_22 = max (((1.055 * 
					    pow (max (res_22, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_22;
					  tmpvar_6 = shlight_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_7);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_17;
					  xlv_TEXCOORD2 = tmpvar_18;
					  xlv_TEXCOORD3 = tmpvar_19;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = tmpvar_6;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _MainTex;
					uniform sampler2D _SpecTex;
					uniform sampler2D _BumpMap;
					uniform lowp vec4 _Color;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldN_1;
					  lowp vec4 c_2;
					  lowp vec3 worldViewDir_3;
					  lowp vec3 lightDir_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5.x = xlv_TEXCOORD1.w;
					  tmpvar_5.y = xlv_TEXCOORD2.w;
					  tmpvar_5.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_4 = tmpvar_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_5));
					  worldViewDir_3 = tmpvar_7;
					  lowp vec3 tmpvar_8;
					  mediump float tmpvar_9;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = (texture2D (_SpecTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  tmpvar_8 = (tmpvar_10.xyz * _Color.xyz);
					  tmpvar_9 = tmpvar_10.w;
					  lowp vec3 tmpvar_12;
					  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
					  c_2.w = 0.0;
					  highp float tmpvar_13;
					  tmpvar_13 = dot (xlv_TEXCOORD1.xyz, tmpvar_12);
					  worldN_1.x = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = dot (xlv_TEXCOORD2.xyz, tmpvar_12);
					  worldN_1.y = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = dot (xlv_TEXCOORD3.xyz, tmpvar_12);
					  worldN_1.z = tmpvar_15;
					  c_2.xyz = (tmpvar_8 * xlv_TEXCOORD4);
					  mediump vec4 tmpvar_16;
					  mediump vec3 viewDir_17;
					  viewDir_17 = worldViewDir_3;
					  lowp vec4 c_18;
					  highp float nh_19;
					  mediump float tmpvar_20;
					  tmpvar_20 = max (0.0, dot (worldN_1, normalize(
					    (lightDir_4 + viewDir_17)
					  )));
					  nh_19 = tmpvar_20;
					  mediump float y_21;
					  y_21 = (tmpvar_9 * 128.0);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow (nh_19, y_21) * tmpvar_11.x);
					  c_18.xyz = (((
					    (tmpvar_8 * _LightColor0.xyz)
					   * 
					    max (0.0, dot (worldN_1, lightDir_4))
					  ) + (
					    (_LightColor0.xyz * _SpecColor.xyz)
					   * tmpvar_22)) * 2.0);
					  c_18.w = ((tmpvar_10.w * _Color.w) + ((_LightColor0.w * _SpecColor.w) * tmpvar_22));
					  tmpvar_16 = c_18;
					  c_2.xyz = (c_2 + tmpvar_16).xyz;
					  c_2.w = 1.0;
					  gl_FragData[0] = c_2;
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
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out lowp vec4 vs_COLOR0;
					out lowp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					lowp vec3 u_xlat10_4;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_TEXCOORD1.w = u_xlat0.x;
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    u_xlat2.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat2.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat2.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat3.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat3.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat3.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat3.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat3.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat3.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
					    u_xlat10_4.xyz = u_xlat1.xyz * u_xlat2.zxy;
					    u_xlat10_4.xyz = u_xlat2.yzx * u_xlat1.yzx + (-u_xlat10_4.xyz);
					    u_xlat10_4.xyz = u_xlat0.xxx * u_xlat10_4.xyz;
					    vs_TEXCOORD1.y = u_xlat10_4.x;
					    vs_TEXCOORD1.x = u_xlat1.z;
					    vs_TEXCOORD1.z = u_xlat2.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD2.w = u_xlat0.y;
					    vs_TEXCOORD3.w = u_xlat0.z;
					    vs_TEXCOORD2.y = u_xlat10_4.y;
					    vs_TEXCOORD3.y = u_xlat10_4.z;
					    vs_TEXCOORD2.z = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat2.z;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat16_5.x = u_xlat2.y * u_xlat2.y;
					    u_xlat16_5.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_5.x);
					    u_xlat16_0 = u_xlat2.yzzx * u_xlat2.xyzz;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
					    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
					    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
					    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
					    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_5.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD4.xyz = u_xlat1.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp vec4 _SpecColor;
					uniform 	lowp vec4 _Color;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _SpecTex;
					uniform lowp sampler2D _BumpMap;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in lowp vec4 vs_COLOR0;
					in lowp vec3 vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_4;
					mediump float u_xlat16_5;
					lowp float u_xlat10_5;
					lowp vec3 u_xlat10_7;
					float u_xlat15;
					mediump float u_xlat16_16;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD1.w;
					    u_xlat0.y = vs_TEXCOORD2.w;
					    u_xlat0.z = vs_TEXCOORD3.w;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
					    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
					    u_xlat16_16 = inversesqrt(u_xlat16_16);
					    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
					    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
					    u_xlat10_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat10_2.xyz);
					    u_xlat0.y = dot(vs_TEXCOORD2.xyz, u_xlat10_2.xyz);
					    u_xlat0.z = dot(vs_TEXCOORD3.xyz, u_xlat10_2.xyz);
					    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
					    u_xlat10_2.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat10_2.x = max(u_xlat10_2.x, 0.0);
					    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
					    u_xlat16_0.x = log2(u_xlat16_1.x);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = u_xlat10_1 * vs_COLOR0;
					    u_xlat16_3.x = u_xlat16_1.w * 128.0;
					    u_xlat10_7.xyz = u_xlat16_1.xyz * _Color.xyz;
					    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_3.x;
					    u_xlat16_0.x = exp2(u_xlat16_0.x);
					    u_xlat10_5 = texture(_SpecTex, vs_TEXCOORD0.xy).x;
					    u_xlat16_5 = u_xlat10_5 * vs_COLOR0.x;
					    u_xlat16_0.x = u_xlat16_5 * u_xlat16_0.x;
					    u_xlat10_4.xyz = _LightColor0.xyz * _SpecColor.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat10_4.xyz;
					    u_xlat10_4.xyz = u_xlat10_7.xyz * _LightColor0.xyz;
					    u_xlat16_0.xyz = u_xlat10_4.xyz * u_xlat10_2.xxx + u_xlat16_0.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = u_xlat10_7.xyz * vs_TEXCOORD4.xyz + u_xlat16_0.xyz;
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
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out lowp vec4 vs_COLOR0;
					out lowp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					lowp vec3 u_xlat10_4;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_TEXCOORD1.w = u_xlat0.x;
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    u_xlat2.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat2.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat2.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat3.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat3.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat3.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat3.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat3.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat3.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
					    u_xlat10_4.xyz = u_xlat1.xyz * u_xlat2.zxy;
					    u_xlat10_4.xyz = u_xlat2.yzx * u_xlat1.yzx + (-u_xlat10_4.xyz);
					    u_xlat10_4.xyz = u_xlat0.xxx * u_xlat10_4.xyz;
					    vs_TEXCOORD1.y = u_xlat10_4.x;
					    vs_TEXCOORD1.x = u_xlat1.z;
					    vs_TEXCOORD1.z = u_xlat2.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD2.w = u_xlat0.y;
					    vs_TEXCOORD3.w = u_xlat0.z;
					    vs_TEXCOORD2.y = u_xlat10_4.y;
					    vs_TEXCOORD3.y = u_xlat10_4.z;
					    vs_TEXCOORD2.z = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat2.z;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat16_5.x = u_xlat2.y * u_xlat2.y;
					    u_xlat16_5.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_5.x);
					    u_xlat16_0 = u_xlat2.yzzx * u_xlat2.xyzz;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
					    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
					    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
					    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
					    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_5.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD4.xyz = u_xlat1.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp vec4 _SpecColor;
					uniform 	lowp vec4 _Color;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _SpecTex;
					uniform lowp sampler2D _BumpMap;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in lowp vec4 vs_COLOR0;
					in lowp vec3 vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_4;
					mediump float u_xlat16_5;
					lowp float u_xlat10_5;
					lowp vec3 u_xlat10_7;
					float u_xlat15;
					mediump float u_xlat16_16;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD1.w;
					    u_xlat0.y = vs_TEXCOORD2.w;
					    u_xlat0.z = vs_TEXCOORD3.w;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
					    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
					    u_xlat16_16 = inversesqrt(u_xlat16_16);
					    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
					    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
					    u_xlat10_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat10_2.xyz);
					    u_xlat0.y = dot(vs_TEXCOORD2.xyz, u_xlat10_2.xyz);
					    u_xlat0.z = dot(vs_TEXCOORD3.xyz, u_xlat10_2.xyz);
					    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
					    u_xlat10_2.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat10_2.x = max(u_xlat10_2.x, 0.0);
					    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
					    u_xlat16_0.x = log2(u_xlat16_1.x);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = u_xlat10_1 * vs_COLOR0;
					    u_xlat16_3.x = u_xlat16_1.w * 128.0;
					    u_xlat10_7.xyz = u_xlat16_1.xyz * _Color.xyz;
					    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_3.x;
					    u_xlat16_0.x = exp2(u_xlat16_0.x);
					    u_xlat10_5 = texture(_SpecTex, vs_TEXCOORD0.xy).x;
					    u_xlat16_5 = u_xlat10_5 * vs_COLOR0.x;
					    u_xlat16_0.x = u_xlat16_5 * u_xlat16_0.x;
					    u_xlat10_4.xyz = _LightColor0.xyz * _SpecColor.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat10_4.xyz;
					    u_xlat10_4.xyz = u_xlat10_7.xyz * _LightColor0.xyz;
					    u_xlat16_0.xyz = u_xlat10_4.xyz * u_xlat10_2.xxx + u_xlat16_0.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = u_xlat10_7.xyz * vs_TEXCOORD4.xyz + u_xlat16_0.xyz;
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
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out lowp vec4 vs_COLOR0;
					out lowp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					lowp vec3 u_xlat10_4;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_TEXCOORD1.w = u_xlat0.x;
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    u_xlat2.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat2.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat2.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat3.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat3.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat3.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat3.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat3.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat3.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
					    u_xlat10_4.xyz = u_xlat1.xyz * u_xlat2.zxy;
					    u_xlat10_4.xyz = u_xlat2.yzx * u_xlat1.yzx + (-u_xlat10_4.xyz);
					    u_xlat10_4.xyz = u_xlat0.xxx * u_xlat10_4.xyz;
					    vs_TEXCOORD1.y = u_xlat10_4.x;
					    vs_TEXCOORD1.x = u_xlat1.z;
					    vs_TEXCOORD1.z = u_xlat2.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD2.w = u_xlat0.y;
					    vs_TEXCOORD3.w = u_xlat0.z;
					    vs_TEXCOORD2.y = u_xlat10_4.y;
					    vs_TEXCOORD3.y = u_xlat10_4.z;
					    vs_TEXCOORD2.z = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat2.z;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat16_5.x = u_xlat2.y * u_xlat2.y;
					    u_xlat16_5.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_5.x);
					    u_xlat16_0 = u_xlat2.yzzx * u_xlat2.xyzz;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
					    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
					    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
					    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
					    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_5.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD4.xyz = u_xlat1.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp vec4 _SpecColor;
					uniform 	lowp vec4 _Color;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _SpecTex;
					uniform lowp sampler2D _BumpMap;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in lowp vec4 vs_COLOR0;
					in lowp vec3 vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_4;
					mediump float u_xlat16_5;
					lowp float u_xlat10_5;
					lowp vec3 u_xlat10_7;
					float u_xlat15;
					mediump float u_xlat16_16;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD1.w;
					    u_xlat0.y = vs_TEXCOORD2.w;
					    u_xlat0.z = vs_TEXCOORD3.w;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
					    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
					    u_xlat16_16 = inversesqrt(u_xlat16_16);
					    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
					    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
					    u_xlat10_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat10_2.xyz);
					    u_xlat0.y = dot(vs_TEXCOORD2.xyz, u_xlat10_2.xyz);
					    u_xlat0.z = dot(vs_TEXCOORD3.xyz, u_xlat10_2.xyz);
					    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
					    u_xlat10_2.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat10_2.x = max(u_xlat10_2.x, 0.0);
					    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
					    u_xlat16_0.x = log2(u_xlat16_1.x);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = u_xlat10_1 * vs_COLOR0;
					    u_xlat16_3.x = u_xlat16_1.w * 128.0;
					    u_xlat10_7.xyz = u_xlat16_1.xyz * _Color.xyz;
					    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_3.x;
					    u_xlat16_0.x = exp2(u_xlat16_0.x);
					    u_xlat10_5 = texture(_SpecTex, vs_TEXCOORD0.xy).x;
					    u_xlat16_5 = u_xlat10_5 * vs_COLOR0.x;
					    u_xlat16_0.x = u_xlat16_5 * u_xlat16_0.x;
					    u_xlat10_4.xyz = _LightColor0.xyz * _SpecColor.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat10_4.xyz;
					    u_xlat10_4.xyz = u_xlat10_7.xyz * _LightColor0.xyz;
					    u_xlat16_0.xyz = u_xlat10_4.xyz * u_xlat10_2.xxx + u_xlat16_0.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = u_xlat10_7.xyz * vs_TEXCOORD4.xyz + u_xlat16_0.xyz;
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
					attribute vec4 _glesTANGENT;
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
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp float tangentSign_2;
					  lowp vec3 worldTangent_3;
					  lowp vec3 worldNormal_4;
					  highp vec4 tmpvar_5;
					  lowp vec3 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = _glesVertex.xyz;
					  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  highp vec3 tmpvar_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
					  tmpvar_8 = tmpvar_9.xyz;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].x;
					  v_10.y = unity_WorldToObject[1].x;
					  v_10.z = unity_WorldToObject[2].x;
					  v_10.w = unity_WorldToObject[3].x;
					  highp vec4 v_11;
					  v_11.x = unity_WorldToObject[0].y;
					  v_11.y = unity_WorldToObject[1].y;
					  v_11.z = unity_WorldToObject[2].y;
					  v_11.w = unity_WorldToObject[3].y;
					  highp vec4 v_12;
					  v_12.x = unity_WorldToObject[0].z;
					  v_12.y = unity_WorldToObject[1].z;
					  v_12.z = unity_WorldToObject[2].z;
					  v_12.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize(((
					    (v_10.xyz * _glesNormal.x)
					   + 
					    (v_11.xyz * _glesNormal.y)
					  ) + (v_12.xyz * _glesNormal.z)));
					  worldNormal_4 = tmpvar_13;
					  highp mat3 tmpvar_14;
					  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_15;
					  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
					  worldTangent_3 = tmpvar_15;
					  highp float tmpvar_16;
					  tmpvar_16 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_2 = tmpvar_16;
					  lowp vec3 tmpvar_17;
					  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * tangentSign_2);
					  highp vec4 tmpvar_18;
					  tmpvar_18.x = worldTangent_3.x;
					  tmpvar_18.y = tmpvar_17.x;
					  tmpvar_18.z = worldNormal_4.x;
					  tmpvar_18.w = tmpvar_8.x;
					  highp vec4 tmpvar_19;
					  tmpvar_19.x = worldTangent_3.y;
					  tmpvar_19.y = tmpvar_17.y;
					  tmpvar_19.z = worldNormal_4.y;
					  tmpvar_19.w = tmpvar_8.y;
					  highp vec4 tmpvar_20;
					  tmpvar_20.x = worldTangent_3.z;
					  tmpvar_20.y = tmpvar_17.z;
					  tmpvar_20.z = worldNormal_4.z;
					  tmpvar_20.w = tmpvar_8.z;
					  lowp vec4 tmpvar_21;
					  tmpvar_21.w = 1.0;
					  tmpvar_21.xyz = worldNormal_4;
					  mediump vec4 normal_22;
					  normal_22 = tmpvar_21;
					  mediump vec3 res_23;
					  mediump vec3 x_24;
					  x_24.x = dot (unity_SHAr, normal_22);
					  x_24.y = dot (unity_SHAg, normal_22);
					  x_24.z = dot (unity_SHAb, normal_22);
					  mediump vec3 x1_25;
					  mediump vec4 tmpvar_26;
					  tmpvar_26 = (normal_22.xyzz * normal_22.yzzx);
					  x1_25.x = dot (unity_SHBr, tmpvar_26);
					  x1_25.y = dot (unity_SHBg, tmpvar_26);
					  x1_25.z = dot (unity_SHBb, tmpvar_26);
					  res_23 = (x_24 + (x1_25 + (unity_SHC.xyz * 
					    ((normal_22.x * normal_22.x) - (normal_22.y * normal_22.y))
					  )));
					  res_23 = max (((1.055 * 
					    pow (max (res_23, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_23;
					  tmpvar_6 = shlight_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_7);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_18;
					  xlv_TEXCOORD2 = tmpvar_19;
					  xlv_TEXCOORD3 = tmpvar_20;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = tmpvar_6;
					  xlv_TEXCOORD5 = (unity_WorldToShadow[0] * tmpvar_9);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 _LightShadowData;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform sampler2D _SpecTex;
					uniform sampler2D _BumpMap;
					uniform lowp vec4 _Color;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					void main ()
					{
					  lowp vec3 worldN_1;
					  lowp vec4 c_2;
					  lowp vec3 worldViewDir_3;
					  lowp vec3 lightDir_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5.x = xlv_TEXCOORD1.w;
					  tmpvar_5.y = xlv_TEXCOORD2.w;
					  tmpvar_5.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_4 = tmpvar_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_5));
					  worldViewDir_3 = tmpvar_7;
					  lowp vec3 tmpvar_8;
					  mediump float tmpvar_9;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = (texture2D (_SpecTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  tmpvar_8 = (tmpvar_10.xyz * _Color.xyz);
					  tmpvar_9 = tmpvar_10.w;
					  lowp vec3 tmpvar_12;
					  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
					  lowp float tmpvar_13;
					  highp float lightShadowDataX_14;
					  mediump float tmpvar_15;
					  tmpvar_15 = _LightShadowData.x;
					  lightShadowDataX_14 = tmpvar_15;
					  highp float tmpvar_16;
					  tmpvar_16 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD5.xy).x > xlv_TEXCOORD5.z)), lightShadowDataX_14);
					  tmpvar_13 = tmpvar_16;
					  c_2.w = 0.0;
					  highp float tmpvar_17;
					  tmpvar_17 = dot (xlv_TEXCOORD1.xyz, tmpvar_12);
					  worldN_1.x = tmpvar_17;
					  highp float tmpvar_18;
					  tmpvar_18 = dot (xlv_TEXCOORD2.xyz, tmpvar_12);
					  worldN_1.y = tmpvar_18;
					  highp float tmpvar_19;
					  tmpvar_19 = dot (xlv_TEXCOORD3.xyz, tmpvar_12);
					  worldN_1.z = tmpvar_19;
					  c_2.xyz = (tmpvar_8 * xlv_TEXCOORD4);
					  mediump vec4 tmpvar_20;
					  mediump vec3 viewDir_21;
					  viewDir_21 = worldViewDir_3;
					  lowp vec4 c_22;
					  highp float nh_23;
					  mediump float tmpvar_24;
					  tmpvar_24 = max (0.0, dot (worldN_1, normalize(
					    (lightDir_4 + viewDir_21)
					  )));
					  nh_23 = tmpvar_24;
					  mediump float y_25;
					  y_25 = (tmpvar_9 * 128.0);
					  highp float tmpvar_26;
					  tmpvar_26 = (pow (nh_23, y_25) * tmpvar_11.x);
					  c_22.xyz = (((
					    (tmpvar_8 * _LightColor0.xyz)
					   * 
					    max (0.0, dot (worldN_1, lightDir_4))
					  ) + (
					    (_LightColor0.xyz * _SpecColor.xyz)
					   * tmpvar_26)) * (tmpvar_13 * 2.0));
					  c_22.w = ((tmpvar_10.w * _Color.w) + ((_LightColor0.w * _SpecColor.w) * (tmpvar_26 * tmpvar_13)));
					  tmpvar_20 = c_22;
					  c_2.xyz = (c_2 + tmpvar_20).xyz;
					  c_2.w = 1.0;
					  gl_FragData[0] = c_2;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
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
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp float tangentSign_2;
					  lowp vec3 worldTangent_3;
					  lowp vec3 worldNormal_4;
					  highp vec4 tmpvar_5;
					  lowp vec3 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = _glesVertex.xyz;
					  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  highp vec3 tmpvar_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
					  tmpvar_8 = tmpvar_9.xyz;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].x;
					  v_10.y = unity_WorldToObject[1].x;
					  v_10.z = unity_WorldToObject[2].x;
					  v_10.w = unity_WorldToObject[3].x;
					  highp vec4 v_11;
					  v_11.x = unity_WorldToObject[0].y;
					  v_11.y = unity_WorldToObject[1].y;
					  v_11.z = unity_WorldToObject[2].y;
					  v_11.w = unity_WorldToObject[3].y;
					  highp vec4 v_12;
					  v_12.x = unity_WorldToObject[0].z;
					  v_12.y = unity_WorldToObject[1].z;
					  v_12.z = unity_WorldToObject[2].z;
					  v_12.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize(((
					    (v_10.xyz * _glesNormal.x)
					   + 
					    (v_11.xyz * _glesNormal.y)
					  ) + (v_12.xyz * _glesNormal.z)));
					  worldNormal_4 = tmpvar_13;
					  highp mat3 tmpvar_14;
					  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_15;
					  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
					  worldTangent_3 = tmpvar_15;
					  highp float tmpvar_16;
					  tmpvar_16 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_2 = tmpvar_16;
					  lowp vec3 tmpvar_17;
					  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * tangentSign_2);
					  highp vec4 tmpvar_18;
					  tmpvar_18.x = worldTangent_3.x;
					  tmpvar_18.y = tmpvar_17.x;
					  tmpvar_18.z = worldNormal_4.x;
					  tmpvar_18.w = tmpvar_8.x;
					  highp vec4 tmpvar_19;
					  tmpvar_19.x = worldTangent_3.y;
					  tmpvar_19.y = tmpvar_17.y;
					  tmpvar_19.z = worldNormal_4.y;
					  tmpvar_19.w = tmpvar_8.y;
					  highp vec4 tmpvar_20;
					  tmpvar_20.x = worldTangent_3.z;
					  tmpvar_20.y = tmpvar_17.z;
					  tmpvar_20.z = worldNormal_4.z;
					  tmpvar_20.w = tmpvar_8.z;
					  lowp vec4 tmpvar_21;
					  tmpvar_21.w = 1.0;
					  tmpvar_21.xyz = worldNormal_4;
					  mediump vec4 normal_22;
					  normal_22 = tmpvar_21;
					  mediump vec3 res_23;
					  mediump vec3 x_24;
					  x_24.x = dot (unity_SHAr, normal_22);
					  x_24.y = dot (unity_SHAg, normal_22);
					  x_24.z = dot (unity_SHAb, normal_22);
					  mediump vec3 x1_25;
					  mediump vec4 tmpvar_26;
					  tmpvar_26 = (normal_22.xyzz * normal_22.yzzx);
					  x1_25.x = dot (unity_SHBr, tmpvar_26);
					  x1_25.y = dot (unity_SHBg, tmpvar_26);
					  x1_25.z = dot (unity_SHBb, tmpvar_26);
					  res_23 = (x_24 + (x1_25 + (unity_SHC.xyz * 
					    ((normal_22.x * normal_22.x) - (normal_22.y * normal_22.y))
					  )));
					  res_23 = max (((1.055 * 
					    pow (max (res_23, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_23;
					  tmpvar_6 = shlight_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_7);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_18;
					  xlv_TEXCOORD2 = tmpvar_19;
					  xlv_TEXCOORD3 = tmpvar_20;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = tmpvar_6;
					  xlv_TEXCOORD5 = (unity_WorldToShadow[0] * tmpvar_9);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 _LightShadowData;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform sampler2D _SpecTex;
					uniform sampler2D _BumpMap;
					uniform lowp vec4 _Color;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					void main ()
					{
					  lowp vec3 worldN_1;
					  lowp vec4 c_2;
					  lowp vec3 worldViewDir_3;
					  lowp vec3 lightDir_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5.x = xlv_TEXCOORD1.w;
					  tmpvar_5.y = xlv_TEXCOORD2.w;
					  tmpvar_5.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_4 = tmpvar_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_5));
					  worldViewDir_3 = tmpvar_7;
					  lowp vec3 tmpvar_8;
					  mediump float tmpvar_9;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = (texture2D (_SpecTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  tmpvar_8 = (tmpvar_10.xyz * _Color.xyz);
					  tmpvar_9 = tmpvar_10.w;
					  lowp vec3 tmpvar_12;
					  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
					  lowp float tmpvar_13;
					  highp float lightShadowDataX_14;
					  mediump float tmpvar_15;
					  tmpvar_15 = _LightShadowData.x;
					  lightShadowDataX_14 = tmpvar_15;
					  highp float tmpvar_16;
					  tmpvar_16 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD5.xy).x > xlv_TEXCOORD5.z)), lightShadowDataX_14);
					  tmpvar_13 = tmpvar_16;
					  c_2.w = 0.0;
					  highp float tmpvar_17;
					  tmpvar_17 = dot (xlv_TEXCOORD1.xyz, tmpvar_12);
					  worldN_1.x = tmpvar_17;
					  highp float tmpvar_18;
					  tmpvar_18 = dot (xlv_TEXCOORD2.xyz, tmpvar_12);
					  worldN_1.y = tmpvar_18;
					  highp float tmpvar_19;
					  tmpvar_19 = dot (xlv_TEXCOORD3.xyz, tmpvar_12);
					  worldN_1.z = tmpvar_19;
					  c_2.xyz = (tmpvar_8 * xlv_TEXCOORD4);
					  mediump vec4 tmpvar_20;
					  mediump vec3 viewDir_21;
					  viewDir_21 = worldViewDir_3;
					  lowp vec4 c_22;
					  highp float nh_23;
					  mediump float tmpvar_24;
					  tmpvar_24 = max (0.0, dot (worldN_1, normalize(
					    (lightDir_4 + viewDir_21)
					  )));
					  nh_23 = tmpvar_24;
					  mediump float y_25;
					  y_25 = (tmpvar_9 * 128.0);
					  highp float tmpvar_26;
					  tmpvar_26 = (pow (nh_23, y_25) * tmpvar_11.x);
					  c_22.xyz = (((
					    (tmpvar_8 * _LightColor0.xyz)
					   * 
					    max (0.0, dot (worldN_1, lightDir_4))
					  ) + (
					    (_LightColor0.xyz * _SpecColor.xyz)
					   * tmpvar_26)) * (tmpvar_13 * 2.0));
					  c_22.w = ((tmpvar_10.w * _Color.w) + ((_LightColor0.w * _SpecColor.w) * (tmpvar_26 * tmpvar_13)));
					  tmpvar_20 = c_22;
					  c_2.xyz = (c_2 + tmpvar_20).xyz;
					  c_2.w = 1.0;
					  gl_FragData[0] = c_2;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
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
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp float tangentSign_2;
					  lowp vec3 worldTangent_3;
					  lowp vec3 worldNormal_4;
					  highp vec4 tmpvar_5;
					  lowp vec3 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = _glesVertex.xyz;
					  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  highp vec3 tmpvar_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
					  tmpvar_8 = tmpvar_9.xyz;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].x;
					  v_10.y = unity_WorldToObject[1].x;
					  v_10.z = unity_WorldToObject[2].x;
					  v_10.w = unity_WorldToObject[3].x;
					  highp vec4 v_11;
					  v_11.x = unity_WorldToObject[0].y;
					  v_11.y = unity_WorldToObject[1].y;
					  v_11.z = unity_WorldToObject[2].y;
					  v_11.w = unity_WorldToObject[3].y;
					  highp vec4 v_12;
					  v_12.x = unity_WorldToObject[0].z;
					  v_12.y = unity_WorldToObject[1].z;
					  v_12.z = unity_WorldToObject[2].z;
					  v_12.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize(((
					    (v_10.xyz * _glesNormal.x)
					   + 
					    (v_11.xyz * _glesNormal.y)
					  ) + (v_12.xyz * _glesNormal.z)));
					  worldNormal_4 = tmpvar_13;
					  highp mat3 tmpvar_14;
					  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_15;
					  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
					  worldTangent_3 = tmpvar_15;
					  highp float tmpvar_16;
					  tmpvar_16 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_2 = tmpvar_16;
					  lowp vec3 tmpvar_17;
					  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * tangentSign_2);
					  highp vec4 tmpvar_18;
					  tmpvar_18.x = worldTangent_3.x;
					  tmpvar_18.y = tmpvar_17.x;
					  tmpvar_18.z = worldNormal_4.x;
					  tmpvar_18.w = tmpvar_8.x;
					  highp vec4 tmpvar_19;
					  tmpvar_19.x = worldTangent_3.y;
					  tmpvar_19.y = tmpvar_17.y;
					  tmpvar_19.z = worldNormal_4.y;
					  tmpvar_19.w = tmpvar_8.y;
					  highp vec4 tmpvar_20;
					  tmpvar_20.x = worldTangent_3.z;
					  tmpvar_20.y = tmpvar_17.z;
					  tmpvar_20.z = worldNormal_4.z;
					  tmpvar_20.w = tmpvar_8.z;
					  lowp vec4 tmpvar_21;
					  tmpvar_21.w = 1.0;
					  tmpvar_21.xyz = worldNormal_4;
					  mediump vec4 normal_22;
					  normal_22 = tmpvar_21;
					  mediump vec3 res_23;
					  mediump vec3 x_24;
					  x_24.x = dot (unity_SHAr, normal_22);
					  x_24.y = dot (unity_SHAg, normal_22);
					  x_24.z = dot (unity_SHAb, normal_22);
					  mediump vec3 x1_25;
					  mediump vec4 tmpvar_26;
					  tmpvar_26 = (normal_22.xyzz * normal_22.yzzx);
					  x1_25.x = dot (unity_SHBr, tmpvar_26);
					  x1_25.y = dot (unity_SHBg, tmpvar_26);
					  x1_25.z = dot (unity_SHBb, tmpvar_26);
					  res_23 = (x_24 + (x1_25 + (unity_SHC.xyz * 
					    ((normal_22.x * normal_22.x) - (normal_22.y * normal_22.y))
					  )));
					  res_23 = max (((1.055 * 
					    pow (max (res_23, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_23;
					  tmpvar_6 = shlight_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_7);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_18;
					  xlv_TEXCOORD2 = tmpvar_19;
					  xlv_TEXCOORD3 = tmpvar_20;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = tmpvar_6;
					  xlv_TEXCOORD5 = (unity_WorldToShadow[0] * tmpvar_9);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 _LightShadowData;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform sampler2D _SpecTex;
					uniform sampler2D _BumpMap;
					uniform lowp vec4 _Color;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					void main ()
					{
					  lowp vec3 worldN_1;
					  lowp vec4 c_2;
					  lowp vec3 worldViewDir_3;
					  lowp vec3 lightDir_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5.x = xlv_TEXCOORD1.w;
					  tmpvar_5.y = xlv_TEXCOORD2.w;
					  tmpvar_5.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_4 = tmpvar_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_5));
					  worldViewDir_3 = tmpvar_7;
					  lowp vec3 tmpvar_8;
					  mediump float tmpvar_9;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = (texture2D (_SpecTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  tmpvar_8 = (tmpvar_10.xyz * _Color.xyz);
					  tmpvar_9 = tmpvar_10.w;
					  lowp vec3 tmpvar_12;
					  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
					  lowp float tmpvar_13;
					  highp float lightShadowDataX_14;
					  mediump float tmpvar_15;
					  tmpvar_15 = _LightShadowData.x;
					  lightShadowDataX_14 = tmpvar_15;
					  highp float tmpvar_16;
					  tmpvar_16 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD5.xy).x > xlv_TEXCOORD5.z)), lightShadowDataX_14);
					  tmpvar_13 = tmpvar_16;
					  c_2.w = 0.0;
					  highp float tmpvar_17;
					  tmpvar_17 = dot (xlv_TEXCOORD1.xyz, tmpvar_12);
					  worldN_1.x = tmpvar_17;
					  highp float tmpvar_18;
					  tmpvar_18 = dot (xlv_TEXCOORD2.xyz, tmpvar_12);
					  worldN_1.y = tmpvar_18;
					  highp float tmpvar_19;
					  tmpvar_19 = dot (xlv_TEXCOORD3.xyz, tmpvar_12);
					  worldN_1.z = tmpvar_19;
					  c_2.xyz = (tmpvar_8 * xlv_TEXCOORD4);
					  mediump vec4 tmpvar_20;
					  mediump vec3 viewDir_21;
					  viewDir_21 = worldViewDir_3;
					  lowp vec4 c_22;
					  highp float nh_23;
					  mediump float tmpvar_24;
					  tmpvar_24 = max (0.0, dot (worldN_1, normalize(
					    (lightDir_4 + viewDir_21)
					  )));
					  nh_23 = tmpvar_24;
					  mediump float y_25;
					  y_25 = (tmpvar_9 * 128.0);
					  highp float tmpvar_26;
					  tmpvar_26 = (pow (nh_23, y_25) * tmpvar_11.x);
					  c_22.xyz = (((
					    (tmpvar_8 * _LightColor0.xyz)
					   * 
					    max (0.0, dot (worldN_1, lightDir_4))
					  ) + (
					    (_LightColor0.xyz * _SpecColor.xyz)
					   * tmpvar_26)) * (tmpvar_13 * 2.0));
					  c_22.w = ((tmpvar_10.w * _Color.w) + ((_LightColor0.w * _SpecColor.w) * (tmpvar_26 * tmpvar_13)));
					  tmpvar_20 = c_22;
					  c_2.xyz = (c_2 + tmpvar_20).xyz;
					  c_2.w = 1.0;
					  gl_FragData[0] = c_2;
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
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out lowp vec4 vs_COLOR0;
					out lowp vec3 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					lowp vec3 u_xlat10_4;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_TEXCOORD1.w = u_xlat0.x;
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    u_xlat2.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat2.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat2.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat3.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat3.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat3.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat3.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat3.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat3.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
					    u_xlat10_4.xyz = u_xlat1.xyz * u_xlat2.zxy;
					    u_xlat10_4.xyz = u_xlat2.yzx * u_xlat1.yzx + (-u_xlat10_4.xyz);
					    u_xlat10_4.xyz = u_xlat0.xxx * u_xlat10_4.xyz;
					    vs_TEXCOORD1.y = u_xlat10_4.x;
					    vs_TEXCOORD1.x = u_xlat1.z;
					    vs_TEXCOORD1.z = u_xlat2.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD2.w = u_xlat0.y;
					    vs_TEXCOORD3.w = u_xlat0.z;
					    vs_TEXCOORD2.y = u_xlat10_4.y;
					    vs_TEXCOORD3.y = u_xlat10_4.z;
					    vs_TEXCOORD2.z = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat2.z;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat16_5.x = u_xlat2.y * u_xlat2.y;
					    u_xlat16_5.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_5.x);
					    u_xlat16_0 = u_xlat2.yzzx * u_xlat2.xyzz;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
					    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
					    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
					    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
					    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_5.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD4.xyz = u_xlat1.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD5 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp vec4 _SpecColor;
					uniform 	lowp vec4 _Color;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _SpecTex;
					uniform lowp sampler2D _BumpMap;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in lowp vec4 vs_COLOR0;
					in lowp vec3 vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD5;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_4;
					mediump float u_xlat16_5;
					lowp float u_xlat10_5;
					lowp vec3 u_xlat10_7;
					float u_xlat15;
					lowp float u_xlat10_15;
					mediump float u_xlat16_16;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD1.w;
					    u_xlat0.y = vs_TEXCOORD2.w;
					    u_xlat0.z = vs_TEXCOORD3.w;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
					    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
					    u_xlat16_16 = inversesqrt(u_xlat16_16);
					    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
					    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
					    u_xlat10_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat10_2.xyz);
					    u_xlat0.y = dot(vs_TEXCOORD2.xyz, u_xlat10_2.xyz);
					    u_xlat0.z = dot(vs_TEXCOORD3.xyz, u_xlat10_2.xyz);
					    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
					    u_xlat10_2.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat10_2.x = max(u_xlat10_2.x, 0.0);
					    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
					    u_xlat16_0.x = log2(u_xlat16_1.x);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = u_xlat10_1 * vs_COLOR0;
					    u_xlat16_3.x = u_xlat16_1.w * 128.0;
					    u_xlat10_7.xyz = u_xlat16_1.xyz * _Color.xyz;
					    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_3.x;
					    u_xlat16_0.x = exp2(u_xlat16_0.x);
					    u_xlat10_5 = texture(_SpecTex, vs_TEXCOORD0.xy).x;
					    u_xlat16_5 = u_xlat10_5 * vs_COLOR0.x;
					    u_xlat16_0.x = u_xlat16_5 * u_xlat16_0.x;
					    u_xlat10_4.xyz = _LightColor0.xyz * _SpecColor.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat10_4.xyz;
					    u_xlat10_4.xyz = u_xlat10_7.xyz * _LightColor0.xyz;
					    u_xlat16_0.xyz = u_xlat10_4.xyz * u_xlat10_2.xxx + u_xlat16_0.xyz;
					    vec3 txVec0 = vec3(vs_TEXCOORD5.xy,vs_TEXCOORD5.z);
					    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_3.x = u_xlat10_15 * u_xlat16_3.x + _LightShadowData.x;
					    u_xlat10_2.x = u_xlat16_3.x * 2.0;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_2.xxx;
					    u_xlat16_3.xyz = u_xlat10_7.xyz * vs_TEXCOORD4.xyz + u_xlat16_0.xyz;
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
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out lowp vec4 vs_COLOR0;
					out lowp vec3 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					lowp vec3 u_xlat10_4;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_TEXCOORD1.w = u_xlat0.x;
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    u_xlat2.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat2.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat2.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat3.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat3.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat3.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat3.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat3.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat3.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
					    u_xlat10_4.xyz = u_xlat1.xyz * u_xlat2.zxy;
					    u_xlat10_4.xyz = u_xlat2.yzx * u_xlat1.yzx + (-u_xlat10_4.xyz);
					    u_xlat10_4.xyz = u_xlat0.xxx * u_xlat10_4.xyz;
					    vs_TEXCOORD1.y = u_xlat10_4.x;
					    vs_TEXCOORD1.x = u_xlat1.z;
					    vs_TEXCOORD1.z = u_xlat2.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD2.w = u_xlat0.y;
					    vs_TEXCOORD3.w = u_xlat0.z;
					    vs_TEXCOORD2.y = u_xlat10_4.y;
					    vs_TEXCOORD3.y = u_xlat10_4.z;
					    vs_TEXCOORD2.z = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat2.z;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat16_5.x = u_xlat2.y * u_xlat2.y;
					    u_xlat16_5.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_5.x);
					    u_xlat16_0 = u_xlat2.yzzx * u_xlat2.xyzz;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
					    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
					    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
					    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
					    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_5.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD4.xyz = u_xlat1.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD5 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp vec4 _SpecColor;
					uniform 	lowp vec4 _Color;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _SpecTex;
					uniform lowp sampler2D _BumpMap;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in lowp vec4 vs_COLOR0;
					in lowp vec3 vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD5;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_4;
					mediump float u_xlat16_5;
					lowp float u_xlat10_5;
					lowp vec3 u_xlat10_7;
					float u_xlat15;
					lowp float u_xlat10_15;
					mediump float u_xlat16_16;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD1.w;
					    u_xlat0.y = vs_TEXCOORD2.w;
					    u_xlat0.z = vs_TEXCOORD3.w;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
					    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
					    u_xlat16_16 = inversesqrt(u_xlat16_16);
					    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
					    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
					    u_xlat10_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat10_2.xyz);
					    u_xlat0.y = dot(vs_TEXCOORD2.xyz, u_xlat10_2.xyz);
					    u_xlat0.z = dot(vs_TEXCOORD3.xyz, u_xlat10_2.xyz);
					    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
					    u_xlat10_2.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat10_2.x = max(u_xlat10_2.x, 0.0);
					    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
					    u_xlat16_0.x = log2(u_xlat16_1.x);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = u_xlat10_1 * vs_COLOR0;
					    u_xlat16_3.x = u_xlat16_1.w * 128.0;
					    u_xlat10_7.xyz = u_xlat16_1.xyz * _Color.xyz;
					    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_3.x;
					    u_xlat16_0.x = exp2(u_xlat16_0.x);
					    u_xlat10_5 = texture(_SpecTex, vs_TEXCOORD0.xy).x;
					    u_xlat16_5 = u_xlat10_5 * vs_COLOR0.x;
					    u_xlat16_0.x = u_xlat16_5 * u_xlat16_0.x;
					    u_xlat10_4.xyz = _LightColor0.xyz * _SpecColor.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat10_4.xyz;
					    u_xlat10_4.xyz = u_xlat10_7.xyz * _LightColor0.xyz;
					    u_xlat16_0.xyz = u_xlat10_4.xyz * u_xlat10_2.xxx + u_xlat16_0.xyz;
					    vec3 txVec0 = vec3(vs_TEXCOORD5.xy,vs_TEXCOORD5.z);
					    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_3.x = u_xlat10_15 * u_xlat16_3.x + _LightShadowData.x;
					    u_xlat10_2.x = u_xlat16_3.x * 2.0;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_2.xxx;
					    u_xlat16_3.xyz = u_xlat10_7.xyz * vs_TEXCOORD4.xyz + u_xlat16_0.xyz;
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
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out lowp vec4 vs_COLOR0;
					out lowp vec3 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					lowp vec3 u_xlat10_4;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_TEXCOORD1.w = u_xlat0.x;
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    u_xlat2.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat2.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat2.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat3.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat3.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat3.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat3.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat3.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat3.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
					    u_xlat10_4.xyz = u_xlat1.xyz * u_xlat2.zxy;
					    u_xlat10_4.xyz = u_xlat2.yzx * u_xlat1.yzx + (-u_xlat10_4.xyz);
					    u_xlat10_4.xyz = u_xlat0.xxx * u_xlat10_4.xyz;
					    vs_TEXCOORD1.y = u_xlat10_4.x;
					    vs_TEXCOORD1.x = u_xlat1.z;
					    vs_TEXCOORD1.z = u_xlat2.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD2.w = u_xlat0.y;
					    vs_TEXCOORD3.w = u_xlat0.z;
					    vs_TEXCOORD2.y = u_xlat10_4.y;
					    vs_TEXCOORD3.y = u_xlat10_4.z;
					    vs_TEXCOORD2.z = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat2.z;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat16_5.x = u_xlat2.y * u_xlat2.y;
					    u_xlat16_5.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_5.x);
					    u_xlat16_0 = u_xlat2.yzzx * u_xlat2.xyzz;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
					    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
					    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
					    u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
					    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_5.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD4.xyz = u_xlat1.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD5 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp vec4 _SpecColor;
					uniform 	lowp vec4 _Color;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _SpecTex;
					uniform lowp sampler2D _BumpMap;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in lowp vec4 vs_COLOR0;
					in lowp vec3 vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD5;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_4;
					mediump float u_xlat16_5;
					lowp float u_xlat10_5;
					lowp vec3 u_xlat10_7;
					float u_xlat15;
					lowp float u_xlat10_15;
					mediump float u_xlat16_16;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD1.w;
					    u_xlat0.y = vs_TEXCOORD2.w;
					    u_xlat0.z = vs_TEXCOORD3.w;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
					    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
					    u_xlat16_16 = inversesqrt(u_xlat16_16);
					    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
					    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
					    u_xlat10_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat10_2.xyz);
					    u_xlat0.y = dot(vs_TEXCOORD2.xyz, u_xlat10_2.xyz);
					    u_xlat0.z = dot(vs_TEXCOORD3.xyz, u_xlat10_2.xyz);
					    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
					    u_xlat10_2.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat10_2.x = max(u_xlat10_2.x, 0.0);
					    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
					    u_xlat16_0.x = log2(u_xlat16_1.x);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = u_xlat10_1 * vs_COLOR0;
					    u_xlat16_3.x = u_xlat16_1.w * 128.0;
					    u_xlat10_7.xyz = u_xlat16_1.xyz * _Color.xyz;
					    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_3.x;
					    u_xlat16_0.x = exp2(u_xlat16_0.x);
					    u_xlat10_5 = texture(_SpecTex, vs_TEXCOORD0.xy).x;
					    u_xlat16_5 = u_xlat10_5 * vs_COLOR0.x;
					    u_xlat16_0.x = u_xlat16_5 * u_xlat16_0.x;
					    u_xlat10_4.xyz = _LightColor0.xyz * _SpecColor.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat10_4.xyz;
					    u_xlat10_4.xyz = u_xlat10_7.xyz * _LightColor0.xyz;
					    u_xlat16_0.xyz = u_xlat10_4.xyz * u_xlat10_2.xxx + u_xlat16_0.xyz;
					    vec3 txVec0 = vec3(vs_TEXCOORD5.xy,vs_TEXCOORD5.z);
					    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_3.x = u_xlat10_15 * u_xlat16_3.x + _LightShadowData.x;
					    u_xlat10_2.x = u_xlat16_3.x * 2.0;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_2.xxx;
					    u_xlat16_3.xyz = u_xlat10_7.xyz * vs_TEXCOORD4.xyz + u_xlat16_0.xyz;
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
					attribute vec4 _glesTANGENT;
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
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp float tangentSign_2;
					  lowp vec3 worldTangent_3;
					  lowp vec3 worldNormal_4;
					  highp vec4 tmpvar_5;
					  lowp vec3 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = _glesVertex.xyz;
					  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].x;
					  v_9.y = unity_WorldToObject[1].x;
					  v_9.z = unity_WorldToObject[2].x;
					  v_9.w = unity_WorldToObject[3].x;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].y;
					  v_10.y = unity_WorldToObject[1].y;
					  v_10.z = unity_WorldToObject[2].y;
					  v_10.w = unity_WorldToObject[3].y;
					  highp vec4 v_11;
					  v_11.x = unity_WorldToObject[0].z;
					  v_11.y = unity_WorldToObject[1].z;
					  v_11.z = unity_WorldToObject[2].z;
					  v_11.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize(((
					    (v_9.xyz * _glesNormal.x)
					   + 
					    (v_10.xyz * _glesNormal.y)
					  ) + (v_11.xyz * _glesNormal.z)));
					  worldNormal_4 = tmpvar_12;
					  highp mat3 tmpvar_13;
					  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
					  worldTangent_3 = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_2 = tmpvar_15;
					  lowp vec3 tmpvar_16;
					  tmpvar_16 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * tangentSign_2);
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_3.x;
					  tmpvar_17.y = tmpvar_16.x;
					  tmpvar_17.z = worldNormal_4.x;
					  tmpvar_17.w = tmpvar_8.x;
					  highp vec4 tmpvar_18;
					  tmpvar_18.x = worldTangent_3.y;
					  tmpvar_18.y = tmpvar_16.y;
					  tmpvar_18.z = worldNormal_4.y;
					  tmpvar_18.w = tmpvar_8.y;
					  highp vec4 tmpvar_19;
					  tmpvar_19.x = worldTangent_3.z;
					  tmpvar_19.y = tmpvar_16.z;
					  tmpvar_19.z = worldNormal_4.z;
					  tmpvar_19.w = tmpvar_8.z;
					  lowp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = worldNormal_4;
					  mediump vec4 normal_21;
					  normal_21 = tmpvar_20;
					  mediump vec3 res_22;
					  mediump vec3 x_23;
					  x_23.x = dot (unity_SHAr, normal_21);
					  x_23.y = dot (unity_SHAg, normal_21);
					  x_23.z = dot (unity_SHAb, normal_21);
					  mediump vec3 x1_24;
					  mediump vec4 tmpvar_25;
					  tmpvar_25 = (normal_21.xyzz * normal_21.yzzx);
					  x1_24.x = dot (unity_SHBr, tmpvar_25);
					  x1_24.y = dot (unity_SHBg, tmpvar_25);
					  x1_24.z = dot (unity_SHBb, tmpvar_25);
					  res_22 = (x_23 + (x1_24 + (unity_SHC.xyz * 
					    ((normal_21.x * normal_21.x) - (normal_21.y * normal_21.y))
					  )));
					  res_22 = max (((1.055 * 
					    pow (max (res_22, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_22;
					  tmpvar_6 = shlight_1;
					  highp vec3 lightColor0_26;
					  lightColor0_26 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_27;
					  lightColor1_27 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_28;
					  lightColor2_28 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_29;
					  lightColor3_29 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_30;
					  lightAttenSq_30 = unity_4LightAtten0;
					  highp vec3 normal_31;
					  normal_31 = worldNormal_4;
					  highp vec3 col_32;
					  highp vec4 ndotl_33;
					  highp vec4 lengthSq_34;
					  highp vec4 tmpvar_35;
					  tmpvar_35 = (unity_4LightPosX0 - tmpvar_8.x);
					  highp vec4 tmpvar_36;
					  tmpvar_36 = (unity_4LightPosY0 - tmpvar_8.y);
					  highp vec4 tmpvar_37;
					  tmpvar_37 = (unity_4LightPosZ0 - tmpvar_8.z);
					  lengthSq_34 = (tmpvar_35 * tmpvar_35);
					  lengthSq_34 = (lengthSq_34 + (tmpvar_36 * tmpvar_36));
					  lengthSq_34 = (lengthSq_34 + (tmpvar_37 * tmpvar_37));
					  ndotl_33 = (tmpvar_35 * normal_31.x);
					  ndotl_33 = (ndotl_33 + (tmpvar_36 * normal_31.y));
					  ndotl_33 = (ndotl_33 + (tmpvar_37 * normal_31.z));
					  highp vec4 tmpvar_38;
					  tmpvar_38 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_33 * inversesqrt(lengthSq_34)));
					  ndotl_33 = tmpvar_38;
					  highp vec4 tmpvar_39;
					  tmpvar_39 = (tmpvar_38 * (1.0/((1.0 + 
					    (lengthSq_34 * lightAttenSq_30)
					  ))));
					  col_32 = (lightColor0_26 * tmpvar_39.x);
					  col_32 = (col_32 + (lightColor1_27 * tmpvar_39.y));
					  col_32 = (col_32 + (lightColor2_28 * tmpvar_39.z));
					  col_32 = (col_32 + (lightColor3_29 * tmpvar_39.w));
					  tmpvar_6 = (tmpvar_6 + col_32);
					  gl_Position = (glstate_matrix_mvp * tmpvar_7);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_17;
					  xlv_TEXCOORD2 = tmpvar_18;
					  xlv_TEXCOORD3 = tmpvar_19;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = tmpvar_6;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _MainTex;
					uniform sampler2D _SpecTex;
					uniform sampler2D _BumpMap;
					uniform lowp vec4 _Color;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldN_1;
					  lowp vec4 c_2;
					  lowp vec3 worldViewDir_3;
					  lowp vec3 lightDir_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5.x = xlv_TEXCOORD1.w;
					  tmpvar_5.y = xlv_TEXCOORD2.w;
					  tmpvar_5.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_4 = tmpvar_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_5));
					  worldViewDir_3 = tmpvar_7;
					  lowp vec3 tmpvar_8;
					  mediump float tmpvar_9;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = (texture2D (_SpecTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  tmpvar_8 = (tmpvar_10.xyz * _Color.xyz);
					  tmpvar_9 = tmpvar_10.w;
					  lowp vec3 tmpvar_12;
					  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
					  c_2.w = 0.0;
					  highp float tmpvar_13;
					  tmpvar_13 = dot (xlv_TEXCOORD1.xyz, tmpvar_12);
					  worldN_1.x = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = dot (xlv_TEXCOORD2.xyz, tmpvar_12);
					  worldN_1.y = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = dot (xlv_TEXCOORD3.xyz, tmpvar_12);
					  worldN_1.z = tmpvar_15;
					  c_2.xyz = (tmpvar_8 * xlv_TEXCOORD4);
					  mediump vec4 tmpvar_16;
					  mediump vec3 viewDir_17;
					  viewDir_17 = worldViewDir_3;
					  lowp vec4 c_18;
					  highp float nh_19;
					  mediump float tmpvar_20;
					  tmpvar_20 = max (0.0, dot (worldN_1, normalize(
					    (lightDir_4 + viewDir_17)
					  )));
					  nh_19 = tmpvar_20;
					  mediump float y_21;
					  y_21 = (tmpvar_9 * 128.0);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow (nh_19, y_21) * tmpvar_11.x);
					  c_18.xyz = (((
					    (tmpvar_8 * _LightColor0.xyz)
					   * 
					    max (0.0, dot (worldN_1, lightDir_4))
					  ) + (
					    (_LightColor0.xyz * _SpecColor.xyz)
					   * tmpvar_22)) * 2.0);
					  c_18.w = ((tmpvar_10.w * _Color.w) + ((_LightColor0.w * _SpecColor.w) * tmpvar_22));
					  tmpvar_16 = c_18;
					  c_2.xyz = (c_2 + tmpvar_16).xyz;
					  c_2.w = 1.0;
					  gl_FragData[0] = c_2;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
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
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp float tangentSign_2;
					  lowp vec3 worldTangent_3;
					  lowp vec3 worldNormal_4;
					  highp vec4 tmpvar_5;
					  lowp vec3 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = _glesVertex.xyz;
					  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].x;
					  v_9.y = unity_WorldToObject[1].x;
					  v_9.z = unity_WorldToObject[2].x;
					  v_9.w = unity_WorldToObject[3].x;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].y;
					  v_10.y = unity_WorldToObject[1].y;
					  v_10.z = unity_WorldToObject[2].y;
					  v_10.w = unity_WorldToObject[3].y;
					  highp vec4 v_11;
					  v_11.x = unity_WorldToObject[0].z;
					  v_11.y = unity_WorldToObject[1].z;
					  v_11.z = unity_WorldToObject[2].z;
					  v_11.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize(((
					    (v_9.xyz * _glesNormal.x)
					   + 
					    (v_10.xyz * _glesNormal.y)
					  ) + (v_11.xyz * _glesNormal.z)));
					  worldNormal_4 = tmpvar_12;
					  highp mat3 tmpvar_13;
					  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
					  worldTangent_3 = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_2 = tmpvar_15;
					  lowp vec3 tmpvar_16;
					  tmpvar_16 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * tangentSign_2);
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_3.x;
					  tmpvar_17.y = tmpvar_16.x;
					  tmpvar_17.z = worldNormal_4.x;
					  tmpvar_17.w = tmpvar_8.x;
					  highp vec4 tmpvar_18;
					  tmpvar_18.x = worldTangent_3.y;
					  tmpvar_18.y = tmpvar_16.y;
					  tmpvar_18.z = worldNormal_4.y;
					  tmpvar_18.w = tmpvar_8.y;
					  highp vec4 tmpvar_19;
					  tmpvar_19.x = worldTangent_3.z;
					  tmpvar_19.y = tmpvar_16.z;
					  tmpvar_19.z = worldNormal_4.z;
					  tmpvar_19.w = tmpvar_8.z;
					  lowp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = worldNormal_4;
					  mediump vec4 normal_21;
					  normal_21 = tmpvar_20;
					  mediump vec3 res_22;
					  mediump vec3 x_23;
					  x_23.x = dot (unity_SHAr, normal_21);
					  x_23.y = dot (unity_SHAg, normal_21);
					  x_23.z = dot (unity_SHAb, normal_21);
					  mediump vec3 x1_24;
					  mediump vec4 tmpvar_25;
					  tmpvar_25 = (normal_21.xyzz * normal_21.yzzx);
					  x1_24.x = dot (unity_SHBr, tmpvar_25);
					  x1_24.y = dot (unity_SHBg, tmpvar_25);
					  x1_24.z = dot (unity_SHBb, tmpvar_25);
					  res_22 = (x_23 + (x1_24 + (unity_SHC.xyz * 
					    ((normal_21.x * normal_21.x) - (normal_21.y * normal_21.y))
					  )));
					  res_22 = max (((1.055 * 
					    pow (max (res_22, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_22;
					  tmpvar_6 = shlight_1;
					  highp vec3 lightColor0_26;
					  lightColor0_26 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_27;
					  lightColor1_27 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_28;
					  lightColor2_28 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_29;
					  lightColor3_29 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_30;
					  lightAttenSq_30 = unity_4LightAtten0;
					  highp vec3 normal_31;
					  normal_31 = worldNormal_4;
					  highp vec3 col_32;
					  highp vec4 ndotl_33;
					  highp vec4 lengthSq_34;
					  highp vec4 tmpvar_35;
					  tmpvar_35 = (unity_4LightPosX0 - tmpvar_8.x);
					  highp vec4 tmpvar_36;
					  tmpvar_36 = (unity_4LightPosY0 - tmpvar_8.y);
					  highp vec4 tmpvar_37;
					  tmpvar_37 = (unity_4LightPosZ0 - tmpvar_8.z);
					  lengthSq_34 = (tmpvar_35 * tmpvar_35);
					  lengthSq_34 = (lengthSq_34 + (tmpvar_36 * tmpvar_36));
					  lengthSq_34 = (lengthSq_34 + (tmpvar_37 * tmpvar_37));
					  ndotl_33 = (tmpvar_35 * normal_31.x);
					  ndotl_33 = (ndotl_33 + (tmpvar_36 * normal_31.y));
					  ndotl_33 = (ndotl_33 + (tmpvar_37 * normal_31.z));
					  highp vec4 tmpvar_38;
					  tmpvar_38 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_33 * inversesqrt(lengthSq_34)));
					  ndotl_33 = tmpvar_38;
					  highp vec4 tmpvar_39;
					  tmpvar_39 = (tmpvar_38 * (1.0/((1.0 + 
					    (lengthSq_34 * lightAttenSq_30)
					  ))));
					  col_32 = (lightColor0_26 * tmpvar_39.x);
					  col_32 = (col_32 + (lightColor1_27 * tmpvar_39.y));
					  col_32 = (col_32 + (lightColor2_28 * tmpvar_39.z));
					  col_32 = (col_32 + (lightColor3_29 * tmpvar_39.w));
					  tmpvar_6 = (tmpvar_6 + col_32);
					  gl_Position = (glstate_matrix_mvp * tmpvar_7);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_17;
					  xlv_TEXCOORD2 = tmpvar_18;
					  xlv_TEXCOORD3 = tmpvar_19;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = tmpvar_6;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _MainTex;
					uniform sampler2D _SpecTex;
					uniform sampler2D _BumpMap;
					uniform lowp vec4 _Color;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldN_1;
					  lowp vec4 c_2;
					  lowp vec3 worldViewDir_3;
					  lowp vec3 lightDir_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5.x = xlv_TEXCOORD1.w;
					  tmpvar_5.y = xlv_TEXCOORD2.w;
					  tmpvar_5.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_4 = tmpvar_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_5));
					  worldViewDir_3 = tmpvar_7;
					  lowp vec3 tmpvar_8;
					  mediump float tmpvar_9;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = (texture2D (_SpecTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  tmpvar_8 = (tmpvar_10.xyz * _Color.xyz);
					  tmpvar_9 = tmpvar_10.w;
					  lowp vec3 tmpvar_12;
					  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
					  c_2.w = 0.0;
					  highp float tmpvar_13;
					  tmpvar_13 = dot (xlv_TEXCOORD1.xyz, tmpvar_12);
					  worldN_1.x = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = dot (xlv_TEXCOORD2.xyz, tmpvar_12);
					  worldN_1.y = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = dot (xlv_TEXCOORD3.xyz, tmpvar_12);
					  worldN_1.z = tmpvar_15;
					  c_2.xyz = (tmpvar_8 * xlv_TEXCOORD4);
					  mediump vec4 tmpvar_16;
					  mediump vec3 viewDir_17;
					  viewDir_17 = worldViewDir_3;
					  lowp vec4 c_18;
					  highp float nh_19;
					  mediump float tmpvar_20;
					  tmpvar_20 = max (0.0, dot (worldN_1, normalize(
					    (lightDir_4 + viewDir_17)
					  )));
					  nh_19 = tmpvar_20;
					  mediump float y_21;
					  y_21 = (tmpvar_9 * 128.0);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow (nh_19, y_21) * tmpvar_11.x);
					  c_18.xyz = (((
					    (tmpvar_8 * _LightColor0.xyz)
					   * 
					    max (0.0, dot (worldN_1, lightDir_4))
					  ) + (
					    (_LightColor0.xyz * _SpecColor.xyz)
					   * tmpvar_22)) * 2.0);
					  c_18.w = ((tmpvar_10.w * _Color.w) + ((_LightColor0.w * _SpecColor.w) * tmpvar_22));
					  tmpvar_16 = c_18;
					  c_2.xyz = (c_2 + tmpvar_16).xyz;
					  c_2.w = 1.0;
					  gl_FragData[0] = c_2;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
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
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp float tangentSign_2;
					  lowp vec3 worldTangent_3;
					  lowp vec3 worldNormal_4;
					  highp vec4 tmpvar_5;
					  lowp vec3 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = _glesVertex.xyz;
					  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].x;
					  v_9.y = unity_WorldToObject[1].x;
					  v_9.z = unity_WorldToObject[2].x;
					  v_9.w = unity_WorldToObject[3].x;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].y;
					  v_10.y = unity_WorldToObject[1].y;
					  v_10.z = unity_WorldToObject[2].y;
					  v_10.w = unity_WorldToObject[3].y;
					  highp vec4 v_11;
					  v_11.x = unity_WorldToObject[0].z;
					  v_11.y = unity_WorldToObject[1].z;
					  v_11.z = unity_WorldToObject[2].z;
					  v_11.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize(((
					    (v_9.xyz * _glesNormal.x)
					   + 
					    (v_10.xyz * _glesNormal.y)
					  ) + (v_11.xyz * _glesNormal.z)));
					  worldNormal_4 = tmpvar_12;
					  highp mat3 tmpvar_13;
					  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
					  worldTangent_3 = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_2 = tmpvar_15;
					  lowp vec3 tmpvar_16;
					  tmpvar_16 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * tangentSign_2);
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_3.x;
					  tmpvar_17.y = tmpvar_16.x;
					  tmpvar_17.z = worldNormal_4.x;
					  tmpvar_17.w = tmpvar_8.x;
					  highp vec4 tmpvar_18;
					  tmpvar_18.x = worldTangent_3.y;
					  tmpvar_18.y = tmpvar_16.y;
					  tmpvar_18.z = worldNormal_4.y;
					  tmpvar_18.w = tmpvar_8.y;
					  highp vec4 tmpvar_19;
					  tmpvar_19.x = worldTangent_3.z;
					  tmpvar_19.y = tmpvar_16.z;
					  tmpvar_19.z = worldNormal_4.z;
					  tmpvar_19.w = tmpvar_8.z;
					  lowp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = worldNormal_4;
					  mediump vec4 normal_21;
					  normal_21 = tmpvar_20;
					  mediump vec3 res_22;
					  mediump vec3 x_23;
					  x_23.x = dot (unity_SHAr, normal_21);
					  x_23.y = dot (unity_SHAg, normal_21);
					  x_23.z = dot (unity_SHAb, normal_21);
					  mediump vec3 x1_24;
					  mediump vec4 tmpvar_25;
					  tmpvar_25 = (normal_21.xyzz * normal_21.yzzx);
					  x1_24.x = dot (unity_SHBr, tmpvar_25);
					  x1_24.y = dot (unity_SHBg, tmpvar_25);
					  x1_24.z = dot (unity_SHBb, tmpvar_25);
					  res_22 = (x_23 + (x1_24 + (unity_SHC.xyz * 
					    ((normal_21.x * normal_21.x) - (normal_21.y * normal_21.y))
					  )));
					  res_22 = max (((1.055 * 
					    pow (max (res_22, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_22;
					  tmpvar_6 = shlight_1;
					  highp vec3 lightColor0_26;
					  lightColor0_26 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_27;
					  lightColor1_27 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_28;
					  lightColor2_28 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_29;
					  lightColor3_29 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_30;
					  lightAttenSq_30 = unity_4LightAtten0;
					  highp vec3 normal_31;
					  normal_31 = worldNormal_4;
					  highp vec3 col_32;
					  highp vec4 ndotl_33;
					  highp vec4 lengthSq_34;
					  highp vec4 tmpvar_35;
					  tmpvar_35 = (unity_4LightPosX0 - tmpvar_8.x);
					  highp vec4 tmpvar_36;
					  tmpvar_36 = (unity_4LightPosY0 - tmpvar_8.y);
					  highp vec4 tmpvar_37;
					  tmpvar_37 = (unity_4LightPosZ0 - tmpvar_8.z);
					  lengthSq_34 = (tmpvar_35 * tmpvar_35);
					  lengthSq_34 = (lengthSq_34 + (tmpvar_36 * tmpvar_36));
					  lengthSq_34 = (lengthSq_34 + (tmpvar_37 * tmpvar_37));
					  ndotl_33 = (tmpvar_35 * normal_31.x);
					  ndotl_33 = (ndotl_33 + (tmpvar_36 * normal_31.y));
					  ndotl_33 = (ndotl_33 + (tmpvar_37 * normal_31.z));
					  highp vec4 tmpvar_38;
					  tmpvar_38 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_33 * inversesqrt(lengthSq_34)));
					  ndotl_33 = tmpvar_38;
					  highp vec4 tmpvar_39;
					  tmpvar_39 = (tmpvar_38 * (1.0/((1.0 + 
					    (lengthSq_34 * lightAttenSq_30)
					  ))));
					  col_32 = (lightColor0_26 * tmpvar_39.x);
					  col_32 = (col_32 + (lightColor1_27 * tmpvar_39.y));
					  col_32 = (col_32 + (lightColor2_28 * tmpvar_39.z));
					  col_32 = (col_32 + (lightColor3_29 * tmpvar_39.w));
					  tmpvar_6 = (tmpvar_6 + col_32);
					  gl_Position = (glstate_matrix_mvp * tmpvar_7);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_17;
					  xlv_TEXCOORD2 = tmpvar_18;
					  xlv_TEXCOORD3 = tmpvar_19;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = tmpvar_6;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _MainTex;
					uniform sampler2D _SpecTex;
					uniform sampler2D _BumpMap;
					uniform lowp vec4 _Color;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldN_1;
					  lowp vec4 c_2;
					  lowp vec3 worldViewDir_3;
					  lowp vec3 lightDir_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5.x = xlv_TEXCOORD1.w;
					  tmpvar_5.y = xlv_TEXCOORD2.w;
					  tmpvar_5.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_4 = tmpvar_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_5));
					  worldViewDir_3 = tmpvar_7;
					  lowp vec3 tmpvar_8;
					  mediump float tmpvar_9;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = (texture2D (_SpecTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  tmpvar_8 = (tmpvar_10.xyz * _Color.xyz);
					  tmpvar_9 = tmpvar_10.w;
					  lowp vec3 tmpvar_12;
					  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
					  c_2.w = 0.0;
					  highp float tmpvar_13;
					  tmpvar_13 = dot (xlv_TEXCOORD1.xyz, tmpvar_12);
					  worldN_1.x = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = dot (xlv_TEXCOORD2.xyz, tmpvar_12);
					  worldN_1.y = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = dot (xlv_TEXCOORD3.xyz, tmpvar_12);
					  worldN_1.z = tmpvar_15;
					  c_2.xyz = (tmpvar_8 * xlv_TEXCOORD4);
					  mediump vec4 tmpvar_16;
					  mediump vec3 viewDir_17;
					  viewDir_17 = worldViewDir_3;
					  lowp vec4 c_18;
					  highp float nh_19;
					  mediump float tmpvar_20;
					  tmpvar_20 = max (0.0, dot (worldN_1, normalize(
					    (lightDir_4 + viewDir_17)
					  )));
					  nh_19 = tmpvar_20;
					  mediump float y_21;
					  y_21 = (tmpvar_9 * 128.0);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow (nh_19, y_21) * tmpvar_11.x);
					  c_18.xyz = (((
					    (tmpvar_8 * _LightColor0.xyz)
					   * 
					    max (0.0, dot (worldN_1, lightDir_4))
					  ) + (
					    (_LightColor0.xyz * _SpecColor.xyz)
					   * tmpvar_22)) * 2.0);
					  c_18.w = ((tmpvar_10.w * _Color.w) + ((_LightColor0.w * _SpecColor.w) * tmpvar_22));
					  tmpvar_16 = c_18;
					  c_2.xyz = (c_2 + tmpvar_16).xyz;
					  c_2.w = 1.0;
					  gl_FragData[0] = c_2;
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
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out lowp vec4 vs_COLOR0;
					out lowp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					lowp vec3 u_xlat10_3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_5;
					vec3 u_xlat6;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].yzx;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD1.x = u_xlat0.z;
					    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat1.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat1.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat2.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat2.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat2.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat2.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat2.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat2.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    u_xlat10_3.xyz = u_xlat0.xyz * u_xlat1.zxy;
					    u_xlat10_3.xyz = u_xlat1.yzx * u_xlat0.yzx + (-u_xlat10_3.xyz);
					    u_xlat10_3.xyz = vec3(u_xlat21) * u_xlat10_3.xyz;
					    vs_TEXCOORD1.y = u_xlat10_3.x;
					    vs_TEXCOORD1.z = u_xlat1.x;
					    u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
					    vs_TEXCOORD1.w = u_xlat2.x;
					    vs_TEXCOORD2.x = u_xlat0.x;
					    vs_TEXCOORD3.x = u_xlat0.y;
					    vs_TEXCOORD2.y = u_xlat10_3.y;
					    vs_TEXCOORD3.y = u_xlat10_3.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD2.w = u_xlat2.y;
					    vs_TEXCOORD3.w = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat16_4.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_4.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_4.x);
					    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat16_5.x = dot(unity_SHAr, u_xlat1);
					    u_xlat16_5.y = dot(unity_SHAg, u_xlat1);
					    u_xlat16_5.z = dot(unity_SHAb, u_xlat1);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6.xyz = log2(u_xlat16_4.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat6.xyz = exp2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0 = (-u_xlat2.yyyy) + unity_4LightPosY0;
					    u_xlat3 = u_xlat1.yyyy * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat4 = (-u_xlat2.xxxx) + unity_4LightPosX0;
					    u_xlat2 = (-u_xlat2.zzzz) + unity_4LightPosZ0;
					    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
					    u_xlat1 = u_xlat2 * u_xlat1.zzzz + u_xlat3;
					    u_xlat0 = u_xlat4 * u_xlat4 + u_xlat0;
					    u_xlat0 = u_xlat2 * u_xlat2 + u_xlat0;
					    u_xlat2 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat6.xyz;
					    vs_TEXCOORD4.xyz = u_xlat1.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp vec4 _SpecColor;
					uniform 	lowp vec4 _Color;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _SpecTex;
					uniform lowp sampler2D _BumpMap;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in lowp vec4 vs_COLOR0;
					in lowp vec3 vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_4;
					mediump float u_xlat16_5;
					lowp float u_xlat10_5;
					lowp vec3 u_xlat10_7;
					float u_xlat15;
					mediump float u_xlat16_16;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD1.w;
					    u_xlat0.y = vs_TEXCOORD2.w;
					    u_xlat0.z = vs_TEXCOORD3.w;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
					    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
					    u_xlat16_16 = inversesqrt(u_xlat16_16);
					    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
					    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
					    u_xlat10_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat10_2.xyz);
					    u_xlat0.y = dot(vs_TEXCOORD2.xyz, u_xlat10_2.xyz);
					    u_xlat0.z = dot(vs_TEXCOORD3.xyz, u_xlat10_2.xyz);
					    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
					    u_xlat10_2.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat10_2.x = max(u_xlat10_2.x, 0.0);
					    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
					    u_xlat16_0.x = log2(u_xlat16_1.x);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = u_xlat10_1 * vs_COLOR0;
					    u_xlat16_3.x = u_xlat16_1.w * 128.0;
					    u_xlat10_7.xyz = u_xlat16_1.xyz * _Color.xyz;
					    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_3.x;
					    u_xlat16_0.x = exp2(u_xlat16_0.x);
					    u_xlat10_5 = texture(_SpecTex, vs_TEXCOORD0.xy).x;
					    u_xlat16_5 = u_xlat10_5 * vs_COLOR0.x;
					    u_xlat16_0.x = u_xlat16_5 * u_xlat16_0.x;
					    u_xlat10_4.xyz = _LightColor0.xyz * _SpecColor.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat10_4.xyz;
					    u_xlat10_4.xyz = u_xlat10_7.xyz * _LightColor0.xyz;
					    u_xlat16_0.xyz = u_xlat10_4.xyz * u_xlat10_2.xxx + u_xlat16_0.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = u_xlat10_7.xyz * vs_TEXCOORD4.xyz + u_xlat16_0.xyz;
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
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out lowp vec4 vs_COLOR0;
					out lowp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					lowp vec3 u_xlat10_3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_5;
					vec3 u_xlat6;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].yzx;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD1.x = u_xlat0.z;
					    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat1.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat1.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat2.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat2.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat2.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat2.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat2.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat2.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    u_xlat10_3.xyz = u_xlat0.xyz * u_xlat1.zxy;
					    u_xlat10_3.xyz = u_xlat1.yzx * u_xlat0.yzx + (-u_xlat10_3.xyz);
					    u_xlat10_3.xyz = vec3(u_xlat21) * u_xlat10_3.xyz;
					    vs_TEXCOORD1.y = u_xlat10_3.x;
					    vs_TEXCOORD1.z = u_xlat1.x;
					    u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
					    vs_TEXCOORD1.w = u_xlat2.x;
					    vs_TEXCOORD2.x = u_xlat0.x;
					    vs_TEXCOORD3.x = u_xlat0.y;
					    vs_TEXCOORD2.y = u_xlat10_3.y;
					    vs_TEXCOORD3.y = u_xlat10_3.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD2.w = u_xlat2.y;
					    vs_TEXCOORD3.w = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat16_4.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_4.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_4.x);
					    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat16_5.x = dot(unity_SHAr, u_xlat1);
					    u_xlat16_5.y = dot(unity_SHAg, u_xlat1);
					    u_xlat16_5.z = dot(unity_SHAb, u_xlat1);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6.xyz = log2(u_xlat16_4.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat6.xyz = exp2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0 = (-u_xlat2.yyyy) + unity_4LightPosY0;
					    u_xlat3 = u_xlat1.yyyy * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat4 = (-u_xlat2.xxxx) + unity_4LightPosX0;
					    u_xlat2 = (-u_xlat2.zzzz) + unity_4LightPosZ0;
					    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
					    u_xlat1 = u_xlat2 * u_xlat1.zzzz + u_xlat3;
					    u_xlat0 = u_xlat4 * u_xlat4 + u_xlat0;
					    u_xlat0 = u_xlat2 * u_xlat2 + u_xlat0;
					    u_xlat2 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat6.xyz;
					    vs_TEXCOORD4.xyz = u_xlat1.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp vec4 _SpecColor;
					uniform 	lowp vec4 _Color;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _SpecTex;
					uniform lowp sampler2D _BumpMap;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in lowp vec4 vs_COLOR0;
					in lowp vec3 vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_4;
					mediump float u_xlat16_5;
					lowp float u_xlat10_5;
					lowp vec3 u_xlat10_7;
					float u_xlat15;
					mediump float u_xlat16_16;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD1.w;
					    u_xlat0.y = vs_TEXCOORD2.w;
					    u_xlat0.z = vs_TEXCOORD3.w;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
					    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
					    u_xlat16_16 = inversesqrt(u_xlat16_16);
					    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
					    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
					    u_xlat10_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat10_2.xyz);
					    u_xlat0.y = dot(vs_TEXCOORD2.xyz, u_xlat10_2.xyz);
					    u_xlat0.z = dot(vs_TEXCOORD3.xyz, u_xlat10_2.xyz);
					    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
					    u_xlat10_2.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat10_2.x = max(u_xlat10_2.x, 0.0);
					    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
					    u_xlat16_0.x = log2(u_xlat16_1.x);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = u_xlat10_1 * vs_COLOR0;
					    u_xlat16_3.x = u_xlat16_1.w * 128.0;
					    u_xlat10_7.xyz = u_xlat16_1.xyz * _Color.xyz;
					    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_3.x;
					    u_xlat16_0.x = exp2(u_xlat16_0.x);
					    u_xlat10_5 = texture(_SpecTex, vs_TEXCOORD0.xy).x;
					    u_xlat16_5 = u_xlat10_5 * vs_COLOR0.x;
					    u_xlat16_0.x = u_xlat16_5 * u_xlat16_0.x;
					    u_xlat10_4.xyz = _LightColor0.xyz * _SpecColor.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat10_4.xyz;
					    u_xlat10_4.xyz = u_xlat10_7.xyz * _LightColor0.xyz;
					    u_xlat16_0.xyz = u_xlat10_4.xyz * u_xlat10_2.xxx + u_xlat16_0.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = u_xlat10_7.xyz * vs_TEXCOORD4.xyz + u_xlat16_0.xyz;
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
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out lowp vec4 vs_COLOR0;
					out lowp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					lowp vec3 u_xlat10_3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_5;
					vec3 u_xlat6;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].yzx;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD1.x = u_xlat0.z;
					    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat1.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat1.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat2.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat2.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat2.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat2.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat2.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat2.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    u_xlat10_3.xyz = u_xlat0.xyz * u_xlat1.zxy;
					    u_xlat10_3.xyz = u_xlat1.yzx * u_xlat0.yzx + (-u_xlat10_3.xyz);
					    u_xlat10_3.xyz = vec3(u_xlat21) * u_xlat10_3.xyz;
					    vs_TEXCOORD1.y = u_xlat10_3.x;
					    vs_TEXCOORD1.z = u_xlat1.x;
					    u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
					    vs_TEXCOORD1.w = u_xlat2.x;
					    vs_TEXCOORD2.x = u_xlat0.x;
					    vs_TEXCOORD3.x = u_xlat0.y;
					    vs_TEXCOORD2.y = u_xlat10_3.y;
					    vs_TEXCOORD3.y = u_xlat10_3.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD2.w = u_xlat2.y;
					    vs_TEXCOORD3.w = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat16_4.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_4.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_4.x);
					    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat16_5.x = dot(unity_SHAr, u_xlat1);
					    u_xlat16_5.y = dot(unity_SHAg, u_xlat1);
					    u_xlat16_5.z = dot(unity_SHAb, u_xlat1);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6.xyz = log2(u_xlat16_4.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat6.xyz = exp2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0 = (-u_xlat2.yyyy) + unity_4LightPosY0;
					    u_xlat3 = u_xlat1.yyyy * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat4 = (-u_xlat2.xxxx) + unity_4LightPosX0;
					    u_xlat2 = (-u_xlat2.zzzz) + unity_4LightPosZ0;
					    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
					    u_xlat1 = u_xlat2 * u_xlat1.zzzz + u_xlat3;
					    u_xlat0 = u_xlat4 * u_xlat4 + u_xlat0;
					    u_xlat0 = u_xlat2 * u_xlat2 + u_xlat0;
					    u_xlat2 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat6.xyz;
					    vs_TEXCOORD4.xyz = u_xlat1.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp vec4 _SpecColor;
					uniform 	lowp vec4 _Color;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _SpecTex;
					uniform lowp sampler2D _BumpMap;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in lowp vec4 vs_COLOR0;
					in lowp vec3 vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_4;
					mediump float u_xlat16_5;
					lowp float u_xlat10_5;
					lowp vec3 u_xlat10_7;
					float u_xlat15;
					mediump float u_xlat16_16;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD1.w;
					    u_xlat0.y = vs_TEXCOORD2.w;
					    u_xlat0.z = vs_TEXCOORD3.w;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
					    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
					    u_xlat16_16 = inversesqrt(u_xlat16_16);
					    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
					    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
					    u_xlat10_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat10_2.xyz);
					    u_xlat0.y = dot(vs_TEXCOORD2.xyz, u_xlat10_2.xyz);
					    u_xlat0.z = dot(vs_TEXCOORD3.xyz, u_xlat10_2.xyz);
					    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
					    u_xlat10_2.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat10_2.x = max(u_xlat10_2.x, 0.0);
					    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
					    u_xlat16_0.x = log2(u_xlat16_1.x);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = u_xlat10_1 * vs_COLOR0;
					    u_xlat16_3.x = u_xlat16_1.w * 128.0;
					    u_xlat10_7.xyz = u_xlat16_1.xyz * _Color.xyz;
					    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_3.x;
					    u_xlat16_0.x = exp2(u_xlat16_0.x);
					    u_xlat10_5 = texture(_SpecTex, vs_TEXCOORD0.xy).x;
					    u_xlat16_5 = u_xlat10_5 * vs_COLOR0.x;
					    u_xlat16_0.x = u_xlat16_5 * u_xlat16_0.x;
					    u_xlat10_4.xyz = _LightColor0.xyz * _SpecColor.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat10_4.xyz;
					    u_xlat10_4.xyz = u_xlat10_7.xyz * _LightColor0.xyz;
					    u_xlat16_0.xyz = u_xlat10_4.xyz * u_xlat10_2.xxx + u_xlat16_0.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = u_xlat10_7.xyz * vs_TEXCOORD4.xyz + u_xlat16_0.xyz;
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
					attribute vec4 _glesTANGENT;
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
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp float tangentSign_2;
					  lowp vec3 worldTangent_3;
					  lowp vec3 worldNormal_4;
					  highp vec4 tmpvar_5;
					  lowp vec3 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = _glesVertex.xyz;
					  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  highp vec3 tmpvar_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
					  tmpvar_8 = tmpvar_9.xyz;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].x;
					  v_10.y = unity_WorldToObject[1].x;
					  v_10.z = unity_WorldToObject[2].x;
					  v_10.w = unity_WorldToObject[3].x;
					  highp vec4 v_11;
					  v_11.x = unity_WorldToObject[0].y;
					  v_11.y = unity_WorldToObject[1].y;
					  v_11.z = unity_WorldToObject[2].y;
					  v_11.w = unity_WorldToObject[3].y;
					  highp vec4 v_12;
					  v_12.x = unity_WorldToObject[0].z;
					  v_12.y = unity_WorldToObject[1].z;
					  v_12.z = unity_WorldToObject[2].z;
					  v_12.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize(((
					    (v_10.xyz * _glesNormal.x)
					   + 
					    (v_11.xyz * _glesNormal.y)
					  ) + (v_12.xyz * _glesNormal.z)));
					  worldNormal_4 = tmpvar_13;
					  highp mat3 tmpvar_14;
					  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_15;
					  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
					  worldTangent_3 = tmpvar_15;
					  highp float tmpvar_16;
					  tmpvar_16 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_2 = tmpvar_16;
					  lowp vec3 tmpvar_17;
					  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * tangentSign_2);
					  highp vec4 tmpvar_18;
					  tmpvar_18.x = worldTangent_3.x;
					  tmpvar_18.y = tmpvar_17.x;
					  tmpvar_18.z = worldNormal_4.x;
					  tmpvar_18.w = tmpvar_8.x;
					  highp vec4 tmpvar_19;
					  tmpvar_19.x = worldTangent_3.y;
					  tmpvar_19.y = tmpvar_17.y;
					  tmpvar_19.z = worldNormal_4.y;
					  tmpvar_19.w = tmpvar_8.y;
					  highp vec4 tmpvar_20;
					  tmpvar_20.x = worldTangent_3.z;
					  tmpvar_20.y = tmpvar_17.z;
					  tmpvar_20.z = worldNormal_4.z;
					  tmpvar_20.w = tmpvar_8.z;
					  lowp vec4 tmpvar_21;
					  tmpvar_21.w = 1.0;
					  tmpvar_21.xyz = worldNormal_4;
					  mediump vec4 normal_22;
					  normal_22 = tmpvar_21;
					  mediump vec3 res_23;
					  mediump vec3 x_24;
					  x_24.x = dot (unity_SHAr, normal_22);
					  x_24.y = dot (unity_SHAg, normal_22);
					  x_24.z = dot (unity_SHAb, normal_22);
					  mediump vec3 x1_25;
					  mediump vec4 tmpvar_26;
					  tmpvar_26 = (normal_22.xyzz * normal_22.yzzx);
					  x1_25.x = dot (unity_SHBr, tmpvar_26);
					  x1_25.y = dot (unity_SHBg, tmpvar_26);
					  x1_25.z = dot (unity_SHBb, tmpvar_26);
					  res_23 = (x_24 + (x1_25 + (unity_SHC.xyz * 
					    ((normal_22.x * normal_22.x) - (normal_22.y * normal_22.y))
					  )));
					  res_23 = max (((1.055 * 
					    pow (max (res_23, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_23;
					  tmpvar_6 = shlight_1;
					  highp vec3 lightColor0_27;
					  lightColor0_27 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_28;
					  lightColor1_28 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_29;
					  lightColor2_29 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_30;
					  lightColor3_30 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_31;
					  lightAttenSq_31 = unity_4LightAtten0;
					  highp vec3 normal_32;
					  normal_32 = worldNormal_4;
					  highp vec3 col_33;
					  highp vec4 ndotl_34;
					  highp vec4 lengthSq_35;
					  highp vec4 tmpvar_36;
					  tmpvar_36 = (unity_4LightPosX0 - tmpvar_9.x);
					  highp vec4 tmpvar_37;
					  tmpvar_37 = (unity_4LightPosY0 - tmpvar_9.y);
					  highp vec4 tmpvar_38;
					  tmpvar_38 = (unity_4LightPosZ0 - tmpvar_9.z);
					  lengthSq_35 = (tmpvar_36 * tmpvar_36);
					  lengthSq_35 = (lengthSq_35 + (tmpvar_37 * tmpvar_37));
					  lengthSq_35 = (lengthSq_35 + (tmpvar_38 * tmpvar_38));
					  ndotl_34 = (tmpvar_36 * normal_32.x);
					  ndotl_34 = (ndotl_34 + (tmpvar_37 * normal_32.y));
					  ndotl_34 = (ndotl_34 + (tmpvar_38 * normal_32.z));
					  highp vec4 tmpvar_39;
					  tmpvar_39 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_34 * inversesqrt(lengthSq_35)));
					  ndotl_34 = tmpvar_39;
					  highp vec4 tmpvar_40;
					  tmpvar_40 = (tmpvar_39 * (1.0/((1.0 + 
					    (lengthSq_35 * lightAttenSq_31)
					  ))));
					  col_33 = (lightColor0_27 * tmpvar_40.x);
					  col_33 = (col_33 + (lightColor1_28 * tmpvar_40.y));
					  col_33 = (col_33 + (lightColor2_29 * tmpvar_40.z));
					  col_33 = (col_33 + (lightColor3_30 * tmpvar_40.w));
					  tmpvar_6 = (tmpvar_6 + col_33);
					  gl_Position = (glstate_matrix_mvp * tmpvar_7);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_18;
					  xlv_TEXCOORD2 = tmpvar_19;
					  xlv_TEXCOORD3 = tmpvar_20;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = tmpvar_6;
					  xlv_TEXCOORD5 = (unity_WorldToShadow[0] * tmpvar_9);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 _LightShadowData;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform sampler2D _SpecTex;
					uniform sampler2D _BumpMap;
					uniform lowp vec4 _Color;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					void main ()
					{
					  lowp vec3 worldN_1;
					  lowp vec4 c_2;
					  lowp vec3 worldViewDir_3;
					  lowp vec3 lightDir_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5.x = xlv_TEXCOORD1.w;
					  tmpvar_5.y = xlv_TEXCOORD2.w;
					  tmpvar_5.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_4 = tmpvar_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_5));
					  worldViewDir_3 = tmpvar_7;
					  lowp vec3 tmpvar_8;
					  mediump float tmpvar_9;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = (texture2D (_SpecTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  tmpvar_8 = (tmpvar_10.xyz * _Color.xyz);
					  tmpvar_9 = tmpvar_10.w;
					  lowp vec3 tmpvar_12;
					  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
					  lowp float tmpvar_13;
					  highp float lightShadowDataX_14;
					  mediump float tmpvar_15;
					  tmpvar_15 = _LightShadowData.x;
					  lightShadowDataX_14 = tmpvar_15;
					  highp float tmpvar_16;
					  tmpvar_16 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD5.xy).x > xlv_TEXCOORD5.z)), lightShadowDataX_14);
					  tmpvar_13 = tmpvar_16;
					  c_2.w = 0.0;
					  highp float tmpvar_17;
					  tmpvar_17 = dot (xlv_TEXCOORD1.xyz, tmpvar_12);
					  worldN_1.x = tmpvar_17;
					  highp float tmpvar_18;
					  tmpvar_18 = dot (xlv_TEXCOORD2.xyz, tmpvar_12);
					  worldN_1.y = tmpvar_18;
					  highp float tmpvar_19;
					  tmpvar_19 = dot (xlv_TEXCOORD3.xyz, tmpvar_12);
					  worldN_1.z = tmpvar_19;
					  c_2.xyz = (tmpvar_8 * xlv_TEXCOORD4);
					  mediump vec4 tmpvar_20;
					  mediump vec3 viewDir_21;
					  viewDir_21 = worldViewDir_3;
					  lowp vec4 c_22;
					  highp float nh_23;
					  mediump float tmpvar_24;
					  tmpvar_24 = max (0.0, dot (worldN_1, normalize(
					    (lightDir_4 + viewDir_21)
					  )));
					  nh_23 = tmpvar_24;
					  mediump float y_25;
					  y_25 = (tmpvar_9 * 128.0);
					  highp float tmpvar_26;
					  tmpvar_26 = (pow (nh_23, y_25) * tmpvar_11.x);
					  c_22.xyz = (((
					    (tmpvar_8 * _LightColor0.xyz)
					   * 
					    max (0.0, dot (worldN_1, lightDir_4))
					  ) + (
					    (_LightColor0.xyz * _SpecColor.xyz)
					   * tmpvar_26)) * (tmpvar_13 * 2.0));
					  c_22.w = ((tmpvar_10.w * _Color.w) + ((_LightColor0.w * _SpecColor.w) * (tmpvar_26 * tmpvar_13)));
					  tmpvar_20 = c_22;
					  c_2.xyz = (c_2 + tmpvar_20).xyz;
					  c_2.w = 1.0;
					  gl_FragData[0] = c_2;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
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
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp float tangentSign_2;
					  lowp vec3 worldTangent_3;
					  lowp vec3 worldNormal_4;
					  highp vec4 tmpvar_5;
					  lowp vec3 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = _glesVertex.xyz;
					  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  highp vec3 tmpvar_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
					  tmpvar_8 = tmpvar_9.xyz;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].x;
					  v_10.y = unity_WorldToObject[1].x;
					  v_10.z = unity_WorldToObject[2].x;
					  v_10.w = unity_WorldToObject[3].x;
					  highp vec4 v_11;
					  v_11.x = unity_WorldToObject[0].y;
					  v_11.y = unity_WorldToObject[1].y;
					  v_11.z = unity_WorldToObject[2].y;
					  v_11.w = unity_WorldToObject[3].y;
					  highp vec4 v_12;
					  v_12.x = unity_WorldToObject[0].z;
					  v_12.y = unity_WorldToObject[1].z;
					  v_12.z = unity_WorldToObject[2].z;
					  v_12.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize(((
					    (v_10.xyz * _glesNormal.x)
					   + 
					    (v_11.xyz * _glesNormal.y)
					  ) + (v_12.xyz * _glesNormal.z)));
					  worldNormal_4 = tmpvar_13;
					  highp mat3 tmpvar_14;
					  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_15;
					  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
					  worldTangent_3 = tmpvar_15;
					  highp float tmpvar_16;
					  tmpvar_16 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_2 = tmpvar_16;
					  lowp vec3 tmpvar_17;
					  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * tangentSign_2);
					  highp vec4 tmpvar_18;
					  tmpvar_18.x = worldTangent_3.x;
					  tmpvar_18.y = tmpvar_17.x;
					  tmpvar_18.z = worldNormal_4.x;
					  tmpvar_18.w = tmpvar_8.x;
					  highp vec4 tmpvar_19;
					  tmpvar_19.x = worldTangent_3.y;
					  tmpvar_19.y = tmpvar_17.y;
					  tmpvar_19.z = worldNormal_4.y;
					  tmpvar_19.w = tmpvar_8.y;
					  highp vec4 tmpvar_20;
					  tmpvar_20.x = worldTangent_3.z;
					  tmpvar_20.y = tmpvar_17.z;
					  tmpvar_20.z = worldNormal_4.z;
					  tmpvar_20.w = tmpvar_8.z;
					  lowp vec4 tmpvar_21;
					  tmpvar_21.w = 1.0;
					  tmpvar_21.xyz = worldNormal_4;
					  mediump vec4 normal_22;
					  normal_22 = tmpvar_21;
					  mediump vec3 res_23;
					  mediump vec3 x_24;
					  x_24.x = dot (unity_SHAr, normal_22);
					  x_24.y = dot (unity_SHAg, normal_22);
					  x_24.z = dot (unity_SHAb, normal_22);
					  mediump vec3 x1_25;
					  mediump vec4 tmpvar_26;
					  tmpvar_26 = (normal_22.xyzz * normal_22.yzzx);
					  x1_25.x = dot (unity_SHBr, tmpvar_26);
					  x1_25.y = dot (unity_SHBg, tmpvar_26);
					  x1_25.z = dot (unity_SHBb, tmpvar_26);
					  res_23 = (x_24 + (x1_25 + (unity_SHC.xyz * 
					    ((normal_22.x * normal_22.x) - (normal_22.y * normal_22.y))
					  )));
					  res_23 = max (((1.055 * 
					    pow (max (res_23, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_23;
					  tmpvar_6 = shlight_1;
					  highp vec3 lightColor0_27;
					  lightColor0_27 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_28;
					  lightColor1_28 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_29;
					  lightColor2_29 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_30;
					  lightColor3_30 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_31;
					  lightAttenSq_31 = unity_4LightAtten0;
					  highp vec3 normal_32;
					  normal_32 = worldNormal_4;
					  highp vec3 col_33;
					  highp vec4 ndotl_34;
					  highp vec4 lengthSq_35;
					  highp vec4 tmpvar_36;
					  tmpvar_36 = (unity_4LightPosX0 - tmpvar_9.x);
					  highp vec4 tmpvar_37;
					  tmpvar_37 = (unity_4LightPosY0 - tmpvar_9.y);
					  highp vec4 tmpvar_38;
					  tmpvar_38 = (unity_4LightPosZ0 - tmpvar_9.z);
					  lengthSq_35 = (tmpvar_36 * tmpvar_36);
					  lengthSq_35 = (lengthSq_35 + (tmpvar_37 * tmpvar_37));
					  lengthSq_35 = (lengthSq_35 + (tmpvar_38 * tmpvar_38));
					  ndotl_34 = (tmpvar_36 * normal_32.x);
					  ndotl_34 = (ndotl_34 + (tmpvar_37 * normal_32.y));
					  ndotl_34 = (ndotl_34 + (tmpvar_38 * normal_32.z));
					  highp vec4 tmpvar_39;
					  tmpvar_39 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_34 * inversesqrt(lengthSq_35)));
					  ndotl_34 = tmpvar_39;
					  highp vec4 tmpvar_40;
					  tmpvar_40 = (tmpvar_39 * (1.0/((1.0 + 
					    (lengthSq_35 * lightAttenSq_31)
					  ))));
					  col_33 = (lightColor0_27 * tmpvar_40.x);
					  col_33 = (col_33 + (lightColor1_28 * tmpvar_40.y));
					  col_33 = (col_33 + (lightColor2_29 * tmpvar_40.z));
					  col_33 = (col_33 + (lightColor3_30 * tmpvar_40.w));
					  tmpvar_6 = (tmpvar_6 + col_33);
					  gl_Position = (glstate_matrix_mvp * tmpvar_7);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_18;
					  xlv_TEXCOORD2 = tmpvar_19;
					  xlv_TEXCOORD3 = tmpvar_20;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = tmpvar_6;
					  xlv_TEXCOORD5 = (unity_WorldToShadow[0] * tmpvar_9);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 _LightShadowData;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform sampler2D _SpecTex;
					uniform sampler2D _BumpMap;
					uniform lowp vec4 _Color;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					void main ()
					{
					  lowp vec3 worldN_1;
					  lowp vec4 c_2;
					  lowp vec3 worldViewDir_3;
					  lowp vec3 lightDir_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5.x = xlv_TEXCOORD1.w;
					  tmpvar_5.y = xlv_TEXCOORD2.w;
					  tmpvar_5.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_4 = tmpvar_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_5));
					  worldViewDir_3 = tmpvar_7;
					  lowp vec3 tmpvar_8;
					  mediump float tmpvar_9;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = (texture2D (_SpecTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  tmpvar_8 = (tmpvar_10.xyz * _Color.xyz);
					  tmpvar_9 = tmpvar_10.w;
					  lowp vec3 tmpvar_12;
					  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
					  lowp float tmpvar_13;
					  highp float lightShadowDataX_14;
					  mediump float tmpvar_15;
					  tmpvar_15 = _LightShadowData.x;
					  lightShadowDataX_14 = tmpvar_15;
					  highp float tmpvar_16;
					  tmpvar_16 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD5.xy).x > xlv_TEXCOORD5.z)), lightShadowDataX_14);
					  tmpvar_13 = tmpvar_16;
					  c_2.w = 0.0;
					  highp float tmpvar_17;
					  tmpvar_17 = dot (xlv_TEXCOORD1.xyz, tmpvar_12);
					  worldN_1.x = tmpvar_17;
					  highp float tmpvar_18;
					  tmpvar_18 = dot (xlv_TEXCOORD2.xyz, tmpvar_12);
					  worldN_1.y = tmpvar_18;
					  highp float tmpvar_19;
					  tmpvar_19 = dot (xlv_TEXCOORD3.xyz, tmpvar_12);
					  worldN_1.z = tmpvar_19;
					  c_2.xyz = (tmpvar_8 * xlv_TEXCOORD4);
					  mediump vec4 tmpvar_20;
					  mediump vec3 viewDir_21;
					  viewDir_21 = worldViewDir_3;
					  lowp vec4 c_22;
					  highp float nh_23;
					  mediump float tmpvar_24;
					  tmpvar_24 = max (0.0, dot (worldN_1, normalize(
					    (lightDir_4 + viewDir_21)
					  )));
					  nh_23 = tmpvar_24;
					  mediump float y_25;
					  y_25 = (tmpvar_9 * 128.0);
					  highp float tmpvar_26;
					  tmpvar_26 = (pow (nh_23, y_25) * tmpvar_11.x);
					  c_22.xyz = (((
					    (tmpvar_8 * _LightColor0.xyz)
					   * 
					    max (0.0, dot (worldN_1, lightDir_4))
					  ) + (
					    (_LightColor0.xyz * _SpecColor.xyz)
					   * tmpvar_26)) * (tmpvar_13 * 2.0));
					  c_22.w = ((tmpvar_10.w * _Color.w) + ((_LightColor0.w * _SpecColor.w) * (tmpvar_26 * tmpvar_13)));
					  tmpvar_20 = c_22;
					  c_2.xyz = (c_2 + tmpvar_20).xyz;
					  c_2.w = 1.0;
					  gl_FragData[0] = c_2;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
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
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp float tangentSign_2;
					  lowp vec3 worldTangent_3;
					  lowp vec3 worldNormal_4;
					  highp vec4 tmpvar_5;
					  lowp vec3 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = _glesVertex.xyz;
					  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  highp vec3 tmpvar_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
					  tmpvar_8 = tmpvar_9.xyz;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].x;
					  v_10.y = unity_WorldToObject[1].x;
					  v_10.z = unity_WorldToObject[2].x;
					  v_10.w = unity_WorldToObject[3].x;
					  highp vec4 v_11;
					  v_11.x = unity_WorldToObject[0].y;
					  v_11.y = unity_WorldToObject[1].y;
					  v_11.z = unity_WorldToObject[2].y;
					  v_11.w = unity_WorldToObject[3].y;
					  highp vec4 v_12;
					  v_12.x = unity_WorldToObject[0].z;
					  v_12.y = unity_WorldToObject[1].z;
					  v_12.z = unity_WorldToObject[2].z;
					  v_12.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize(((
					    (v_10.xyz * _glesNormal.x)
					   + 
					    (v_11.xyz * _glesNormal.y)
					  ) + (v_12.xyz * _glesNormal.z)));
					  worldNormal_4 = tmpvar_13;
					  highp mat3 tmpvar_14;
					  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_15;
					  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
					  worldTangent_3 = tmpvar_15;
					  highp float tmpvar_16;
					  tmpvar_16 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_2 = tmpvar_16;
					  lowp vec3 tmpvar_17;
					  tmpvar_17 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * tangentSign_2);
					  highp vec4 tmpvar_18;
					  tmpvar_18.x = worldTangent_3.x;
					  tmpvar_18.y = tmpvar_17.x;
					  tmpvar_18.z = worldNormal_4.x;
					  tmpvar_18.w = tmpvar_8.x;
					  highp vec4 tmpvar_19;
					  tmpvar_19.x = worldTangent_3.y;
					  tmpvar_19.y = tmpvar_17.y;
					  tmpvar_19.z = worldNormal_4.y;
					  tmpvar_19.w = tmpvar_8.y;
					  highp vec4 tmpvar_20;
					  tmpvar_20.x = worldTangent_3.z;
					  tmpvar_20.y = tmpvar_17.z;
					  tmpvar_20.z = worldNormal_4.z;
					  tmpvar_20.w = tmpvar_8.z;
					  lowp vec4 tmpvar_21;
					  tmpvar_21.w = 1.0;
					  tmpvar_21.xyz = worldNormal_4;
					  mediump vec4 normal_22;
					  normal_22 = tmpvar_21;
					  mediump vec3 res_23;
					  mediump vec3 x_24;
					  x_24.x = dot (unity_SHAr, normal_22);
					  x_24.y = dot (unity_SHAg, normal_22);
					  x_24.z = dot (unity_SHAb, normal_22);
					  mediump vec3 x1_25;
					  mediump vec4 tmpvar_26;
					  tmpvar_26 = (normal_22.xyzz * normal_22.yzzx);
					  x1_25.x = dot (unity_SHBr, tmpvar_26);
					  x1_25.y = dot (unity_SHBg, tmpvar_26);
					  x1_25.z = dot (unity_SHBb, tmpvar_26);
					  res_23 = (x_24 + (x1_25 + (unity_SHC.xyz * 
					    ((normal_22.x * normal_22.x) - (normal_22.y * normal_22.y))
					  )));
					  res_23 = max (((1.055 * 
					    pow (max (res_23, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_23;
					  tmpvar_6 = shlight_1;
					  highp vec3 lightColor0_27;
					  lightColor0_27 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_28;
					  lightColor1_28 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_29;
					  lightColor2_29 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_30;
					  lightColor3_30 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_31;
					  lightAttenSq_31 = unity_4LightAtten0;
					  highp vec3 normal_32;
					  normal_32 = worldNormal_4;
					  highp vec3 col_33;
					  highp vec4 ndotl_34;
					  highp vec4 lengthSq_35;
					  highp vec4 tmpvar_36;
					  tmpvar_36 = (unity_4LightPosX0 - tmpvar_9.x);
					  highp vec4 tmpvar_37;
					  tmpvar_37 = (unity_4LightPosY0 - tmpvar_9.y);
					  highp vec4 tmpvar_38;
					  tmpvar_38 = (unity_4LightPosZ0 - tmpvar_9.z);
					  lengthSq_35 = (tmpvar_36 * tmpvar_36);
					  lengthSq_35 = (lengthSq_35 + (tmpvar_37 * tmpvar_37));
					  lengthSq_35 = (lengthSq_35 + (tmpvar_38 * tmpvar_38));
					  ndotl_34 = (tmpvar_36 * normal_32.x);
					  ndotl_34 = (ndotl_34 + (tmpvar_37 * normal_32.y));
					  ndotl_34 = (ndotl_34 + (tmpvar_38 * normal_32.z));
					  highp vec4 tmpvar_39;
					  tmpvar_39 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_34 * inversesqrt(lengthSq_35)));
					  ndotl_34 = tmpvar_39;
					  highp vec4 tmpvar_40;
					  tmpvar_40 = (tmpvar_39 * (1.0/((1.0 + 
					    (lengthSq_35 * lightAttenSq_31)
					  ))));
					  col_33 = (lightColor0_27 * tmpvar_40.x);
					  col_33 = (col_33 + (lightColor1_28 * tmpvar_40.y));
					  col_33 = (col_33 + (lightColor2_29 * tmpvar_40.z));
					  col_33 = (col_33 + (lightColor3_30 * tmpvar_40.w));
					  tmpvar_6 = (tmpvar_6 + col_33);
					  gl_Position = (glstate_matrix_mvp * tmpvar_7);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_18;
					  xlv_TEXCOORD2 = tmpvar_19;
					  xlv_TEXCOORD3 = tmpvar_20;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = tmpvar_6;
					  xlv_TEXCOORD5 = (unity_WorldToShadow[0] * tmpvar_9);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 _LightShadowData;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform sampler2D _SpecTex;
					uniform sampler2D _BumpMap;
					uniform lowp vec4 _Color;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					void main ()
					{
					  lowp vec3 worldN_1;
					  lowp vec4 c_2;
					  lowp vec3 worldViewDir_3;
					  lowp vec3 lightDir_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5.x = xlv_TEXCOORD1.w;
					  tmpvar_5.y = xlv_TEXCOORD2.w;
					  tmpvar_5.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = _WorldSpaceLightPos0.xyz;
					  lightDir_4 = tmpvar_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_5));
					  worldViewDir_3 = tmpvar_7;
					  lowp vec3 tmpvar_8;
					  mediump float tmpvar_9;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = (texture2D (_SpecTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  tmpvar_8 = (tmpvar_10.xyz * _Color.xyz);
					  tmpvar_9 = tmpvar_10.w;
					  lowp vec3 tmpvar_12;
					  tmpvar_12 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
					  lowp float tmpvar_13;
					  highp float lightShadowDataX_14;
					  mediump float tmpvar_15;
					  tmpvar_15 = _LightShadowData.x;
					  lightShadowDataX_14 = tmpvar_15;
					  highp float tmpvar_16;
					  tmpvar_16 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD5.xy).x > xlv_TEXCOORD5.z)), lightShadowDataX_14);
					  tmpvar_13 = tmpvar_16;
					  c_2.w = 0.0;
					  highp float tmpvar_17;
					  tmpvar_17 = dot (xlv_TEXCOORD1.xyz, tmpvar_12);
					  worldN_1.x = tmpvar_17;
					  highp float tmpvar_18;
					  tmpvar_18 = dot (xlv_TEXCOORD2.xyz, tmpvar_12);
					  worldN_1.y = tmpvar_18;
					  highp float tmpvar_19;
					  tmpvar_19 = dot (xlv_TEXCOORD3.xyz, tmpvar_12);
					  worldN_1.z = tmpvar_19;
					  c_2.xyz = (tmpvar_8 * xlv_TEXCOORD4);
					  mediump vec4 tmpvar_20;
					  mediump vec3 viewDir_21;
					  viewDir_21 = worldViewDir_3;
					  lowp vec4 c_22;
					  highp float nh_23;
					  mediump float tmpvar_24;
					  tmpvar_24 = max (0.0, dot (worldN_1, normalize(
					    (lightDir_4 + viewDir_21)
					  )));
					  nh_23 = tmpvar_24;
					  mediump float y_25;
					  y_25 = (tmpvar_9 * 128.0);
					  highp float tmpvar_26;
					  tmpvar_26 = (pow (nh_23, y_25) * tmpvar_11.x);
					  c_22.xyz = (((
					    (tmpvar_8 * _LightColor0.xyz)
					   * 
					    max (0.0, dot (worldN_1, lightDir_4))
					  ) + (
					    (_LightColor0.xyz * _SpecColor.xyz)
					   * tmpvar_26)) * (tmpvar_13 * 2.0));
					  c_22.w = ((tmpvar_10.w * _Color.w) + ((_LightColor0.w * _SpecColor.w) * (tmpvar_26 * tmpvar_13)));
					  tmpvar_20 = c_22;
					  c_2.xyz = (c_2 + tmpvar_20).xyz;
					  c_2.w = 1.0;
					  gl_FragData[0] = c_2;
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
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out lowp vec4 vs_COLOR0;
					out lowp vec3 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					lowp vec3 u_xlat10_3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_5;
					vec3 u_xlat6;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].yzx;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD1.x = u_xlat0.z;
					    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat1.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat1.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat2.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat2.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat2.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat2.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat2.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat2.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    u_xlat10_3.xyz = u_xlat0.xyz * u_xlat1.zxy;
					    u_xlat10_3.xyz = u_xlat1.yzx * u_xlat0.yzx + (-u_xlat10_3.xyz);
					    u_xlat10_3.xyz = vec3(u_xlat21) * u_xlat10_3.xyz;
					    vs_TEXCOORD1.y = u_xlat10_3.x;
					    vs_TEXCOORD1.z = u_xlat1.x;
					    u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
					    vs_TEXCOORD1.w = u_xlat2.x;
					    vs_TEXCOORD2.x = u_xlat0.x;
					    vs_TEXCOORD3.x = u_xlat0.y;
					    vs_TEXCOORD2.y = u_xlat10_3.y;
					    vs_TEXCOORD3.y = u_xlat10_3.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD2.w = u_xlat2.y;
					    vs_TEXCOORD3.w = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat16_4.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_4.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_4.x);
					    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat16_5.x = dot(unity_SHAr, u_xlat1);
					    u_xlat16_5.y = dot(unity_SHAg, u_xlat1);
					    u_xlat16_5.z = dot(unity_SHAb, u_xlat1);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6.xyz = log2(u_xlat16_4.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat6.xyz = exp2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0 = (-u_xlat2.yyyy) + unity_4LightPosY0;
					    u_xlat3 = u_xlat1.yyyy * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat4 = (-u_xlat2.xxxx) + unity_4LightPosX0;
					    u_xlat2 = (-u_xlat2.zzzz) + unity_4LightPosZ0;
					    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
					    u_xlat1 = u_xlat2 * u_xlat1.zzzz + u_xlat3;
					    u_xlat0 = u_xlat4 * u_xlat4 + u_xlat0;
					    u_xlat0 = u_xlat2 * u_xlat2 + u_xlat0;
					    u_xlat2 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat6.xyz;
					    vs_TEXCOORD4.xyz = u_xlat1.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD5 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp vec4 _SpecColor;
					uniform 	lowp vec4 _Color;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _SpecTex;
					uniform lowp sampler2D _BumpMap;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in lowp vec4 vs_COLOR0;
					in lowp vec3 vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD5;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_4;
					mediump float u_xlat16_5;
					lowp float u_xlat10_5;
					lowp vec3 u_xlat10_7;
					float u_xlat15;
					lowp float u_xlat10_15;
					mediump float u_xlat16_16;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD1.w;
					    u_xlat0.y = vs_TEXCOORD2.w;
					    u_xlat0.z = vs_TEXCOORD3.w;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
					    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
					    u_xlat16_16 = inversesqrt(u_xlat16_16);
					    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
					    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
					    u_xlat10_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat10_2.xyz);
					    u_xlat0.y = dot(vs_TEXCOORD2.xyz, u_xlat10_2.xyz);
					    u_xlat0.z = dot(vs_TEXCOORD3.xyz, u_xlat10_2.xyz);
					    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
					    u_xlat10_2.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat10_2.x = max(u_xlat10_2.x, 0.0);
					    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
					    u_xlat16_0.x = log2(u_xlat16_1.x);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = u_xlat10_1 * vs_COLOR0;
					    u_xlat16_3.x = u_xlat16_1.w * 128.0;
					    u_xlat10_7.xyz = u_xlat16_1.xyz * _Color.xyz;
					    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_3.x;
					    u_xlat16_0.x = exp2(u_xlat16_0.x);
					    u_xlat10_5 = texture(_SpecTex, vs_TEXCOORD0.xy).x;
					    u_xlat16_5 = u_xlat10_5 * vs_COLOR0.x;
					    u_xlat16_0.x = u_xlat16_5 * u_xlat16_0.x;
					    u_xlat10_4.xyz = _LightColor0.xyz * _SpecColor.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat10_4.xyz;
					    u_xlat10_4.xyz = u_xlat10_7.xyz * _LightColor0.xyz;
					    u_xlat16_0.xyz = u_xlat10_4.xyz * u_xlat10_2.xxx + u_xlat16_0.xyz;
					    vec3 txVec0 = vec3(vs_TEXCOORD5.xy,vs_TEXCOORD5.z);
					    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_3.x = u_xlat10_15 * u_xlat16_3.x + _LightShadowData.x;
					    u_xlat10_2.x = u_xlat16_3.x * 2.0;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_2.xxx;
					    u_xlat16_3.xyz = u_xlat10_7.xyz * vs_TEXCOORD4.xyz + u_xlat16_0.xyz;
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
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out lowp vec4 vs_COLOR0;
					out lowp vec3 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					lowp vec3 u_xlat10_3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_5;
					vec3 u_xlat6;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].yzx;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD1.x = u_xlat0.z;
					    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat1.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat1.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat2.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat2.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat2.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat2.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat2.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat2.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    u_xlat10_3.xyz = u_xlat0.xyz * u_xlat1.zxy;
					    u_xlat10_3.xyz = u_xlat1.yzx * u_xlat0.yzx + (-u_xlat10_3.xyz);
					    u_xlat10_3.xyz = vec3(u_xlat21) * u_xlat10_3.xyz;
					    vs_TEXCOORD1.y = u_xlat10_3.x;
					    vs_TEXCOORD1.z = u_xlat1.x;
					    u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
					    vs_TEXCOORD1.w = u_xlat2.x;
					    vs_TEXCOORD2.x = u_xlat0.x;
					    vs_TEXCOORD3.x = u_xlat0.y;
					    vs_TEXCOORD2.y = u_xlat10_3.y;
					    vs_TEXCOORD3.y = u_xlat10_3.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD2.w = u_xlat2.y;
					    vs_TEXCOORD3.w = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat16_4.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_4.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_4.x);
					    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat16_5.x = dot(unity_SHAr, u_xlat1);
					    u_xlat16_5.y = dot(unity_SHAg, u_xlat1);
					    u_xlat16_5.z = dot(unity_SHAb, u_xlat1);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6.xyz = log2(u_xlat16_4.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat6.xyz = exp2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0 = (-u_xlat2.yyyy) + unity_4LightPosY0;
					    u_xlat3 = u_xlat1.yyyy * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat4 = (-u_xlat2.xxxx) + unity_4LightPosX0;
					    u_xlat2 = (-u_xlat2.zzzz) + unity_4LightPosZ0;
					    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
					    u_xlat1 = u_xlat2 * u_xlat1.zzzz + u_xlat3;
					    u_xlat0 = u_xlat4 * u_xlat4 + u_xlat0;
					    u_xlat0 = u_xlat2 * u_xlat2 + u_xlat0;
					    u_xlat2 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat6.xyz;
					    vs_TEXCOORD4.xyz = u_xlat1.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD5 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp vec4 _SpecColor;
					uniform 	lowp vec4 _Color;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _SpecTex;
					uniform lowp sampler2D _BumpMap;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in lowp vec4 vs_COLOR0;
					in lowp vec3 vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD5;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_4;
					mediump float u_xlat16_5;
					lowp float u_xlat10_5;
					lowp vec3 u_xlat10_7;
					float u_xlat15;
					lowp float u_xlat10_15;
					mediump float u_xlat16_16;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD1.w;
					    u_xlat0.y = vs_TEXCOORD2.w;
					    u_xlat0.z = vs_TEXCOORD3.w;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
					    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
					    u_xlat16_16 = inversesqrt(u_xlat16_16);
					    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
					    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
					    u_xlat10_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat10_2.xyz);
					    u_xlat0.y = dot(vs_TEXCOORD2.xyz, u_xlat10_2.xyz);
					    u_xlat0.z = dot(vs_TEXCOORD3.xyz, u_xlat10_2.xyz);
					    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
					    u_xlat10_2.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat10_2.x = max(u_xlat10_2.x, 0.0);
					    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
					    u_xlat16_0.x = log2(u_xlat16_1.x);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = u_xlat10_1 * vs_COLOR0;
					    u_xlat16_3.x = u_xlat16_1.w * 128.0;
					    u_xlat10_7.xyz = u_xlat16_1.xyz * _Color.xyz;
					    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_3.x;
					    u_xlat16_0.x = exp2(u_xlat16_0.x);
					    u_xlat10_5 = texture(_SpecTex, vs_TEXCOORD0.xy).x;
					    u_xlat16_5 = u_xlat10_5 * vs_COLOR0.x;
					    u_xlat16_0.x = u_xlat16_5 * u_xlat16_0.x;
					    u_xlat10_4.xyz = _LightColor0.xyz * _SpecColor.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat10_4.xyz;
					    u_xlat10_4.xyz = u_xlat10_7.xyz * _LightColor0.xyz;
					    u_xlat16_0.xyz = u_xlat10_4.xyz * u_xlat10_2.xxx + u_xlat16_0.xyz;
					    vec3 txVec0 = vec3(vs_TEXCOORD5.xy,vs_TEXCOORD5.z);
					    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_3.x = u_xlat10_15 * u_xlat16_3.x + _LightShadowData.x;
					    u_xlat10_2.x = u_xlat16_3.x * 2.0;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_2.xxx;
					    u_xlat16_3.xyz = u_xlat10_7.xyz * vs_TEXCOORD4.xyz + u_xlat16_0.xyz;
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
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out lowp vec4 vs_COLOR0;
					out lowp vec3 vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					lowp vec3 u_xlat10_3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_4;
					mediump vec3 u_xlat16_5;
					vec3 u_xlat6;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].yzx;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD1.x = u_xlat0.z;
					    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat1.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat1.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat1.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat2.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat2.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat2.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat2.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat2.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat2.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    u_xlat10_3.xyz = u_xlat0.xyz * u_xlat1.zxy;
					    u_xlat10_3.xyz = u_xlat1.yzx * u_xlat0.yzx + (-u_xlat10_3.xyz);
					    u_xlat10_3.xyz = vec3(u_xlat21) * u_xlat10_3.xyz;
					    vs_TEXCOORD1.y = u_xlat10_3.x;
					    vs_TEXCOORD1.z = u_xlat1.x;
					    u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
					    vs_TEXCOORD1.w = u_xlat2.x;
					    vs_TEXCOORD2.x = u_xlat0.x;
					    vs_TEXCOORD3.x = u_xlat0.y;
					    vs_TEXCOORD2.y = u_xlat10_3.y;
					    vs_TEXCOORD3.y = u_xlat10_3.z;
					    vs_TEXCOORD2.z = u_xlat1.y;
					    vs_TEXCOORD2.w = u_xlat2.y;
					    vs_TEXCOORD3.w = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.z;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat16_4.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_4.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_4.x);
					    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
					    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat16_5.x = dot(unity_SHAr, u_xlat1);
					    u_xlat16_5.y = dot(unity_SHAg, u_xlat1);
					    u_xlat16_5.z = dot(unity_SHAb, u_xlat1);
					    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
					    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6.xyz = log2(u_xlat16_4.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat6.xyz = exp2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0 = (-u_xlat2.yyyy) + unity_4LightPosY0;
					    u_xlat3 = u_xlat1.yyyy * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat4 = (-u_xlat2.xxxx) + unity_4LightPosX0;
					    u_xlat2 = (-u_xlat2.zzzz) + unity_4LightPosZ0;
					    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
					    u_xlat1 = u_xlat2 * u_xlat1.zzzz + u_xlat3;
					    u_xlat0 = u_xlat4 * u_xlat4 + u_xlat0;
					    u_xlat0 = u_xlat2 * u_xlat2 + u_xlat0;
					    u_xlat2 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat6.xyz;
					    vs_TEXCOORD4.xyz = u_xlat1.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD5 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp vec4 _SpecColor;
					uniform 	lowp vec4 _Color;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _SpecTex;
					uniform lowp sampler2D _BumpMap;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					in lowp vec4 vs_COLOR0;
					in lowp vec3 vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD5;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_4;
					mediump float u_xlat16_5;
					lowp float u_xlat10_5;
					lowp vec3 u_xlat10_7;
					float u_xlat15;
					lowp float u_xlat10_15;
					mediump float u_xlat16_16;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD1.w;
					    u_xlat0.y = vs_TEXCOORD2.w;
					    u_xlat0.z = vs_TEXCOORD3.w;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
					    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
					    u_xlat16_16 = inversesqrt(u_xlat16_16);
					    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
					    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
					    u_xlat10_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat10_2.xyz);
					    u_xlat0.y = dot(vs_TEXCOORD2.xyz, u_xlat10_2.xyz);
					    u_xlat0.z = dot(vs_TEXCOORD3.xyz, u_xlat10_2.xyz);
					    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
					    u_xlat10_2.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat10_2.x = max(u_xlat10_2.x, 0.0);
					    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
					    u_xlat16_0.x = log2(u_xlat16_1.x);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = u_xlat10_1 * vs_COLOR0;
					    u_xlat16_3.x = u_xlat16_1.w * 128.0;
					    u_xlat10_7.xyz = u_xlat16_1.xyz * _Color.xyz;
					    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_3.x;
					    u_xlat16_0.x = exp2(u_xlat16_0.x);
					    u_xlat10_5 = texture(_SpecTex, vs_TEXCOORD0.xy).x;
					    u_xlat16_5 = u_xlat10_5 * vs_COLOR0.x;
					    u_xlat16_0.x = u_xlat16_5 * u_xlat16_0.x;
					    u_xlat10_4.xyz = _LightColor0.xyz * _SpecColor.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat10_4.xyz;
					    u_xlat10_4.xyz = u_xlat10_7.xyz * _LightColor0.xyz;
					    u_xlat16_0.xyz = u_xlat10_4.xyz * u_xlat10_2.xxx + u_xlat16_0.xyz;
					    vec3 txVec0 = vec3(vs_TEXCOORD5.xy,vs_TEXCOORD5.z);
					    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_3.x = u_xlat10_15 * u_xlat16_3.x + _LightShadowData.x;
					    u_xlat10_2.x = u_xlat16_3.x * 2.0;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_2.xxx;
					    u_xlat16_3.xyz = u_xlat10_7.xyz * vs_TEXCOORD4.xyz + u_xlat16_0.xyz;
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
  GpuProgramID 107797
Program "vp" {
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
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
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  lowp vec3 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_5);
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _MainTex;
					uniform sampler2D _SpecTex;
					uniform sampler2D _BumpMap;
					uniform lowp vec4 _Color;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec3 worldN_1;
					  lowp vec4 c_2;
					  lowp vec3 worldViewDir_3;
					  lowp vec3 lightDir_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
					  lightDir_4 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_3 = tmpvar_6;
					  mediump float tmpvar_7;
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_SpecTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  tmpvar_7 = tmpvar_8.w;
					  lowp vec3 tmpvar_10;
					  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = xlv_TEXCOORD4;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (unity_WorldToLight * tmpvar_11).xyz;
					  highp float tmpvar_13;
					  tmpvar_13 = dot (tmpvar_12, tmpvar_12);
					  lowp float tmpvar_14;
					  tmpvar_14 = texture2D (_LightTexture0, vec2(tmpvar_13)).w;
					  worldN_1.x = dot (xlv_TEXCOORD1, tmpvar_10);
					  worldN_1.y = dot (xlv_TEXCOORD2, tmpvar_10);
					  worldN_1.z = dot (xlv_TEXCOORD3, tmpvar_10);
					  mediump vec4 tmpvar_15;
					  mediump vec3 viewDir_16;
					  viewDir_16 = worldViewDir_3;
					  lowp vec4 c_17;
					  highp float nh_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = max (0.0, dot (worldN_1, normalize(
					    (lightDir_4 + viewDir_16)
					  )));
					  nh_18 = tmpvar_19;
					  mediump float y_20;
					  y_20 = (tmpvar_7 * 128.0);
					  highp float tmpvar_21;
					  tmpvar_21 = (pow (nh_18, y_20) * tmpvar_9.x);
					  c_17.xyz = (((
					    ((tmpvar_8.xyz * _Color.xyz) * _LightColor0.xyz)
					   * 
					    max (0.0, dot (worldN_1, lightDir_4))
					  ) + (
					    (_LightColor0.xyz * _SpecColor.xyz)
					   * tmpvar_21)) * (tmpvar_14 * 2.0));
					  c_17.w = ((tmpvar_8.w * _Color.w) + ((_LightColor0.w * _SpecColor.w) * (tmpvar_21 * tmpvar_14)));
					  tmpvar_15 = c_17;
					  c_2.xyz = tmpvar_15.xyz;
					  c_2.w = 1.0;
					  gl_FragData[0] = c_2;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
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
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  lowp vec3 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_5);
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _MainTex;
					uniform sampler2D _SpecTex;
					uniform sampler2D _BumpMap;
					uniform lowp vec4 _Color;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec3 worldN_1;
					  lowp vec4 c_2;
					  lowp vec3 worldViewDir_3;
					  lowp vec3 lightDir_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
					  lightDir_4 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_3 = tmpvar_6;
					  mediump float tmpvar_7;
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_SpecTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  tmpvar_7 = tmpvar_8.w;
					  lowp vec3 tmpvar_10;
					  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = xlv_TEXCOORD4;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (unity_WorldToLight * tmpvar_11).xyz;
					  highp float tmpvar_13;
					  tmpvar_13 = dot (tmpvar_12, tmpvar_12);
					  lowp float tmpvar_14;
					  tmpvar_14 = texture2D (_LightTexture0, vec2(tmpvar_13)).w;
					  worldN_1.x = dot (xlv_TEXCOORD1, tmpvar_10);
					  worldN_1.y = dot (xlv_TEXCOORD2, tmpvar_10);
					  worldN_1.z = dot (xlv_TEXCOORD3, tmpvar_10);
					  mediump vec4 tmpvar_15;
					  mediump vec3 viewDir_16;
					  viewDir_16 = worldViewDir_3;
					  lowp vec4 c_17;
					  highp float nh_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = max (0.0, dot (worldN_1, normalize(
					    (lightDir_4 + viewDir_16)
					  )));
					  nh_18 = tmpvar_19;
					  mediump float y_20;
					  y_20 = (tmpvar_7 * 128.0);
					  highp float tmpvar_21;
					  tmpvar_21 = (pow (nh_18, y_20) * tmpvar_9.x);
					  c_17.xyz = (((
					    ((tmpvar_8.xyz * _Color.xyz) * _LightColor0.xyz)
					   * 
					    max (0.0, dot (worldN_1, lightDir_4))
					  ) + (
					    (_LightColor0.xyz * _SpecColor.xyz)
					   * tmpvar_21)) * (tmpvar_14 * 2.0));
					  c_17.w = ((tmpvar_8.w * _Color.w) + ((_LightColor0.w * _SpecColor.w) * (tmpvar_21 * tmpvar_14)));
					  tmpvar_15 = c_17;
					  c_2.xyz = tmpvar_15.xyz;
					  c_2.w = 1.0;
					  gl_FragData[0] = c_2;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {
Keywords { "POINT" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
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
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  lowp vec3 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_5);
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _MainTex;
					uniform sampler2D _SpecTex;
					uniform sampler2D _BumpMap;
					uniform lowp vec4 _Color;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec3 worldN_1;
					  lowp vec4 c_2;
					  lowp vec3 worldViewDir_3;
					  lowp vec3 lightDir_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
					  lightDir_4 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_3 = tmpvar_6;
					  mediump float tmpvar_7;
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_SpecTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  tmpvar_7 = tmpvar_8.w;
					  lowp vec3 tmpvar_10;
					  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = xlv_TEXCOORD4;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (unity_WorldToLight * tmpvar_11).xyz;
					  highp float tmpvar_13;
					  tmpvar_13 = dot (tmpvar_12, tmpvar_12);
					  lowp float tmpvar_14;
					  tmpvar_14 = texture2D (_LightTexture0, vec2(tmpvar_13)).w;
					  worldN_1.x = dot (xlv_TEXCOORD1, tmpvar_10);
					  worldN_1.y = dot (xlv_TEXCOORD2, tmpvar_10);
					  worldN_1.z = dot (xlv_TEXCOORD3, tmpvar_10);
					  mediump vec4 tmpvar_15;
					  mediump vec3 viewDir_16;
					  viewDir_16 = worldViewDir_3;
					  lowp vec4 c_17;
					  highp float nh_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = max (0.0, dot (worldN_1, normalize(
					    (lightDir_4 + viewDir_16)
					  )));
					  nh_18 = tmpvar_19;
					  mediump float y_20;
					  y_20 = (tmpvar_7 * 128.0);
					  highp float tmpvar_21;
					  tmpvar_21 = (pow (nh_18, y_20) * tmpvar_9.x);
					  c_17.xyz = (((
					    ((tmpvar_8.xyz * _Color.xyz) * _LightColor0.xyz)
					   * 
					    max (0.0, dot (worldN_1, lightDir_4))
					  ) + (
					    (_LightColor0.xyz * _SpecColor.xyz)
					   * tmpvar_21)) * (tmpvar_14 * 2.0));
					  c_17.w = ((tmpvar_8.w * _Color.w) + ((_LightColor0.w * _SpecColor.w) * (tmpvar_21 * tmpvar_14)));
					  tmpvar_15 = c_17;
					  c_2.xyz = tmpvar_15.xyz;
					  c_2.w = 1.0;
					  gl_FragData[0] = c_2;
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
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out lowp vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out lowp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.z = u_xlat0.y;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat10_2.xyz);
					    u_xlat3 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat10_2.xyz = vec3(u_xlat3) * u_xlat10_2.xyz;
					    vs_TEXCOORD1.y = u_xlat10_2.x;
					    vs_TEXCOORD1.x = u_xlat1.z;
					    vs_TEXCOORD2.z = u_xlat0.z;
					    vs_TEXCOORD3.z = u_xlat0.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD2.y = u_xlat10_2.y;
					    vs_TEXCOORD3.y = u_xlat10_2.z;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD4.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp vec4 _SpecColor;
					uniform 	vec4 hlslcc_mtx4unity_WorldToLight[4];
					uniform 	lowp vec4 _Color;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _SpecTex;
					uniform lowp sampler2D _BumpMap;
					uniform lowp sampler2D _LightTexture0;
					in highp vec4 vs_TEXCOORD0;
					in lowp vec3 vs_TEXCOORD1;
					in lowp vec3 vs_TEXCOORD2;
					in lowp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec3 u_xlat1;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_3;
					lowp vec3 u_xlat10_4;
					mediump float u_xlat16_5;
					lowp float u_xlat10_5;
					lowp vec3 u_xlat10_8;
					float u_xlat15;
					lowp float u_xlat10_15;
					mediump float u_xlat16_17;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    u_xlat16_17 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
					    u_xlat16_17 = inversesqrt(u_xlat16_17);
					    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
					    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
					    u_xlat10_3.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat10_4.x = dot(vs_TEXCOORD1.xyz, u_xlat10_3.xyz);
					    u_xlat10_4.y = dot(vs_TEXCOORD2.xyz, u_xlat10_3.xyz);
					    u_xlat10_4.z = dot(vs_TEXCOORD3.xyz, u_xlat10_3.xyz);
					    u_xlat16_2.x = dot(u_xlat10_4.xyz, u_xlat16_2.xyz);
					    u_xlat10_3.x = dot(u_xlat10_4.xyz, u_xlat0.xyz);
					    u_xlat10_3.x = max(u_xlat10_3.x, 0.0);
					    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
					    u_xlat16_0.x = log2(u_xlat16_2.x);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = u_xlat10_1 * vs_COLOR0;
					    u_xlat16_2.x = u_xlat16_1.w * 128.0;
					    u_xlat10_8.xyz = u_xlat16_1.xyz * _Color.xyz;
					    u_xlat10_8.xyz = u_xlat10_8.xyz * _LightColor0.xyz;
					    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_2.x;
					    u_xlat16_0.x = exp2(u_xlat16_0.x);
					    u_xlat10_5 = texture(_SpecTex, vs_TEXCOORD0.xy).x;
					    u_xlat16_5 = u_xlat10_5 * vs_COLOR0.x;
					    u_xlat16_0.x = u_xlat16_5 * u_xlat16_0.x;
					    u_xlat10_4.xyz = _LightColor0.xyz * _SpecColor.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat10_4.xyz;
					    u_xlat16_0.xyz = u_xlat10_8.xyz * u_xlat10_3.xxx + u_xlat16_0.xyz;
					    u_xlat1.xyz = vs_TEXCOORD4.yyy * hlslcc_mtx4unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToLight[0].xyz * vs_TEXCOORD4.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToLight[2].xyz * vs_TEXCOORD4.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_WorldToLight[3].xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10_15 = texture(_LightTexture0, vec2(u_xlat15)).w;
					    u_xlat10_3.x = u_xlat10_15 * 2.0;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_3.xxx;
					    SV_Target0.xyz = u_xlat16_0.xyz;
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
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out lowp vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out lowp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.z = u_xlat0.y;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat10_2.xyz);
					    u_xlat3 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat10_2.xyz = vec3(u_xlat3) * u_xlat10_2.xyz;
					    vs_TEXCOORD1.y = u_xlat10_2.x;
					    vs_TEXCOORD1.x = u_xlat1.z;
					    vs_TEXCOORD2.z = u_xlat0.z;
					    vs_TEXCOORD3.z = u_xlat0.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD2.y = u_xlat10_2.y;
					    vs_TEXCOORD3.y = u_xlat10_2.z;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD4.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp vec4 _SpecColor;
					uniform 	vec4 hlslcc_mtx4unity_WorldToLight[4];
					uniform 	lowp vec4 _Color;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _SpecTex;
					uniform lowp sampler2D _BumpMap;
					uniform lowp sampler2D _LightTexture0;
					in highp vec4 vs_TEXCOORD0;
					in lowp vec3 vs_TEXCOORD1;
					in lowp vec3 vs_TEXCOORD2;
					in lowp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec3 u_xlat1;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_3;
					lowp vec3 u_xlat10_4;
					mediump float u_xlat16_5;
					lowp float u_xlat10_5;
					lowp vec3 u_xlat10_8;
					float u_xlat15;
					lowp float u_xlat10_15;
					mediump float u_xlat16_17;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    u_xlat16_17 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
					    u_xlat16_17 = inversesqrt(u_xlat16_17);
					    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
					    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
					    u_xlat10_3.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat10_4.x = dot(vs_TEXCOORD1.xyz, u_xlat10_3.xyz);
					    u_xlat10_4.y = dot(vs_TEXCOORD2.xyz, u_xlat10_3.xyz);
					    u_xlat10_4.z = dot(vs_TEXCOORD3.xyz, u_xlat10_3.xyz);
					    u_xlat16_2.x = dot(u_xlat10_4.xyz, u_xlat16_2.xyz);
					    u_xlat10_3.x = dot(u_xlat10_4.xyz, u_xlat0.xyz);
					    u_xlat10_3.x = max(u_xlat10_3.x, 0.0);
					    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
					    u_xlat16_0.x = log2(u_xlat16_2.x);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = u_xlat10_1 * vs_COLOR0;
					    u_xlat16_2.x = u_xlat16_1.w * 128.0;
					    u_xlat10_8.xyz = u_xlat16_1.xyz * _Color.xyz;
					    u_xlat10_8.xyz = u_xlat10_8.xyz * _LightColor0.xyz;
					    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_2.x;
					    u_xlat16_0.x = exp2(u_xlat16_0.x);
					    u_xlat10_5 = texture(_SpecTex, vs_TEXCOORD0.xy).x;
					    u_xlat16_5 = u_xlat10_5 * vs_COLOR0.x;
					    u_xlat16_0.x = u_xlat16_5 * u_xlat16_0.x;
					    u_xlat10_4.xyz = _LightColor0.xyz * _SpecColor.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat10_4.xyz;
					    u_xlat16_0.xyz = u_xlat10_8.xyz * u_xlat10_3.xxx + u_xlat16_0.xyz;
					    u_xlat1.xyz = vs_TEXCOORD4.yyy * hlslcc_mtx4unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToLight[0].xyz * vs_TEXCOORD4.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToLight[2].xyz * vs_TEXCOORD4.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_WorldToLight[3].xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10_15 = texture(_LightTexture0, vec2(u_xlat15)).w;
					    u_xlat10_3.x = u_xlat10_15 * 2.0;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_3.xxx;
					    SV_Target0.xyz = u_xlat16_0.xyz;
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
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out lowp vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out lowp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.z = u_xlat0.y;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat10_2.xyz);
					    u_xlat3 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat10_2.xyz = vec3(u_xlat3) * u_xlat10_2.xyz;
					    vs_TEXCOORD1.y = u_xlat10_2.x;
					    vs_TEXCOORD1.x = u_xlat1.z;
					    vs_TEXCOORD2.z = u_xlat0.z;
					    vs_TEXCOORD3.z = u_xlat0.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD2.y = u_xlat10_2.y;
					    vs_TEXCOORD3.y = u_xlat10_2.z;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD4.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp vec4 _SpecColor;
					uniform 	vec4 hlslcc_mtx4unity_WorldToLight[4];
					uniform 	lowp vec4 _Color;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _SpecTex;
					uniform lowp sampler2D _BumpMap;
					uniform lowp sampler2D _LightTexture0;
					in highp vec4 vs_TEXCOORD0;
					in lowp vec3 vs_TEXCOORD1;
					in lowp vec3 vs_TEXCOORD2;
					in lowp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec3 u_xlat1;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_3;
					lowp vec3 u_xlat10_4;
					mediump float u_xlat16_5;
					lowp float u_xlat10_5;
					lowp vec3 u_xlat10_8;
					float u_xlat15;
					lowp float u_xlat10_15;
					mediump float u_xlat16_17;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    u_xlat16_17 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
					    u_xlat16_17 = inversesqrt(u_xlat16_17);
					    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
					    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
					    u_xlat10_3.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat10_4.x = dot(vs_TEXCOORD1.xyz, u_xlat10_3.xyz);
					    u_xlat10_4.y = dot(vs_TEXCOORD2.xyz, u_xlat10_3.xyz);
					    u_xlat10_4.z = dot(vs_TEXCOORD3.xyz, u_xlat10_3.xyz);
					    u_xlat16_2.x = dot(u_xlat10_4.xyz, u_xlat16_2.xyz);
					    u_xlat10_3.x = dot(u_xlat10_4.xyz, u_xlat0.xyz);
					    u_xlat10_3.x = max(u_xlat10_3.x, 0.0);
					    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
					    u_xlat16_0.x = log2(u_xlat16_2.x);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = u_xlat10_1 * vs_COLOR0;
					    u_xlat16_2.x = u_xlat16_1.w * 128.0;
					    u_xlat10_8.xyz = u_xlat16_1.xyz * _Color.xyz;
					    u_xlat10_8.xyz = u_xlat10_8.xyz * _LightColor0.xyz;
					    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_2.x;
					    u_xlat16_0.x = exp2(u_xlat16_0.x);
					    u_xlat10_5 = texture(_SpecTex, vs_TEXCOORD0.xy).x;
					    u_xlat16_5 = u_xlat10_5 * vs_COLOR0.x;
					    u_xlat16_0.x = u_xlat16_5 * u_xlat16_0.x;
					    u_xlat10_4.xyz = _LightColor0.xyz * _SpecColor.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat10_4.xyz;
					    u_xlat16_0.xyz = u_xlat10_8.xyz * u_xlat10_3.xxx + u_xlat16_0.xyz;
					    u_xlat1.xyz = vs_TEXCOORD4.yyy * hlslcc_mtx4unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToLight[0].xyz * vs_TEXCOORD4.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToLight[2].xyz * vs_TEXCOORD4.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_WorldToLight[3].xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10_15 = texture(_LightTexture0, vec2(u_xlat15)).w;
					    u_xlat10_3.x = u_xlat10_15 * 2.0;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_3.xxx;
					    SV_Target0.xyz = u_xlat16_0.xyz;
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
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
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
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  lowp vec3 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_5);
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _MainTex;
					uniform sampler2D _SpecTex;
					uniform sampler2D _BumpMap;
					uniform lowp vec4 _Color;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec3 worldN_1;
					  lowp vec4 c_2;
					  lowp vec3 worldViewDir_3;
					  lowp vec3 lightDir_4;
					  mediump vec3 tmpvar_5;
					  tmpvar_5 = _WorldSpaceLightPos0.xyz;
					  lightDir_4 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_3 = tmpvar_6;
					  mediump float tmpvar_7;
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_SpecTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  tmpvar_7 = tmpvar_8.w;
					  lowp vec3 tmpvar_10;
					  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
					  worldN_1.x = dot (xlv_TEXCOORD1, tmpvar_10);
					  worldN_1.y = dot (xlv_TEXCOORD2, tmpvar_10);
					  worldN_1.z = dot (xlv_TEXCOORD3, tmpvar_10);
					  mediump vec4 tmpvar_11;
					  mediump vec3 viewDir_12;
					  viewDir_12 = worldViewDir_3;
					  lowp vec4 c_13;
					  highp float nh_14;
					  mediump float tmpvar_15;
					  tmpvar_15 = max (0.0, dot (worldN_1, normalize(
					    (lightDir_4 + viewDir_12)
					  )));
					  nh_14 = tmpvar_15;
					  mediump float y_16;
					  y_16 = (tmpvar_7 * 128.0);
					  highp float tmpvar_17;
					  tmpvar_17 = (pow (nh_14, y_16) * tmpvar_9.x);
					  c_13.xyz = (((
					    ((tmpvar_8.xyz * _Color.xyz) * _LightColor0.xyz)
					   * 
					    max (0.0, dot (worldN_1, lightDir_4))
					  ) + (
					    (_LightColor0.xyz * _SpecColor.xyz)
					   * tmpvar_17)) * 2.0);
					  c_13.w = ((tmpvar_8.w * _Color.w) + ((_LightColor0.w * _SpecColor.w) * tmpvar_17));
					  tmpvar_11 = c_13;
					  c_2.xyz = tmpvar_11.xyz;
					  c_2.w = 1.0;
					  gl_FragData[0] = c_2;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
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
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  lowp vec3 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_5);
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _MainTex;
					uniform sampler2D _SpecTex;
					uniform sampler2D _BumpMap;
					uniform lowp vec4 _Color;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec3 worldN_1;
					  lowp vec4 c_2;
					  lowp vec3 worldViewDir_3;
					  lowp vec3 lightDir_4;
					  mediump vec3 tmpvar_5;
					  tmpvar_5 = _WorldSpaceLightPos0.xyz;
					  lightDir_4 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_3 = tmpvar_6;
					  mediump float tmpvar_7;
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_SpecTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  tmpvar_7 = tmpvar_8.w;
					  lowp vec3 tmpvar_10;
					  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
					  worldN_1.x = dot (xlv_TEXCOORD1, tmpvar_10);
					  worldN_1.y = dot (xlv_TEXCOORD2, tmpvar_10);
					  worldN_1.z = dot (xlv_TEXCOORD3, tmpvar_10);
					  mediump vec4 tmpvar_11;
					  mediump vec3 viewDir_12;
					  viewDir_12 = worldViewDir_3;
					  lowp vec4 c_13;
					  highp float nh_14;
					  mediump float tmpvar_15;
					  tmpvar_15 = max (0.0, dot (worldN_1, normalize(
					    (lightDir_4 + viewDir_12)
					  )));
					  nh_14 = tmpvar_15;
					  mediump float y_16;
					  y_16 = (tmpvar_7 * 128.0);
					  highp float tmpvar_17;
					  tmpvar_17 = (pow (nh_14, y_16) * tmpvar_9.x);
					  c_13.xyz = (((
					    ((tmpvar_8.xyz * _Color.xyz) * _LightColor0.xyz)
					   * 
					    max (0.0, dot (worldN_1, lightDir_4))
					  ) + (
					    (_LightColor0.xyz * _SpecColor.xyz)
					   * tmpvar_17)) * 2.0);
					  c_13.w = ((tmpvar_8.w * _Color.w) + ((_LightColor0.w * _SpecColor.w) * tmpvar_17));
					  tmpvar_11 = c_13;
					  c_2.xyz = tmpvar_11.xyz;
					  c_2.w = 1.0;
					  gl_FragData[0] = c_2;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
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
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  lowp vec3 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_5);
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _MainTex;
					uniform sampler2D _SpecTex;
					uniform sampler2D _BumpMap;
					uniform lowp vec4 _Color;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec3 worldN_1;
					  lowp vec4 c_2;
					  lowp vec3 worldViewDir_3;
					  lowp vec3 lightDir_4;
					  mediump vec3 tmpvar_5;
					  tmpvar_5 = _WorldSpaceLightPos0.xyz;
					  lightDir_4 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_3 = tmpvar_6;
					  mediump float tmpvar_7;
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_SpecTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  tmpvar_7 = tmpvar_8.w;
					  lowp vec3 tmpvar_10;
					  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
					  worldN_1.x = dot (xlv_TEXCOORD1, tmpvar_10);
					  worldN_1.y = dot (xlv_TEXCOORD2, tmpvar_10);
					  worldN_1.z = dot (xlv_TEXCOORD3, tmpvar_10);
					  mediump vec4 tmpvar_11;
					  mediump vec3 viewDir_12;
					  viewDir_12 = worldViewDir_3;
					  lowp vec4 c_13;
					  highp float nh_14;
					  mediump float tmpvar_15;
					  tmpvar_15 = max (0.0, dot (worldN_1, normalize(
					    (lightDir_4 + viewDir_12)
					  )));
					  nh_14 = tmpvar_15;
					  mediump float y_16;
					  y_16 = (tmpvar_7 * 128.0);
					  highp float tmpvar_17;
					  tmpvar_17 = (pow (nh_14, y_16) * tmpvar_9.x);
					  c_13.xyz = (((
					    ((tmpvar_8.xyz * _Color.xyz) * _LightColor0.xyz)
					   * 
					    max (0.0, dot (worldN_1, lightDir_4))
					  ) + (
					    (_LightColor0.xyz * _SpecColor.xyz)
					   * tmpvar_17)) * 2.0);
					  c_13.w = ((tmpvar_8.w * _Color.w) + ((_LightColor0.w * _SpecColor.w) * tmpvar_17));
					  tmpvar_11 = c_13;
					  c_2.xyz = tmpvar_11.xyz;
					  c_2.w = 1.0;
					  gl_FragData[0] = c_2;
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
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out lowp vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out lowp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.z = u_xlat0.y;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat10_2.xyz);
					    u_xlat3 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat10_2.xyz = vec3(u_xlat3) * u_xlat10_2.xyz;
					    vs_TEXCOORD1.y = u_xlat10_2.x;
					    vs_TEXCOORD1.x = u_xlat1.z;
					    vs_TEXCOORD2.z = u_xlat0.z;
					    vs_TEXCOORD3.z = u_xlat0.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD2.y = u_xlat10_2.y;
					    vs_TEXCOORD3.y = u_xlat10_2.z;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD4.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp vec4 _SpecColor;
					uniform 	lowp vec4 _Color;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _SpecTex;
					uniform lowp sampler2D _BumpMap;
					in highp vec4 vs_TEXCOORD0;
					in lowp vec3 vs_TEXCOORD1;
					in lowp vec3 vs_TEXCOORD2;
					in lowp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					lowp vec3 u_xlat10_3;
					mediump float u_xlat16_4;
					mediump float u_xlat16_5;
					lowp float u_xlat10_5;
					lowp vec3 u_xlat10_7;
					float u_xlat15;
					mediump float u_xlat16_16;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
					    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
					    u_xlat16_16 = inversesqrt(u_xlat16_16);
					    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
					    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
					    u_xlat10_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat10_3.x = dot(vs_TEXCOORD1.xyz, u_xlat10_2.xyz);
					    u_xlat10_3.y = dot(vs_TEXCOORD2.xyz, u_xlat10_2.xyz);
					    u_xlat10_3.z = dot(vs_TEXCOORD3.xyz, u_xlat10_2.xyz);
					    u_xlat16_1.x = dot(u_xlat10_3.xyz, u_xlat16_1.xyz);
					    u_xlat10_2.x = dot(u_xlat10_3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat10_2.x = max(u_xlat10_2.x, 0.0);
					    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
					    u_xlat16_0.x = log2(u_xlat16_1.x);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = u_xlat10_1 * vs_COLOR0;
					    u_xlat16_4 = u_xlat16_1.w * 128.0;
					    u_xlat10_7.xyz = u_xlat16_1.xyz * _Color.xyz;
					    u_xlat10_7.xyz = u_xlat10_7.xyz * _LightColor0.xyz;
					    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_4;
					    u_xlat16_0.x = exp2(u_xlat16_0.x);
					    u_xlat10_5 = texture(_SpecTex, vs_TEXCOORD0.xy).x;
					    u_xlat16_5 = u_xlat10_5 * vs_COLOR0.x;
					    u_xlat16_0.x = u_xlat16_5 * u_xlat16_0.x;
					    u_xlat10_3.xyz = _LightColor0.xyz * _SpecColor.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat10_3.xyz;
					    u_xlat16_0.xyz = u_xlat10_7.xyz * u_xlat10_2.xxx + u_xlat16_0.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
					    SV_Target0.xyz = u_xlat16_0.xyz;
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
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out lowp vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out lowp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.z = u_xlat0.y;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat10_2.xyz);
					    u_xlat3 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat10_2.xyz = vec3(u_xlat3) * u_xlat10_2.xyz;
					    vs_TEXCOORD1.y = u_xlat10_2.x;
					    vs_TEXCOORD1.x = u_xlat1.z;
					    vs_TEXCOORD2.z = u_xlat0.z;
					    vs_TEXCOORD3.z = u_xlat0.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD2.y = u_xlat10_2.y;
					    vs_TEXCOORD3.y = u_xlat10_2.z;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD4.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp vec4 _SpecColor;
					uniform 	lowp vec4 _Color;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _SpecTex;
					uniform lowp sampler2D _BumpMap;
					in highp vec4 vs_TEXCOORD0;
					in lowp vec3 vs_TEXCOORD1;
					in lowp vec3 vs_TEXCOORD2;
					in lowp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					lowp vec3 u_xlat10_3;
					mediump float u_xlat16_4;
					mediump float u_xlat16_5;
					lowp float u_xlat10_5;
					lowp vec3 u_xlat10_7;
					float u_xlat15;
					mediump float u_xlat16_16;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
					    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
					    u_xlat16_16 = inversesqrt(u_xlat16_16);
					    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
					    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
					    u_xlat10_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat10_3.x = dot(vs_TEXCOORD1.xyz, u_xlat10_2.xyz);
					    u_xlat10_3.y = dot(vs_TEXCOORD2.xyz, u_xlat10_2.xyz);
					    u_xlat10_3.z = dot(vs_TEXCOORD3.xyz, u_xlat10_2.xyz);
					    u_xlat16_1.x = dot(u_xlat10_3.xyz, u_xlat16_1.xyz);
					    u_xlat10_2.x = dot(u_xlat10_3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat10_2.x = max(u_xlat10_2.x, 0.0);
					    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
					    u_xlat16_0.x = log2(u_xlat16_1.x);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = u_xlat10_1 * vs_COLOR0;
					    u_xlat16_4 = u_xlat16_1.w * 128.0;
					    u_xlat10_7.xyz = u_xlat16_1.xyz * _Color.xyz;
					    u_xlat10_7.xyz = u_xlat10_7.xyz * _LightColor0.xyz;
					    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_4;
					    u_xlat16_0.x = exp2(u_xlat16_0.x);
					    u_xlat10_5 = texture(_SpecTex, vs_TEXCOORD0.xy).x;
					    u_xlat16_5 = u_xlat10_5 * vs_COLOR0.x;
					    u_xlat16_0.x = u_xlat16_5 * u_xlat16_0.x;
					    u_xlat10_3.xyz = _LightColor0.xyz * _SpecColor.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat10_3.xyz;
					    u_xlat16_0.xyz = u_xlat10_7.xyz * u_xlat10_2.xxx + u_xlat16_0.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
					    SV_Target0.xyz = u_xlat16_0.xyz;
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
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out lowp vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out lowp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.z = u_xlat0.y;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat10_2.xyz);
					    u_xlat3 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat10_2.xyz = vec3(u_xlat3) * u_xlat10_2.xyz;
					    vs_TEXCOORD1.y = u_xlat10_2.x;
					    vs_TEXCOORD1.x = u_xlat1.z;
					    vs_TEXCOORD2.z = u_xlat0.z;
					    vs_TEXCOORD3.z = u_xlat0.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD2.y = u_xlat10_2.y;
					    vs_TEXCOORD3.y = u_xlat10_2.z;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD4.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp vec4 _SpecColor;
					uniform 	lowp vec4 _Color;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _SpecTex;
					uniform lowp sampler2D _BumpMap;
					in highp vec4 vs_TEXCOORD0;
					in lowp vec3 vs_TEXCOORD1;
					in lowp vec3 vs_TEXCOORD2;
					in lowp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					lowp vec3 u_xlat10_3;
					mediump float u_xlat16_4;
					mediump float u_xlat16_5;
					lowp float u_xlat10_5;
					lowp vec3 u_xlat10_7;
					float u_xlat15;
					mediump float u_xlat16_16;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat15) + _WorldSpaceLightPos0.xyz;
					    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
					    u_xlat16_16 = inversesqrt(u_xlat16_16);
					    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
					    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
					    u_xlat10_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat10_3.x = dot(vs_TEXCOORD1.xyz, u_xlat10_2.xyz);
					    u_xlat10_3.y = dot(vs_TEXCOORD2.xyz, u_xlat10_2.xyz);
					    u_xlat10_3.z = dot(vs_TEXCOORD3.xyz, u_xlat10_2.xyz);
					    u_xlat16_1.x = dot(u_xlat10_3.xyz, u_xlat16_1.xyz);
					    u_xlat10_2.x = dot(u_xlat10_3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat10_2.x = max(u_xlat10_2.x, 0.0);
					    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
					    u_xlat16_0.x = log2(u_xlat16_1.x);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = u_xlat10_1 * vs_COLOR0;
					    u_xlat16_4 = u_xlat16_1.w * 128.0;
					    u_xlat10_7.xyz = u_xlat16_1.xyz * _Color.xyz;
					    u_xlat10_7.xyz = u_xlat10_7.xyz * _LightColor0.xyz;
					    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_4;
					    u_xlat16_0.x = exp2(u_xlat16_0.x);
					    u_xlat10_5 = texture(_SpecTex, vs_TEXCOORD0.xy).x;
					    u_xlat16_5 = u_xlat10_5 * vs_COLOR0.x;
					    u_xlat16_0.x = u_xlat16_5 * u_xlat16_0.x;
					    u_xlat10_3.xyz = _LightColor0.xyz * _SpecColor.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat10_3.xyz;
					    u_xlat16_0.xyz = u_xlat10_7.xyz * u_xlat10_2.xxx + u_xlat16_0.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
					    SV_Target0.xyz = u_xlat16_0.xyz;
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
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
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
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  lowp vec3 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_5);
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _MainTex;
					uniform sampler2D _SpecTex;
					uniform sampler2D _BumpMap;
					uniform lowp vec4 _Color;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec3 worldN_1;
					  lowp vec4 c_2;
					  lowp float atten_3;
					  lowp vec3 worldViewDir_4;
					  lowp vec3 lightDir_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
					  lightDir_5 = tmpvar_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_4 = tmpvar_7;
					  mediump float tmpvar_8;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = (texture2D (_SpecTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  tmpvar_8 = tmpvar_9.w;
					  lowp vec3 tmpvar_11;
					  tmpvar_11 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
					  highp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = xlv_TEXCOORD4;
					  highp vec4 tmpvar_13;
					  tmpvar_13 = (unity_WorldToLight * tmpvar_12);
					  lowp vec4 tmpvar_14;
					  highp vec2 P_15;
					  P_15 = ((tmpvar_13.xy / tmpvar_13.w) + 0.5);
					  tmpvar_14 = texture2D (_LightTexture0, P_15);
					  highp float tmpvar_16;
					  tmpvar_16 = dot (tmpvar_13.xyz, tmpvar_13.xyz);
					  lowp vec4 tmpvar_17;
					  tmpvar_17 = texture2D (_LightTextureB0, vec2(tmpvar_16));
					  highp float tmpvar_18;
					  tmpvar_18 = ((float(
					    (tmpvar_13.z > 0.0)
					  ) * tmpvar_14.w) * tmpvar_17.w);
					  atten_3 = tmpvar_18;
					  worldN_1.x = dot (xlv_TEXCOORD1, tmpvar_11);
					  worldN_1.y = dot (xlv_TEXCOORD2, tmpvar_11);
					  worldN_1.z = dot (xlv_TEXCOORD3, tmpvar_11);
					  mediump vec4 tmpvar_19;
					  mediump vec3 viewDir_20;
					  viewDir_20 = worldViewDir_4;
					  lowp vec4 c_21;
					  highp float nh_22;
					  mediump float tmpvar_23;
					  tmpvar_23 = max (0.0, dot (worldN_1, normalize(
					    (lightDir_5 + viewDir_20)
					  )));
					  nh_22 = tmpvar_23;
					  mediump float y_24;
					  y_24 = (tmpvar_8 * 128.0);
					  highp float tmpvar_25;
					  tmpvar_25 = (pow (nh_22, y_24) * tmpvar_10.x);
					  c_21.xyz = (((
					    ((tmpvar_9.xyz * _Color.xyz) * _LightColor0.xyz)
					   * 
					    max (0.0, dot (worldN_1, lightDir_5))
					  ) + (
					    (_LightColor0.xyz * _SpecColor.xyz)
					   * tmpvar_25)) * (atten_3 * 2.0));
					  c_21.w = ((tmpvar_9.w * _Color.w) + ((_LightColor0.w * _SpecColor.w) * (tmpvar_25 * atten_3)));
					  tmpvar_19 = c_21;
					  c_2.xyz = tmpvar_19.xyz;
					  c_2.w = 1.0;
					  gl_FragData[0] = c_2;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
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
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  lowp vec3 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_5);
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _MainTex;
					uniform sampler2D _SpecTex;
					uniform sampler2D _BumpMap;
					uniform lowp vec4 _Color;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec3 worldN_1;
					  lowp vec4 c_2;
					  lowp float atten_3;
					  lowp vec3 worldViewDir_4;
					  lowp vec3 lightDir_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
					  lightDir_5 = tmpvar_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_4 = tmpvar_7;
					  mediump float tmpvar_8;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = (texture2D (_SpecTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  tmpvar_8 = tmpvar_9.w;
					  lowp vec3 tmpvar_11;
					  tmpvar_11 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
					  highp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = xlv_TEXCOORD4;
					  highp vec4 tmpvar_13;
					  tmpvar_13 = (unity_WorldToLight * tmpvar_12);
					  lowp vec4 tmpvar_14;
					  highp vec2 P_15;
					  P_15 = ((tmpvar_13.xy / tmpvar_13.w) + 0.5);
					  tmpvar_14 = texture2D (_LightTexture0, P_15);
					  highp float tmpvar_16;
					  tmpvar_16 = dot (tmpvar_13.xyz, tmpvar_13.xyz);
					  lowp vec4 tmpvar_17;
					  tmpvar_17 = texture2D (_LightTextureB0, vec2(tmpvar_16));
					  highp float tmpvar_18;
					  tmpvar_18 = ((float(
					    (tmpvar_13.z > 0.0)
					  ) * tmpvar_14.w) * tmpvar_17.w);
					  atten_3 = tmpvar_18;
					  worldN_1.x = dot (xlv_TEXCOORD1, tmpvar_11);
					  worldN_1.y = dot (xlv_TEXCOORD2, tmpvar_11);
					  worldN_1.z = dot (xlv_TEXCOORD3, tmpvar_11);
					  mediump vec4 tmpvar_19;
					  mediump vec3 viewDir_20;
					  viewDir_20 = worldViewDir_4;
					  lowp vec4 c_21;
					  highp float nh_22;
					  mediump float tmpvar_23;
					  tmpvar_23 = max (0.0, dot (worldN_1, normalize(
					    (lightDir_5 + viewDir_20)
					  )));
					  nh_22 = tmpvar_23;
					  mediump float y_24;
					  y_24 = (tmpvar_8 * 128.0);
					  highp float tmpvar_25;
					  tmpvar_25 = (pow (nh_22, y_24) * tmpvar_10.x);
					  c_21.xyz = (((
					    ((tmpvar_9.xyz * _Color.xyz) * _LightColor0.xyz)
					   * 
					    max (0.0, dot (worldN_1, lightDir_5))
					  ) + (
					    (_LightColor0.xyz * _SpecColor.xyz)
					   * tmpvar_25)) * (atten_3 * 2.0));
					  c_21.w = ((tmpvar_9.w * _Color.w) + ((_LightColor0.w * _SpecColor.w) * (tmpvar_25 * atten_3)));
					  tmpvar_19 = c_21;
					  c_2.xyz = tmpvar_19.xyz;
					  c_2.w = 1.0;
					  gl_FragData[0] = c_2;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {
Keywords { "SPOT" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
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
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  lowp vec3 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_5);
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _MainTex;
					uniform sampler2D _SpecTex;
					uniform sampler2D _BumpMap;
					uniform lowp vec4 _Color;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec3 worldN_1;
					  lowp vec4 c_2;
					  lowp float atten_3;
					  lowp vec3 worldViewDir_4;
					  lowp vec3 lightDir_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
					  lightDir_5 = tmpvar_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_4 = tmpvar_7;
					  mediump float tmpvar_8;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = (texture2D (_SpecTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  tmpvar_8 = tmpvar_9.w;
					  lowp vec3 tmpvar_11;
					  tmpvar_11 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
					  highp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = xlv_TEXCOORD4;
					  highp vec4 tmpvar_13;
					  tmpvar_13 = (unity_WorldToLight * tmpvar_12);
					  lowp vec4 tmpvar_14;
					  highp vec2 P_15;
					  P_15 = ((tmpvar_13.xy / tmpvar_13.w) + 0.5);
					  tmpvar_14 = texture2D (_LightTexture0, P_15);
					  highp float tmpvar_16;
					  tmpvar_16 = dot (tmpvar_13.xyz, tmpvar_13.xyz);
					  lowp vec4 tmpvar_17;
					  tmpvar_17 = texture2D (_LightTextureB0, vec2(tmpvar_16));
					  highp float tmpvar_18;
					  tmpvar_18 = ((float(
					    (tmpvar_13.z > 0.0)
					  ) * tmpvar_14.w) * tmpvar_17.w);
					  atten_3 = tmpvar_18;
					  worldN_1.x = dot (xlv_TEXCOORD1, tmpvar_11);
					  worldN_1.y = dot (xlv_TEXCOORD2, tmpvar_11);
					  worldN_1.z = dot (xlv_TEXCOORD3, tmpvar_11);
					  mediump vec4 tmpvar_19;
					  mediump vec3 viewDir_20;
					  viewDir_20 = worldViewDir_4;
					  lowp vec4 c_21;
					  highp float nh_22;
					  mediump float tmpvar_23;
					  tmpvar_23 = max (0.0, dot (worldN_1, normalize(
					    (lightDir_5 + viewDir_20)
					  )));
					  nh_22 = tmpvar_23;
					  mediump float y_24;
					  y_24 = (tmpvar_8 * 128.0);
					  highp float tmpvar_25;
					  tmpvar_25 = (pow (nh_22, y_24) * tmpvar_10.x);
					  c_21.xyz = (((
					    ((tmpvar_9.xyz * _Color.xyz) * _LightColor0.xyz)
					   * 
					    max (0.0, dot (worldN_1, lightDir_5))
					  ) + (
					    (_LightColor0.xyz * _SpecColor.xyz)
					   * tmpvar_25)) * (atten_3 * 2.0));
					  c_21.w = ((tmpvar_9.w * _Color.w) + ((_LightColor0.w * _SpecColor.w) * (tmpvar_25 * atten_3)));
					  tmpvar_19 = c_21;
					  c_2.xyz = tmpvar_19.xyz;
					  c_2.w = 1.0;
					  gl_FragData[0] = c_2;
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
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out lowp vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out lowp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.z = u_xlat0.y;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat10_2.xyz);
					    u_xlat3 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat10_2.xyz = vec3(u_xlat3) * u_xlat10_2.xyz;
					    vs_TEXCOORD1.y = u_xlat10_2.x;
					    vs_TEXCOORD1.x = u_xlat1.z;
					    vs_TEXCOORD2.z = u_xlat0.z;
					    vs_TEXCOORD3.z = u_xlat0.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD2.y = u_xlat10_2.y;
					    vs_TEXCOORD3.y = u_xlat10_2.z;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD4.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp vec4 _SpecColor;
					uniform 	vec4 hlslcc_mtx4unity_WorldToLight[4];
					uniform 	lowp vec4 _Color;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _SpecTex;
					uniform lowp sampler2D _BumpMap;
					uniform lowp sampler2D _LightTexture0;
					uniform lowp sampler2D _LightTextureB0;
					in highp vec4 vs_TEXCOORD0;
					in lowp vec3 vs_TEXCOORD1;
					in lowp vec3 vs_TEXCOORD2;
					in lowp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_3;
					lowp vec3 u_xlat10_4;
					vec2 u_xlat5;
					mediump float u_xlat16_6;
					lowp float u_xlat10_6;
					lowp vec3 u_xlat10_9;
					float u_xlat18;
					lowp float u_xlat10_18;
					bool u_xlatb19;
					mediump float u_xlat16_20;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat18) + u_xlat0.xyz;
					    u_xlat16_20 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
					    u_xlat16_20 = inversesqrt(u_xlat16_20);
					    u_xlat16_2.xyz = vec3(u_xlat16_20) * u_xlat16_2.xyz;
					    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
					    u_xlat10_3.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat10_4.x = dot(vs_TEXCOORD1.xyz, u_xlat10_3.xyz);
					    u_xlat10_4.y = dot(vs_TEXCOORD2.xyz, u_xlat10_3.xyz);
					    u_xlat10_4.z = dot(vs_TEXCOORD3.xyz, u_xlat10_3.xyz);
					    u_xlat16_2.x = dot(u_xlat10_4.xyz, u_xlat16_2.xyz);
					    u_xlat10_3.x = dot(u_xlat10_4.xyz, u_xlat0.xyz);
					    u_xlat10_3.x = max(u_xlat10_3.x, 0.0);
					    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
					    u_xlat16_0.x = log2(u_xlat16_2.x);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = u_xlat10_1 * vs_COLOR0;
					    u_xlat16_2.x = u_xlat16_1.w * 128.0;
					    u_xlat10_9.xyz = u_xlat16_1.xyz * _Color.xyz;
					    u_xlat10_9.xyz = u_xlat10_9.xyz * _LightColor0.xyz;
					    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_2.x;
					    u_xlat16_0.x = exp2(u_xlat16_0.x);
					    u_xlat10_6 = texture(_SpecTex, vs_TEXCOORD0.xy).x;
					    u_xlat16_6 = u_xlat10_6 * vs_COLOR0.x;
					    u_xlat16_0.x = u_xlat16_6 * u_xlat16_0.x;
					    u_xlat10_4.xyz = _LightColor0.xyz * _SpecColor.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat10_4.xyz;
					    u_xlat16_0.xyz = u_xlat10_9.xyz * u_xlat10_3.xxx + u_xlat16_0.xyz;
					    u_xlat1 = vs_TEXCOORD4.yyyy * hlslcc_mtx4unity_WorldToLight[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToLight[0] * vs_TEXCOORD4.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToLight[2] * vs_TEXCOORD4.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4unity_WorldToLight[3];
					    u_xlat5.xy = u_xlat1.xy / u_xlat1.ww;
					    u_xlat5.xy = u_xlat5.xy + vec2(0.5, 0.5);
					    u_xlat10_18 = texture(_LightTexture0, u_xlat5.xy).w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb19 = !!(0.0<u_xlat1.z);
					#else
					    u_xlatb19 = 0.0<u_xlat1.z;
					#endif
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10_1.x = texture(_LightTextureB0, u_xlat1.xx).w;
					    u_xlat10_3.x = (u_xlatb19) ? 1.0 : 0.0;
					    u_xlat10_3.x = u_xlat10_18 * u_xlat10_3.x;
					    u_xlat10_3.x = u_xlat10_1.x * u_xlat10_3.x;
					    u_xlat10_3.x = u_xlat10_3.x * 2.0;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_3.xxx;
					    SV_Target0.xyz = u_xlat16_0.xyz;
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
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out lowp vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out lowp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.z = u_xlat0.y;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat10_2.xyz);
					    u_xlat3 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat10_2.xyz = vec3(u_xlat3) * u_xlat10_2.xyz;
					    vs_TEXCOORD1.y = u_xlat10_2.x;
					    vs_TEXCOORD1.x = u_xlat1.z;
					    vs_TEXCOORD2.z = u_xlat0.z;
					    vs_TEXCOORD3.z = u_xlat0.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD2.y = u_xlat10_2.y;
					    vs_TEXCOORD3.y = u_xlat10_2.z;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD4.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp vec4 _SpecColor;
					uniform 	vec4 hlslcc_mtx4unity_WorldToLight[4];
					uniform 	lowp vec4 _Color;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _SpecTex;
					uniform lowp sampler2D _BumpMap;
					uniform lowp sampler2D _LightTexture0;
					uniform lowp sampler2D _LightTextureB0;
					in highp vec4 vs_TEXCOORD0;
					in lowp vec3 vs_TEXCOORD1;
					in lowp vec3 vs_TEXCOORD2;
					in lowp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_3;
					lowp vec3 u_xlat10_4;
					vec2 u_xlat5;
					mediump float u_xlat16_6;
					lowp float u_xlat10_6;
					lowp vec3 u_xlat10_9;
					float u_xlat18;
					lowp float u_xlat10_18;
					bool u_xlatb19;
					mediump float u_xlat16_20;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat18) + u_xlat0.xyz;
					    u_xlat16_20 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
					    u_xlat16_20 = inversesqrt(u_xlat16_20);
					    u_xlat16_2.xyz = vec3(u_xlat16_20) * u_xlat16_2.xyz;
					    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
					    u_xlat10_3.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat10_4.x = dot(vs_TEXCOORD1.xyz, u_xlat10_3.xyz);
					    u_xlat10_4.y = dot(vs_TEXCOORD2.xyz, u_xlat10_3.xyz);
					    u_xlat10_4.z = dot(vs_TEXCOORD3.xyz, u_xlat10_3.xyz);
					    u_xlat16_2.x = dot(u_xlat10_4.xyz, u_xlat16_2.xyz);
					    u_xlat10_3.x = dot(u_xlat10_4.xyz, u_xlat0.xyz);
					    u_xlat10_3.x = max(u_xlat10_3.x, 0.0);
					    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
					    u_xlat16_0.x = log2(u_xlat16_2.x);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = u_xlat10_1 * vs_COLOR0;
					    u_xlat16_2.x = u_xlat16_1.w * 128.0;
					    u_xlat10_9.xyz = u_xlat16_1.xyz * _Color.xyz;
					    u_xlat10_9.xyz = u_xlat10_9.xyz * _LightColor0.xyz;
					    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_2.x;
					    u_xlat16_0.x = exp2(u_xlat16_0.x);
					    u_xlat10_6 = texture(_SpecTex, vs_TEXCOORD0.xy).x;
					    u_xlat16_6 = u_xlat10_6 * vs_COLOR0.x;
					    u_xlat16_0.x = u_xlat16_6 * u_xlat16_0.x;
					    u_xlat10_4.xyz = _LightColor0.xyz * _SpecColor.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat10_4.xyz;
					    u_xlat16_0.xyz = u_xlat10_9.xyz * u_xlat10_3.xxx + u_xlat16_0.xyz;
					    u_xlat1 = vs_TEXCOORD4.yyyy * hlslcc_mtx4unity_WorldToLight[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToLight[0] * vs_TEXCOORD4.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToLight[2] * vs_TEXCOORD4.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4unity_WorldToLight[3];
					    u_xlat5.xy = u_xlat1.xy / u_xlat1.ww;
					    u_xlat5.xy = u_xlat5.xy + vec2(0.5, 0.5);
					    u_xlat10_18 = texture(_LightTexture0, u_xlat5.xy).w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb19 = !!(0.0<u_xlat1.z);
					#else
					    u_xlatb19 = 0.0<u_xlat1.z;
					#endif
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10_1.x = texture(_LightTextureB0, u_xlat1.xx).w;
					    u_xlat10_3.x = (u_xlatb19) ? 1.0 : 0.0;
					    u_xlat10_3.x = u_xlat10_18 * u_xlat10_3.x;
					    u_xlat10_3.x = u_xlat10_1.x * u_xlat10_3.x;
					    u_xlat10_3.x = u_xlat10_3.x * 2.0;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_3.xxx;
					    SV_Target0.xyz = u_xlat16_0.xyz;
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
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out lowp vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out lowp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.z = u_xlat0.y;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat10_2.xyz);
					    u_xlat3 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat10_2.xyz = vec3(u_xlat3) * u_xlat10_2.xyz;
					    vs_TEXCOORD1.y = u_xlat10_2.x;
					    vs_TEXCOORD1.x = u_xlat1.z;
					    vs_TEXCOORD2.z = u_xlat0.z;
					    vs_TEXCOORD3.z = u_xlat0.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD2.y = u_xlat10_2.y;
					    vs_TEXCOORD3.y = u_xlat10_2.z;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD4.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp vec4 _SpecColor;
					uniform 	vec4 hlslcc_mtx4unity_WorldToLight[4];
					uniform 	lowp vec4 _Color;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _SpecTex;
					uniform lowp sampler2D _BumpMap;
					uniform lowp sampler2D _LightTexture0;
					uniform lowp sampler2D _LightTextureB0;
					in highp vec4 vs_TEXCOORD0;
					in lowp vec3 vs_TEXCOORD1;
					in lowp vec3 vs_TEXCOORD2;
					in lowp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_3;
					lowp vec3 u_xlat10_4;
					vec2 u_xlat5;
					mediump float u_xlat16_6;
					lowp float u_xlat10_6;
					lowp vec3 u_xlat10_9;
					float u_xlat18;
					lowp float u_xlat10_18;
					bool u_xlatb19;
					mediump float u_xlat16_20;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat18) + u_xlat0.xyz;
					    u_xlat16_20 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
					    u_xlat16_20 = inversesqrt(u_xlat16_20);
					    u_xlat16_2.xyz = vec3(u_xlat16_20) * u_xlat16_2.xyz;
					    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
					    u_xlat10_3.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat10_4.x = dot(vs_TEXCOORD1.xyz, u_xlat10_3.xyz);
					    u_xlat10_4.y = dot(vs_TEXCOORD2.xyz, u_xlat10_3.xyz);
					    u_xlat10_4.z = dot(vs_TEXCOORD3.xyz, u_xlat10_3.xyz);
					    u_xlat16_2.x = dot(u_xlat10_4.xyz, u_xlat16_2.xyz);
					    u_xlat10_3.x = dot(u_xlat10_4.xyz, u_xlat0.xyz);
					    u_xlat10_3.x = max(u_xlat10_3.x, 0.0);
					    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
					    u_xlat16_0.x = log2(u_xlat16_2.x);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = u_xlat10_1 * vs_COLOR0;
					    u_xlat16_2.x = u_xlat16_1.w * 128.0;
					    u_xlat10_9.xyz = u_xlat16_1.xyz * _Color.xyz;
					    u_xlat10_9.xyz = u_xlat10_9.xyz * _LightColor0.xyz;
					    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_2.x;
					    u_xlat16_0.x = exp2(u_xlat16_0.x);
					    u_xlat10_6 = texture(_SpecTex, vs_TEXCOORD0.xy).x;
					    u_xlat16_6 = u_xlat10_6 * vs_COLOR0.x;
					    u_xlat16_0.x = u_xlat16_6 * u_xlat16_0.x;
					    u_xlat10_4.xyz = _LightColor0.xyz * _SpecColor.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat10_4.xyz;
					    u_xlat16_0.xyz = u_xlat10_9.xyz * u_xlat10_3.xxx + u_xlat16_0.xyz;
					    u_xlat1 = vs_TEXCOORD4.yyyy * hlslcc_mtx4unity_WorldToLight[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToLight[0] * vs_TEXCOORD4.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToLight[2] * vs_TEXCOORD4.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4unity_WorldToLight[3];
					    u_xlat5.xy = u_xlat1.xy / u_xlat1.ww;
					    u_xlat5.xy = u_xlat5.xy + vec2(0.5, 0.5);
					    u_xlat10_18 = texture(_LightTexture0, u_xlat5.xy).w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb19 = !!(0.0<u_xlat1.z);
					#else
					    u_xlatb19 = 0.0<u_xlat1.z;
					#endif
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10_1.x = texture(_LightTextureB0, u_xlat1.xx).w;
					    u_xlat10_3.x = (u_xlatb19) ? 1.0 : 0.0;
					    u_xlat10_3.x = u_xlat10_18 * u_xlat10_3.x;
					    u_xlat10_3.x = u_xlat10_1.x * u_xlat10_3.x;
					    u_xlat10_3.x = u_xlat10_3.x * 2.0;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_3.xxx;
					    SV_Target0.xyz = u_xlat16_0.xyz;
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
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
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
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  lowp vec3 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_5);
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform lowp samplerCube _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _MainTex;
					uniform sampler2D _SpecTex;
					uniform sampler2D _BumpMap;
					uniform lowp vec4 _Color;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec3 worldN_1;
					  lowp vec4 c_2;
					  lowp vec3 worldViewDir_3;
					  lowp vec3 lightDir_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
					  lightDir_4 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_3 = tmpvar_6;
					  mediump float tmpvar_7;
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_SpecTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  tmpvar_7 = tmpvar_8.w;
					  lowp vec3 tmpvar_10;
					  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = xlv_TEXCOORD4;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (unity_WorldToLight * tmpvar_11).xyz;
					  highp float tmpvar_13;
					  tmpvar_13 = dot (tmpvar_12, tmpvar_12);
					  lowp float tmpvar_14;
					  tmpvar_14 = (texture2D (_LightTextureB0, vec2(tmpvar_13)).w * textureCube (_LightTexture0, tmpvar_12).w);
					  worldN_1.x = dot (xlv_TEXCOORD1, tmpvar_10);
					  worldN_1.y = dot (xlv_TEXCOORD2, tmpvar_10);
					  worldN_1.z = dot (xlv_TEXCOORD3, tmpvar_10);
					  mediump vec4 tmpvar_15;
					  mediump vec3 viewDir_16;
					  viewDir_16 = worldViewDir_3;
					  lowp vec4 c_17;
					  highp float nh_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = max (0.0, dot (worldN_1, normalize(
					    (lightDir_4 + viewDir_16)
					  )));
					  nh_18 = tmpvar_19;
					  mediump float y_20;
					  y_20 = (tmpvar_7 * 128.0);
					  highp float tmpvar_21;
					  tmpvar_21 = (pow (nh_18, y_20) * tmpvar_9.x);
					  c_17.xyz = (((
					    ((tmpvar_8.xyz * _Color.xyz) * _LightColor0.xyz)
					   * 
					    max (0.0, dot (worldN_1, lightDir_4))
					  ) + (
					    (_LightColor0.xyz * _SpecColor.xyz)
					   * tmpvar_21)) * (tmpvar_14 * 2.0));
					  c_17.w = ((tmpvar_8.w * _Color.w) + ((_LightColor0.w * _SpecColor.w) * (tmpvar_21 * tmpvar_14)));
					  tmpvar_15 = c_17;
					  c_2.xyz = tmpvar_15.xyz;
					  c_2.w = 1.0;
					  gl_FragData[0] = c_2;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
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
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  lowp vec3 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_5);
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform lowp samplerCube _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _MainTex;
					uniform sampler2D _SpecTex;
					uniform sampler2D _BumpMap;
					uniform lowp vec4 _Color;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec3 worldN_1;
					  lowp vec4 c_2;
					  lowp vec3 worldViewDir_3;
					  lowp vec3 lightDir_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
					  lightDir_4 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_3 = tmpvar_6;
					  mediump float tmpvar_7;
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_SpecTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  tmpvar_7 = tmpvar_8.w;
					  lowp vec3 tmpvar_10;
					  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = xlv_TEXCOORD4;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (unity_WorldToLight * tmpvar_11).xyz;
					  highp float tmpvar_13;
					  tmpvar_13 = dot (tmpvar_12, tmpvar_12);
					  lowp float tmpvar_14;
					  tmpvar_14 = (texture2D (_LightTextureB0, vec2(tmpvar_13)).w * textureCube (_LightTexture0, tmpvar_12).w);
					  worldN_1.x = dot (xlv_TEXCOORD1, tmpvar_10);
					  worldN_1.y = dot (xlv_TEXCOORD2, tmpvar_10);
					  worldN_1.z = dot (xlv_TEXCOORD3, tmpvar_10);
					  mediump vec4 tmpvar_15;
					  mediump vec3 viewDir_16;
					  viewDir_16 = worldViewDir_3;
					  lowp vec4 c_17;
					  highp float nh_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = max (0.0, dot (worldN_1, normalize(
					    (lightDir_4 + viewDir_16)
					  )));
					  nh_18 = tmpvar_19;
					  mediump float y_20;
					  y_20 = (tmpvar_7 * 128.0);
					  highp float tmpvar_21;
					  tmpvar_21 = (pow (nh_18, y_20) * tmpvar_9.x);
					  c_17.xyz = (((
					    ((tmpvar_8.xyz * _Color.xyz) * _LightColor0.xyz)
					   * 
					    max (0.0, dot (worldN_1, lightDir_4))
					  ) + (
					    (_LightColor0.xyz * _SpecColor.xyz)
					   * tmpvar_21)) * (tmpvar_14 * 2.0));
					  c_17.w = ((tmpvar_8.w * _Color.w) + ((_LightColor0.w * _SpecColor.w) * (tmpvar_21 * tmpvar_14)));
					  tmpvar_15 = c_17;
					  c_2.xyz = tmpvar_15.xyz;
					  c_2.w = 1.0;
					  gl_FragData[0] = c_2;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {
Keywords { "POINT_COOKIE" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
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
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  lowp vec3 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_5);
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform lowp samplerCube _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _MainTex;
					uniform sampler2D _SpecTex;
					uniform sampler2D _BumpMap;
					uniform lowp vec4 _Color;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec3 worldN_1;
					  lowp vec4 c_2;
					  lowp vec3 worldViewDir_3;
					  lowp vec3 lightDir_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
					  lightDir_4 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_3 = tmpvar_6;
					  mediump float tmpvar_7;
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_SpecTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  tmpvar_7 = tmpvar_8.w;
					  lowp vec3 tmpvar_10;
					  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = xlv_TEXCOORD4;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (unity_WorldToLight * tmpvar_11).xyz;
					  highp float tmpvar_13;
					  tmpvar_13 = dot (tmpvar_12, tmpvar_12);
					  lowp float tmpvar_14;
					  tmpvar_14 = (texture2D (_LightTextureB0, vec2(tmpvar_13)).w * textureCube (_LightTexture0, tmpvar_12).w);
					  worldN_1.x = dot (xlv_TEXCOORD1, tmpvar_10);
					  worldN_1.y = dot (xlv_TEXCOORD2, tmpvar_10);
					  worldN_1.z = dot (xlv_TEXCOORD3, tmpvar_10);
					  mediump vec4 tmpvar_15;
					  mediump vec3 viewDir_16;
					  viewDir_16 = worldViewDir_3;
					  lowp vec4 c_17;
					  highp float nh_18;
					  mediump float tmpvar_19;
					  tmpvar_19 = max (0.0, dot (worldN_1, normalize(
					    (lightDir_4 + viewDir_16)
					  )));
					  nh_18 = tmpvar_19;
					  mediump float y_20;
					  y_20 = (tmpvar_7 * 128.0);
					  highp float tmpvar_21;
					  tmpvar_21 = (pow (nh_18, y_20) * tmpvar_9.x);
					  c_17.xyz = (((
					    ((tmpvar_8.xyz * _Color.xyz) * _LightColor0.xyz)
					   * 
					    max (0.0, dot (worldN_1, lightDir_4))
					  ) + (
					    (_LightColor0.xyz * _SpecColor.xyz)
					   * tmpvar_21)) * (tmpvar_14 * 2.0));
					  c_17.w = ((tmpvar_8.w * _Color.w) + ((_LightColor0.w * _SpecColor.w) * (tmpvar_21 * tmpvar_14)));
					  tmpvar_15 = c_17;
					  c_2.xyz = tmpvar_15.xyz;
					  c_2.w = 1.0;
					  gl_FragData[0] = c_2;
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
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out lowp vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out lowp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.z = u_xlat0.y;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat10_2.xyz);
					    u_xlat3 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat10_2.xyz = vec3(u_xlat3) * u_xlat10_2.xyz;
					    vs_TEXCOORD1.y = u_xlat10_2.x;
					    vs_TEXCOORD1.x = u_xlat1.z;
					    vs_TEXCOORD2.z = u_xlat0.z;
					    vs_TEXCOORD3.z = u_xlat0.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD2.y = u_xlat10_2.y;
					    vs_TEXCOORD3.y = u_xlat10_2.z;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD4.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp vec4 _SpecColor;
					uniform 	vec4 hlslcc_mtx4unity_WorldToLight[4];
					uniform 	lowp vec4 _Color;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _SpecTex;
					uniform lowp sampler2D _BumpMap;
					uniform lowp sampler2D _LightTextureB0;
					uniform lowp samplerCube _LightTexture0;
					in highp vec4 vs_TEXCOORD0;
					in lowp vec3 vs_TEXCOORD1;
					in lowp vec3 vs_TEXCOORD2;
					in lowp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec3 u_xlat1;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_3;
					lowp vec3 u_xlat10_4;
					mediump float u_xlat16_5;
					lowp float u_xlat10_5;
					lowp vec3 u_xlat10_8;
					float u_xlat15;
					mediump float u_xlat16_15;
					lowp float u_xlat10_15;
					mediump float u_xlat16_17;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    u_xlat16_17 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
					    u_xlat16_17 = inversesqrt(u_xlat16_17);
					    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
					    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
					    u_xlat10_3.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat10_4.x = dot(vs_TEXCOORD1.xyz, u_xlat10_3.xyz);
					    u_xlat10_4.y = dot(vs_TEXCOORD2.xyz, u_xlat10_3.xyz);
					    u_xlat10_4.z = dot(vs_TEXCOORD3.xyz, u_xlat10_3.xyz);
					    u_xlat16_2.x = dot(u_xlat10_4.xyz, u_xlat16_2.xyz);
					    u_xlat10_3.x = dot(u_xlat10_4.xyz, u_xlat0.xyz);
					    u_xlat10_3.x = max(u_xlat10_3.x, 0.0);
					    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
					    u_xlat16_0.x = log2(u_xlat16_2.x);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = u_xlat10_1 * vs_COLOR0;
					    u_xlat16_2.x = u_xlat16_1.w * 128.0;
					    u_xlat10_8.xyz = u_xlat16_1.xyz * _Color.xyz;
					    u_xlat10_8.xyz = u_xlat10_8.xyz * _LightColor0.xyz;
					    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_2.x;
					    u_xlat16_0.x = exp2(u_xlat16_0.x);
					    u_xlat10_5 = texture(_SpecTex, vs_TEXCOORD0.xy).x;
					    u_xlat16_5 = u_xlat10_5 * vs_COLOR0.x;
					    u_xlat16_0.x = u_xlat16_5 * u_xlat16_0.x;
					    u_xlat10_4.xyz = _LightColor0.xyz * _SpecColor.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat10_4.xyz;
					    u_xlat16_0.xyz = u_xlat10_8.xyz * u_xlat10_3.xxx + u_xlat16_0.xyz;
					    u_xlat1.xyz = vs_TEXCOORD4.yyy * hlslcc_mtx4unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToLight[0].xyz * vs_TEXCOORD4.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToLight[2].xyz * vs_TEXCOORD4.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_WorldToLight[3].xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10_1.x = texture(_LightTexture0, u_xlat1.xyz).w;
					    u_xlat10_15 = texture(_LightTextureB0, vec2(u_xlat15)).w;
					    u_xlat16_15 = u_xlat10_1.x * u_xlat10_15;
					    u_xlat10_3.x = u_xlat16_15 * 2.0;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_3.xxx;
					    SV_Target0.xyz = u_xlat16_0.xyz;
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
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out lowp vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out lowp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.z = u_xlat0.y;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat10_2.xyz);
					    u_xlat3 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat10_2.xyz = vec3(u_xlat3) * u_xlat10_2.xyz;
					    vs_TEXCOORD1.y = u_xlat10_2.x;
					    vs_TEXCOORD1.x = u_xlat1.z;
					    vs_TEXCOORD2.z = u_xlat0.z;
					    vs_TEXCOORD3.z = u_xlat0.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD2.y = u_xlat10_2.y;
					    vs_TEXCOORD3.y = u_xlat10_2.z;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD4.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp vec4 _SpecColor;
					uniform 	vec4 hlslcc_mtx4unity_WorldToLight[4];
					uniform 	lowp vec4 _Color;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _SpecTex;
					uniform lowp sampler2D _BumpMap;
					uniform lowp sampler2D _LightTextureB0;
					uniform lowp samplerCube _LightTexture0;
					in highp vec4 vs_TEXCOORD0;
					in lowp vec3 vs_TEXCOORD1;
					in lowp vec3 vs_TEXCOORD2;
					in lowp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec3 u_xlat1;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_3;
					lowp vec3 u_xlat10_4;
					mediump float u_xlat16_5;
					lowp float u_xlat10_5;
					lowp vec3 u_xlat10_8;
					float u_xlat15;
					mediump float u_xlat16_15;
					lowp float u_xlat10_15;
					mediump float u_xlat16_17;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    u_xlat16_17 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
					    u_xlat16_17 = inversesqrt(u_xlat16_17);
					    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
					    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
					    u_xlat10_3.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat10_4.x = dot(vs_TEXCOORD1.xyz, u_xlat10_3.xyz);
					    u_xlat10_4.y = dot(vs_TEXCOORD2.xyz, u_xlat10_3.xyz);
					    u_xlat10_4.z = dot(vs_TEXCOORD3.xyz, u_xlat10_3.xyz);
					    u_xlat16_2.x = dot(u_xlat10_4.xyz, u_xlat16_2.xyz);
					    u_xlat10_3.x = dot(u_xlat10_4.xyz, u_xlat0.xyz);
					    u_xlat10_3.x = max(u_xlat10_3.x, 0.0);
					    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
					    u_xlat16_0.x = log2(u_xlat16_2.x);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = u_xlat10_1 * vs_COLOR0;
					    u_xlat16_2.x = u_xlat16_1.w * 128.0;
					    u_xlat10_8.xyz = u_xlat16_1.xyz * _Color.xyz;
					    u_xlat10_8.xyz = u_xlat10_8.xyz * _LightColor0.xyz;
					    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_2.x;
					    u_xlat16_0.x = exp2(u_xlat16_0.x);
					    u_xlat10_5 = texture(_SpecTex, vs_TEXCOORD0.xy).x;
					    u_xlat16_5 = u_xlat10_5 * vs_COLOR0.x;
					    u_xlat16_0.x = u_xlat16_5 * u_xlat16_0.x;
					    u_xlat10_4.xyz = _LightColor0.xyz * _SpecColor.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat10_4.xyz;
					    u_xlat16_0.xyz = u_xlat10_8.xyz * u_xlat10_3.xxx + u_xlat16_0.xyz;
					    u_xlat1.xyz = vs_TEXCOORD4.yyy * hlslcc_mtx4unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToLight[0].xyz * vs_TEXCOORD4.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToLight[2].xyz * vs_TEXCOORD4.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_WorldToLight[3].xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10_1.x = texture(_LightTexture0, u_xlat1.xyz).w;
					    u_xlat10_15 = texture(_LightTextureB0, vec2(u_xlat15)).w;
					    u_xlat16_15 = u_xlat10_1.x * u_xlat10_15;
					    u_xlat10_3.x = u_xlat16_15 * 2.0;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_3.xxx;
					    SV_Target0.xyz = u_xlat16_0.xyz;
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
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out lowp vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out lowp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.z = u_xlat0.y;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat10_2.xyz);
					    u_xlat3 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat10_2.xyz = vec3(u_xlat3) * u_xlat10_2.xyz;
					    vs_TEXCOORD1.y = u_xlat10_2.x;
					    vs_TEXCOORD1.x = u_xlat1.z;
					    vs_TEXCOORD2.z = u_xlat0.z;
					    vs_TEXCOORD3.z = u_xlat0.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD2.y = u_xlat10_2.y;
					    vs_TEXCOORD3.y = u_xlat10_2.z;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD4.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp vec4 _SpecColor;
					uniform 	vec4 hlslcc_mtx4unity_WorldToLight[4];
					uniform 	lowp vec4 _Color;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _SpecTex;
					uniform lowp sampler2D _BumpMap;
					uniform lowp sampler2D _LightTextureB0;
					uniform lowp samplerCube _LightTexture0;
					in highp vec4 vs_TEXCOORD0;
					in lowp vec3 vs_TEXCOORD1;
					in lowp vec3 vs_TEXCOORD2;
					in lowp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec3 u_xlat1;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_3;
					lowp vec3 u_xlat10_4;
					mediump float u_xlat16_5;
					lowp float u_xlat10_5;
					lowp vec3 u_xlat10_8;
					float u_xlat15;
					mediump float u_xlat16_15;
					lowp float u_xlat10_15;
					mediump float u_xlat16_17;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    u_xlat16_17 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
					    u_xlat16_17 = inversesqrt(u_xlat16_17);
					    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
					    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
					    u_xlat10_3.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat10_4.x = dot(vs_TEXCOORD1.xyz, u_xlat10_3.xyz);
					    u_xlat10_4.y = dot(vs_TEXCOORD2.xyz, u_xlat10_3.xyz);
					    u_xlat10_4.z = dot(vs_TEXCOORD3.xyz, u_xlat10_3.xyz);
					    u_xlat16_2.x = dot(u_xlat10_4.xyz, u_xlat16_2.xyz);
					    u_xlat10_3.x = dot(u_xlat10_4.xyz, u_xlat0.xyz);
					    u_xlat10_3.x = max(u_xlat10_3.x, 0.0);
					    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
					    u_xlat16_0.x = log2(u_xlat16_2.x);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = u_xlat10_1 * vs_COLOR0;
					    u_xlat16_2.x = u_xlat16_1.w * 128.0;
					    u_xlat10_8.xyz = u_xlat16_1.xyz * _Color.xyz;
					    u_xlat10_8.xyz = u_xlat10_8.xyz * _LightColor0.xyz;
					    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_2.x;
					    u_xlat16_0.x = exp2(u_xlat16_0.x);
					    u_xlat10_5 = texture(_SpecTex, vs_TEXCOORD0.xy).x;
					    u_xlat16_5 = u_xlat10_5 * vs_COLOR0.x;
					    u_xlat16_0.x = u_xlat16_5 * u_xlat16_0.x;
					    u_xlat10_4.xyz = _LightColor0.xyz * _SpecColor.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat10_4.xyz;
					    u_xlat16_0.xyz = u_xlat10_8.xyz * u_xlat10_3.xxx + u_xlat16_0.xyz;
					    u_xlat1.xyz = vs_TEXCOORD4.yyy * hlslcc_mtx4unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToLight[0].xyz * vs_TEXCOORD4.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToLight[2].xyz * vs_TEXCOORD4.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_WorldToLight[3].xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10_1.x = texture(_LightTexture0, u_xlat1.xyz).w;
					    u_xlat10_15 = texture(_LightTextureB0, vec2(u_xlat15)).w;
					    u_xlat16_15 = u_xlat10_1.x * u_xlat10_15;
					    u_xlat10_3.x = u_xlat16_15 * 2.0;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_3.xxx;
					    SV_Target0.xyz = u_xlat16_0.xyz;
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
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
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
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  lowp vec3 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_5);
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _MainTex;
					uniform sampler2D _SpecTex;
					uniform sampler2D _BumpMap;
					uniform lowp vec4 _Color;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec3 worldN_1;
					  lowp vec4 c_2;
					  lowp vec3 worldViewDir_3;
					  lowp vec3 lightDir_4;
					  mediump vec3 tmpvar_5;
					  tmpvar_5 = _WorldSpaceLightPos0.xyz;
					  lightDir_4 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_3 = tmpvar_6;
					  mediump float tmpvar_7;
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_SpecTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  tmpvar_7 = tmpvar_8.w;
					  lowp vec3 tmpvar_10;
					  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = xlv_TEXCOORD4;
					  highp vec2 tmpvar_12;
					  tmpvar_12 = (unity_WorldToLight * tmpvar_11).xy;
					  lowp float tmpvar_13;
					  tmpvar_13 = texture2D (_LightTexture0, tmpvar_12).w;
					  worldN_1.x = dot (xlv_TEXCOORD1, tmpvar_10);
					  worldN_1.y = dot (xlv_TEXCOORD2, tmpvar_10);
					  worldN_1.z = dot (xlv_TEXCOORD3, tmpvar_10);
					  mediump vec4 tmpvar_14;
					  mediump vec3 viewDir_15;
					  viewDir_15 = worldViewDir_3;
					  lowp vec4 c_16;
					  highp float nh_17;
					  mediump float tmpvar_18;
					  tmpvar_18 = max (0.0, dot (worldN_1, normalize(
					    (lightDir_4 + viewDir_15)
					  )));
					  nh_17 = tmpvar_18;
					  mediump float y_19;
					  y_19 = (tmpvar_7 * 128.0);
					  highp float tmpvar_20;
					  tmpvar_20 = (pow (nh_17, y_19) * tmpvar_9.x);
					  c_16.xyz = (((
					    ((tmpvar_8.xyz * _Color.xyz) * _LightColor0.xyz)
					   * 
					    max (0.0, dot (worldN_1, lightDir_4))
					  ) + (
					    (_LightColor0.xyz * _SpecColor.xyz)
					   * tmpvar_20)) * (tmpvar_13 * 2.0));
					  c_16.w = ((tmpvar_8.w * _Color.w) + ((_LightColor0.w * _SpecColor.w) * (tmpvar_20 * tmpvar_13)));
					  tmpvar_14 = c_16;
					  c_2.xyz = tmpvar_14.xyz;
					  c_2.w = 1.0;
					  gl_FragData[0] = c_2;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
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
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  lowp vec3 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_5);
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _MainTex;
					uniform sampler2D _SpecTex;
					uniform sampler2D _BumpMap;
					uniform lowp vec4 _Color;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec3 worldN_1;
					  lowp vec4 c_2;
					  lowp vec3 worldViewDir_3;
					  lowp vec3 lightDir_4;
					  mediump vec3 tmpvar_5;
					  tmpvar_5 = _WorldSpaceLightPos0.xyz;
					  lightDir_4 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_3 = tmpvar_6;
					  mediump float tmpvar_7;
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_SpecTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  tmpvar_7 = tmpvar_8.w;
					  lowp vec3 tmpvar_10;
					  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = xlv_TEXCOORD4;
					  highp vec2 tmpvar_12;
					  tmpvar_12 = (unity_WorldToLight * tmpvar_11).xy;
					  lowp float tmpvar_13;
					  tmpvar_13 = texture2D (_LightTexture0, tmpvar_12).w;
					  worldN_1.x = dot (xlv_TEXCOORD1, tmpvar_10);
					  worldN_1.y = dot (xlv_TEXCOORD2, tmpvar_10);
					  worldN_1.z = dot (xlv_TEXCOORD3, tmpvar_10);
					  mediump vec4 tmpvar_14;
					  mediump vec3 viewDir_15;
					  viewDir_15 = worldViewDir_3;
					  lowp vec4 c_16;
					  highp float nh_17;
					  mediump float tmpvar_18;
					  tmpvar_18 = max (0.0, dot (worldN_1, normalize(
					    (lightDir_4 + viewDir_15)
					  )));
					  nh_17 = tmpvar_18;
					  mediump float y_19;
					  y_19 = (tmpvar_7 * 128.0);
					  highp float tmpvar_20;
					  tmpvar_20 = (pow (nh_17, y_19) * tmpvar_9.x);
					  c_16.xyz = (((
					    ((tmpvar_8.xyz * _Color.xyz) * _LightColor0.xyz)
					   * 
					    max (0.0, dot (worldN_1, lightDir_4))
					  ) + (
					    (_LightColor0.xyz * _SpecColor.xyz)
					   * tmpvar_20)) * (tmpvar_13 * 2.0));
					  c_16.w = ((tmpvar_8.w * _Color.w) + ((_LightColor0.w * _SpecColor.w) * (tmpvar_20 * tmpvar_13)));
					  tmpvar_14 = c_16;
					  c_2.xyz = tmpvar_14.xyz;
					  c_2.w = 1.0;
					  gl_FragData[0] = c_2;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL_COOKIE" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
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
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  lowp vec3 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_5);
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _MainTex;
					uniform sampler2D _SpecTex;
					uniform sampler2D _BumpMap;
					uniform lowp vec4 _Color;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec3 worldN_1;
					  lowp vec4 c_2;
					  lowp vec3 worldViewDir_3;
					  lowp vec3 lightDir_4;
					  mediump vec3 tmpvar_5;
					  tmpvar_5 = _WorldSpaceLightPos0.xyz;
					  lightDir_4 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_3 = tmpvar_6;
					  mediump float tmpvar_7;
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (texture2D (_SpecTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  tmpvar_7 = tmpvar_8.w;
					  lowp vec3 tmpvar_10;
					  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = xlv_TEXCOORD4;
					  highp vec2 tmpvar_12;
					  tmpvar_12 = (unity_WorldToLight * tmpvar_11).xy;
					  lowp float tmpvar_13;
					  tmpvar_13 = texture2D (_LightTexture0, tmpvar_12).w;
					  worldN_1.x = dot (xlv_TEXCOORD1, tmpvar_10);
					  worldN_1.y = dot (xlv_TEXCOORD2, tmpvar_10);
					  worldN_1.z = dot (xlv_TEXCOORD3, tmpvar_10);
					  mediump vec4 tmpvar_14;
					  mediump vec3 viewDir_15;
					  viewDir_15 = worldViewDir_3;
					  lowp vec4 c_16;
					  highp float nh_17;
					  mediump float tmpvar_18;
					  tmpvar_18 = max (0.0, dot (worldN_1, normalize(
					    (lightDir_4 + viewDir_15)
					  )));
					  nh_17 = tmpvar_18;
					  mediump float y_19;
					  y_19 = (tmpvar_7 * 128.0);
					  highp float tmpvar_20;
					  tmpvar_20 = (pow (nh_17, y_19) * tmpvar_9.x);
					  c_16.xyz = (((
					    ((tmpvar_8.xyz * _Color.xyz) * _LightColor0.xyz)
					   * 
					    max (0.0, dot (worldN_1, lightDir_4))
					  ) + (
					    (_LightColor0.xyz * _SpecColor.xyz)
					   * tmpvar_20)) * (tmpvar_13 * 2.0));
					  c_16.w = ((tmpvar_8.w * _Color.w) + ((_LightColor0.w * _SpecColor.w) * (tmpvar_20 * tmpvar_13)));
					  tmpvar_14 = c_16;
					  c_2.xyz = tmpvar_14.xyz;
					  c_2.w = 1.0;
					  gl_FragData[0] = c_2;
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
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out lowp vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out lowp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.z = u_xlat0.y;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat10_2.xyz);
					    u_xlat3 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat10_2.xyz = vec3(u_xlat3) * u_xlat10_2.xyz;
					    vs_TEXCOORD1.y = u_xlat10_2.x;
					    vs_TEXCOORD1.x = u_xlat1.z;
					    vs_TEXCOORD2.z = u_xlat0.z;
					    vs_TEXCOORD3.z = u_xlat0.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD2.y = u_xlat10_2.y;
					    vs_TEXCOORD3.y = u_xlat10_2.z;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD4.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp vec4 _SpecColor;
					uniform 	vec4 hlslcc_mtx4unity_WorldToLight[4];
					uniform 	lowp vec4 _Color;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _SpecTex;
					uniform lowp sampler2D _BumpMap;
					uniform lowp sampler2D _LightTexture0;
					in highp vec4 vs_TEXCOORD0;
					in lowp vec3 vs_TEXCOORD1;
					in lowp vec3 vs_TEXCOORD2;
					in lowp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					lowp vec3 u_xlat10_3;
					mediump float u_xlat16_4;
					vec2 u_xlat5;
					mediump float u_xlat16_6;
					lowp float u_xlat10_6;
					lowp vec3 u_xlat10_8;
					float u_xlat18;
					lowp float u_xlat10_18;
					mediump float u_xlat16_19;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
					    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
					    u_xlat16_19 = inversesqrt(u_xlat16_19);
					    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
					    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
					    u_xlat10_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat10_3.x = dot(vs_TEXCOORD1.xyz, u_xlat10_2.xyz);
					    u_xlat10_3.y = dot(vs_TEXCOORD2.xyz, u_xlat10_2.xyz);
					    u_xlat10_3.z = dot(vs_TEXCOORD3.xyz, u_xlat10_2.xyz);
					    u_xlat16_1.x = dot(u_xlat10_3.xyz, u_xlat16_1.xyz);
					    u_xlat10_2.x = dot(u_xlat10_3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat10_2.x = max(u_xlat10_2.x, 0.0);
					    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
					    u_xlat16_0.x = log2(u_xlat16_1.x);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = u_xlat10_1 * vs_COLOR0;
					    u_xlat16_4 = u_xlat16_1.w * 128.0;
					    u_xlat10_8.xyz = u_xlat16_1.xyz * _Color.xyz;
					    u_xlat10_8.xyz = u_xlat10_8.xyz * _LightColor0.xyz;
					    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_4;
					    u_xlat16_0.x = exp2(u_xlat16_0.x);
					    u_xlat10_6 = texture(_SpecTex, vs_TEXCOORD0.xy).x;
					    u_xlat16_6 = u_xlat10_6 * vs_COLOR0.x;
					    u_xlat16_0.x = u_xlat16_6 * u_xlat16_0.x;
					    u_xlat10_3.xyz = _LightColor0.xyz * _SpecColor.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat10_3.xyz;
					    u_xlat16_0.xyz = u_xlat10_8.xyz * u_xlat10_2.xxx + u_xlat16_0.xyz;
					    u_xlat5.xy = vs_TEXCOORD4.yy * hlslcc_mtx4unity_WorldToLight[1].xy;
					    u_xlat5.xy = hlslcc_mtx4unity_WorldToLight[0].xy * vs_TEXCOORD4.xx + u_xlat5.xy;
					    u_xlat5.xy = hlslcc_mtx4unity_WorldToLight[2].xy * vs_TEXCOORD4.zz + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy + hlslcc_mtx4unity_WorldToLight[3].xy;
					    u_xlat10_18 = texture(_LightTexture0, u_xlat5.xy).w;
					    u_xlat10_2.x = u_xlat10_18 * 2.0;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_2.xxx;
					    SV_Target0.xyz = u_xlat16_0.xyz;
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
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out lowp vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out lowp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.z = u_xlat0.y;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat10_2.xyz);
					    u_xlat3 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat10_2.xyz = vec3(u_xlat3) * u_xlat10_2.xyz;
					    vs_TEXCOORD1.y = u_xlat10_2.x;
					    vs_TEXCOORD1.x = u_xlat1.z;
					    vs_TEXCOORD2.z = u_xlat0.z;
					    vs_TEXCOORD3.z = u_xlat0.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD2.y = u_xlat10_2.y;
					    vs_TEXCOORD3.y = u_xlat10_2.z;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD4.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp vec4 _SpecColor;
					uniform 	vec4 hlslcc_mtx4unity_WorldToLight[4];
					uniform 	lowp vec4 _Color;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _SpecTex;
					uniform lowp sampler2D _BumpMap;
					uniform lowp sampler2D _LightTexture0;
					in highp vec4 vs_TEXCOORD0;
					in lowp vec3 vs_TEXCOORD1;
					in lowp vec3 vs_TEXCOORD2;
					in lowp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					lowp vec3 u_xlat10_3;
					mediump float u_xlat16_4;
					vec2 u_xlat5;
					mediump float u_xlat16_6;
					lowp float u_xlat10_6;
					lowp vec3 u_xlat10_8;
					float u_xlat18;
					lowp float u_xlat10_18;
					mediump float u_xlat16_19;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
					    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
					    u_xlat16_19 = inversesqrt(u_xlat16_19);
					    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
					    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
					    u_xlat10_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat10_3.x = dot(vs_TEXCOORD1.xyz, u_xlat10_2.xyz);
					    u_xlat10_3.y = dot(vs_TEXCOORD2.xyz, u_xlat10_2.xyz);
					    u_xlat10_3.z = dot(vs_TEXCOORD3.xyz, u_xlat10_2.xyz);
					    u_xlat16_1.x = dot(u_xlat10_3.xyz, u_xlat16_1.xyz);
					    u_xlat10_2.x = dot(u_xlat10_3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat10_2.x = max(u_xlat10_2.x, 0.0);
					    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
					    u_xlat16_0.x = log2(u_xlat16_1.x);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = u_xlat10_1 * vs_COLOR0;
					    u_xlat16_4 = u_xlat16_1.w * 128.0;
					    u_xlat10_8.xyz = u_xlat16_1.xyz * _Color.xyz;
					    u_xlat10_8.xyz = u_xlat10_8.xyz * _LightColor0.xyz;
					    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_4;
					    u_xlat16_0.x = exp2(u_xlat16_0.x);
					    u_xlat10_6 = texture(_SpecTex, vs_TEXCOORD0.xy).x;
					    u_xlat16_6 = u_xlat10_6 * vs_COLOR0.x;
					    u_xlat16_0.x = u_xlat16_6 * u_xlat16_0.x;
					    u_xlat10_3.xyz = _LightColor0.xyz * _SpecColor.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat10_3.xyz;
					    u_xlat16_0.xyz = u_xlat10_8.xyz * u_xlat10_2.xxx + u_xlat16_0.xyz;
					    u_xlat5.xy = vs_TEXCOORD4.yy * hlslcc_mtx4unity_WorldToLight[1].xy;
					    u_xlat5.xy = hlslcc_mtx4unity_WorldToLight[0].xy * vs_TEXCOORD4.xx + u_xlat5.xy;
					    u_xlat5.xy = hlslcc_mtx4unity_WorldToLight[2].xy * vs_TEXCOORD4.zz + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy + hlslcc_mtx4unity_WorldToLight[3].xy;
					    u_xlat10_18 = texture(_LightTexture0, u_xlat5.xy).w;
					    u_xlat10_2.x = u_xlat10_18 * 2.0;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_2.xxx;
					    SV_Target0.xyz = u_xlat16_0.xyz;
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
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out lowp vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out lowp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.z = u_xlat0.y;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat10_2.xyz);
					    u_xlat3 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat10_2.xyz = vec3(u_xlat3) * u_xlat10_2.xyz;
					    vs_TEXCOORD1.y = u_xlat10_2.x;
					    vs_TEXCOORD1.x = u_xlat1.z;
					    vs_TEXCOORD2.z = u_xlat0.z;
					    vs_TEXCOORD3.z = u_xlat0.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD2.y = u_xlat10_2.y;
					    vs_TEXCOORD3.y = u_xlat10_2.z;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD4.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp vec4 _SpecColor;
					uniform 	vec4 hlslcc_mtx4unity_WorldToLight[4];
					uniform 	lowp vec4 _Color;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _SpecTex;
					uniform lowp sampler2D _BumpMap;
					uniform lowp sampler2D _LightTexture0;
					in highp vec4 vs_TEXCOORD0;
					in lowp vec3 vs_TEXCOORD1;
					in lowp vec3 vs_TEXCOORD2;
					in lowp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					lowp vec3 u_xlat10_3;
					mediump float u_xlat16_4;
					vec2 u_xlat5;
					mediump float u_xlat16_6;
					lowp float u_xlat10_6;
					lowp vec3 u_xlat10_8;
					float u_xlat18;
					lowp float u_xlat10_18;
					mediump float u_xlat16_19;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
					    u_xlat16_19 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
					    u_xlat16_19 = inversesqrt(u_xlat16_19);
					    u_xlat16_1.xyz = vec3(u_xlat16_19) * u_xlat16_1.xyz;
					    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
					    u_xlat10_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat10_3.x = dot(vs_TEXCOORD1.xyz, u_xlat10_2.xyz);
					    u_xlat10_3.y = dot(vs_TEXCOORD2.xyz, u_xlat10_2.xyz);
					    u_xlat10_3.z = dot(vs_TEXCOORD3.xyz, u_xlat10_2.xyz);
					    u_xlat16_1.x = dot(u_xlat10_3.xyz, u_xlat16_1.xyz);
					    u_xlat10_2.x = dot(u_xlat10_3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat10_2.x = max(u_xlat10_2.x, 0.0);
					    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
					    u_xlat16_0.x = log2(u_xlat16_1.x);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = u_xlat10_1 * vs_COLOR0;
					    u_xlat16_4 = u_xlat16_1.w * 128.0;
					    u_xlat10_8.xyz = u_xlat16_1.xyz * _Color.xyz;
					    u_xlat10_8.xyz = u_xlat10_8.xyz * _LightColor0.xyz;
					    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_4;
					    u_xlat16_0.x = exp2(u_xlat16_0.x);
					    u_xlat10_6 = texture(_SpecTex, vs_TEXCOORD0.xy).x;
					    u_xlat16_6 = u_xlat10_6 * vs_COLOR0.x;
					    u_xlat16_0.x = u_xlat16_6 * u_xlat16_0.x;
					    u_xlat10_3.xyz = _LightColor0.xyz * _SpecColor.xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat10_3.xyz;
					    u_xlat16_0.xyz = u_xlat10_8.xyz * u_xlat10_2.xxx + u_xlat16_0.xyz;
					    u_xlat5.xy = vs_TEXCOORD4.yy * hlslcc_mtx4unity_WorldToLight[1].xy;
					    u_xlat5.xy = hlslcc_mtx4unity_WorldToLight[0].xy * vs_TEXCOORD4.xx + u_xlat5.xy;
					    u_xlat5.xy = hlslcc_mtx4unity_WorldToLight[2].xy * vs_TEXCOORD4.zz + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy + hlslcc_mtx4unity_WorldToLight[3].xy;
					    u_xlat10_18 = texture(_LightTexture0, u_xlat5.xy).w;
					    u_xlat10_2.x = u_xlat10_18 * 2.0;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_2.xxx;
					    SV_Target0.xyz = u_xlat16_0.xyz;
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
  GpuProgramID 162490
Program "vp" {
SubProgram "gles hw_tier01 " {

					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
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
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  lowp vec3 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_5);
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 res_1;
					  lowp vec3 worldN_2;
					  mediump float tmpvar_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  tmpvar_3 = tmpvar_4.w;
					  lowp vec3 tmpvar_5;
					  tmpvar_5 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
					  worldN_2.x = dot (xlv_TEXCOORD1, tmpvar_5);
					  worldN_2.y = dot (xlv_TEXCOORD2, tmpvar_5);
					  worldN_2.z = dot (xlv_TEXCOORD3, tmpvar_5);
					  res_1.xyz = ((worldN_2 * 0.5) + 0.5);
					  res_1.w = tmpvar_3;
					  gl_FragData[0] = res_1;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {

					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
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
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  lowp vec3 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_5);
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 res_1;
					  lowp vec3 worldN_2;
					  mediump float tmpvar_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  tmpvar_3 = tmpvar_4.w;
					  lowp vec3 tmpvar_5;
					  tmpvar_5 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
					  worldN_2.x = dot (xlv_TEXCOORD1, tmpvar_5);
					  worldN_2.y = dot (xlv_TEXCOORD2, tmpvar_5);
					  worldN_2.z = dot (xlv_TEXCOORD3, tmpvar_5);
					  res_1.xyz = ((worldN_2 * 0.5) + 0.5);
					  res_1.w = tmpvar_3;
					  gl_FragData[0] = res_1;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {

					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
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
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  lowp vec3 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_5);
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 res_1;
					  lowp vec3 worldN_2;
					  mediump float tmpvar_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  tmpvar_3 = tmpvar_4.w;
					  lowp vec3 tmpvar_5;
					  tmpvar_5 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
					  worldN_2.x = dot (xlv_TEXCOORD1, tmpvar_5);
					  worldN_2.y = dot (xlv_TEXCOORD2, tmpvar_5);
					  worldN_2.z = dot (xlv_TEXCOORD3, tmpvar_5);
					  res_1.xyz = ((worldN_2 * 0.5) + 0.5);
					  res_1.w = tmpvar_3;
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
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out lowp vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out lowp vec3 vs_TEXCOORD3;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.z = u_xlat0.y;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat10_2.xyz);
					    u_xlat3 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat10_2.xyz = vec3(u_xlat3) * u_xlat10_2.xyz;
					    vs_TEXCOORD1.y = u_xlat10_2.x;
					    vs_TEXCOORD1.x = u_xlat1.z;
					    vs_TEXCOORD2.z = u_xlat0.z;
					    vs_TEXCOORD3.z = u_xlat0.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD2.y = u_xlat10_2.y;
					    vs_TEXCOORD3.y = u_xlat10_2.z;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BumpMap;
					in highp vec4 vs_TEXCOORD0;
					in lowp vec3 vs_TEXCOORD1;
					in lowp vec3 vs_TEXCOORD2;
					in lowp vec3 vs_TEXCOORD3;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					mediump float u_xlat16_0;
					lowp vec3 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					void main()
					{
					    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
					    u_xlat10_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat10_2.x = dot(vs_TEXCOORD1.xyz, u_xlat10_1.xyz);
					    u_xlat10_2.y = dot(vs_TEXCOORD2.xyz, u_xlat10_1.xyz);
					    u_xlat10_2.z = dot(vs_TEXCOORD3.xyz, u_xlat10_1.xyz);
					    SV_Target0.xyz = u_xlat10_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_0 = u_xlat10_0.x * vs_COLOR0.w;
					    SV_Target0.w = u_xlat16_0;
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
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out lowp vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out lowp vec3 vs_TEXCOORD3;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.z = u_xlat0.y;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat10_2.xyz);
					    u_xlat3 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat10_2.xyz = vec3(u_xlat3) * u_xlat10_2.xyz;
					    vs_TEXCOORD1.y = u_xlat10_2.x;
					    vs_TEXCOORD1.x = u_xlat1.z;
					    vs_TEXCOORD2.z = u_xlat0.z;
					    vs_TEXCOORD3.z = u_xlat0.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD2.y = u_xlat10_2.y;
					    vs_TEXCOORD3.y = u_xlat10_2.z;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BumpMap;
					in highp vec4 vs_TEXCOORD0;
					in lowp vec3 vs_TEXCOORD1;
					in lowp vec3 vs_TEXCOORD2;
					in lowp vec3 vs_TEXCOORD3;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					mediump float u_xlat16_0;
					lowp vec3 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					void main()
					{
					    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
					    u_xlat10_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat10_2.x = dot(vs_TEXCOORD1.xyz, u_xlat10_1.xyz);
					    u_xlat10_2.y = dot(vs_TEXCOORD2.xyz, u_xlat10_1.xyz);
					    u_xlat10_2.z = dot(vs_TEXCOORD3.xyz, u_xlat10_1.xyz);
					    SV_Target0.xyz = u_xlat10_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_0 = u_xlat10_0.x * vs_COLOR0.w;
					    SV_Target0.w = u_xlat16_0;
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
					uniform 	vec4 unity_WorldTransformParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out lowp vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out lowp vec3 vs_TEXCOORD3;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.z = u_xlat0.y;
					    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat10_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat10_2.xyz);
					    u_xlat3 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat10_2.xyz = vec3(u_xlat3) * u_xlat10_2.xyz;
					    vs_TEXCOORD1.y = u_xlat10_2.x;
					    vs_TEXCOORD1.x = u_xlat1.z;
					    vs_TEXCOORD2.z = u_xlat0.z;
					    vs_TEXCOORD3.z = u_xlat0.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD2.y = u_xlat10_2.y;
					    vs_TEXCOORD3.y = u_xlat10_2.z;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BumpMap;
					in highp vec4 vs_TEXCOORD0;
					in lowp vec3 vs_TEXCOORD1;
					in lowp vec3 vs_TEXCOORD2;
					in lowp vec3 vs_TEXCOORD3;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					mediump float u_xlat16_0;
					lowp vec3 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					void main()
					{
					    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
					    u_xlat10_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat10_2.x = dot(vs_TEXCOORD1.xyz, u_xlat10_1.xyz);
					    u_xlat10_2.y = dot(vs_TEXCOORD2.xyz, u_xlat10_1.xyz);
					    u_xlat10_2.z = dot(vs_TEXCOORD3.xyz, u_xlat10_1.xyz);
					    SV_Target0.xyz = u_xlat10_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_0 = u_xlat10_0.x * vs_COLOR0.w;
					    SV_Target0.w = u_xlat16_0;
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
  GpuProgramID 262138
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
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  highp vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  highp vec4 o_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7 = (tmpvar_4 * 0.5);
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = tmpvar_7.x;
					  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
					  o_6.xy = (tmpvar_8 + tmpvar_7.w);
					  o_6.zw = tmpvar_4.zw;
					  tmpvar_2.zw = vec2(0.0, 0.0);
					  tmpvar_2.xy = vec2(0.0, 0.0);
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].x;
					  v_9.y = unity_WorldToObject[1].x;
					  v_9.z = unity_WorldToObject[2].x;
					  v_9.w = unity_WorldToObject[3].x;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].y;
					  v_10.y = unity_WorldToObject[1].y;
					  v_10.z = unity_WorldToObject[2].y;
					  v_10.w = unity_WorldToObject[3].y;
					  highp vec4 v_11;
					  v_11.x = unity_WorldToObject[0].z;
					  v_11.y = unity_WorldToObject[1].z;
					  v_11.z = unity_WorldToObject[2].z;
					  v_11.w = unity_WorldToObject[3].z;
					  highp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = normalize(((
					    (v_9.xyz * _glesNormal.x)
					   + 
					    (v_10.xyz * _glesNormal.y)
					  ) + (v_11.xyz * _glesNormal.z)));
					  mediump vec4 normal_13;
					  normal_13 = tmpvar_12;
					  mediump vec3 res_14;
					  mediump vec3 x_15;
					  x_15.x = dot (unity_SHAr, normal_13);
					  x_15.y = dot (unity_SHAg, normal_13);
					  x_15.z = dot (unity_SHAb, normal_13);
					  mediump vec3 x1_16;
					  mediump vec4 tmpvar_17;
					  tmpvar_17 = (normal_13.xyzz * normal_13.yzzx);
					  x1_16.x = dot (unity_SHBr, tmpvar_17);
					  x1_16.y = dot (unity_SHBg, tmpvar_17);
					  x1_16.z = dot (unity_SHBb, tmpvar_17);
					  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
					    ((normal_13.x * normal_13.x) - (normal_13.y * normal_13.y))
					  )));
					  res_14 = max (((1.055 * 
					    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_3 = res_14;
					  gl_Position = tmpvar_4;
					  xlv_TEXCOORD0 = tmpvar_1;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD2 = o_6;
					  xlv_TEXCOORD3 = tmpvar_2;
					  xlv_TEXCOORD4 = tmpvar_3;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _MainTex;
					uniform sampler2D _SpecTex;
					uniform lowp vec4 _Color;
					uniform sampler2D _LightBuffer;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = (texture2D (_SpecTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_3 = tmpvar_6;
					  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
					  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
					  lowp vec4 c_7;
					  lowp float spec_8;
					  mediump float tmpvar_9;
					  tmpvar_9 = (light_3.w * tmpvar_5.x);
					  spec_8 = tmpvar_9;
					  c_7.xyz = (((tmpvar_4.xyz * _Color.xyz) * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_8));
					  c_7.w = ((tmpvar_4.w * _Color.w) + (spec_8 * _SpecColor.w));
					  c_2.xyz = c_7.xyz;
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
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  highp vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  highp vec4 o_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7 = (tmpvar_4 * 0.5);
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = tmpvar_7.x;
					  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
					  o_6.xy = (tmpvar_8 + tmpvar_7.w);
					  o_6.zw = tmpvar_4.zw;
					  tmpvar_2.zw = vec2(0.0, 0.0);
					  tmpvar_2.xy = vec2(0.0, 0.0);
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].x;
					  v_9.y = unity_WorldToObject[1].x;
					  v_9.z = unity_WorldToObject[2].x;
					  v_9.w = unity_WorldToObject[3].x;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].y;
					  v_10.y = unity_WorldToObject[1].y;
					  v_10.z = unity_WorldToObject[2].y;
					  v_10.w = unity_WorldToObject[3].y;
					  highp vec4 v_11;
					  v_11.x = unity_WorldToObject[0].z;
					  v_11.y = unity_WorldToObject[1].z;
					  v_11.z = unity_WorldToObject[2].z;
					  v_11.w = unity_WorldToObject[3].z;
					  highp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = normalize(((
					    (v_9.xyz * _glesNormal.x)
					   + 
					    (v_10.xyz * _glesNormal.y)
					  ) + (v_11.xyz * _glesNormal.z)));
					  mediump vec4 normal_13;
					  normal_13 = tmpvar_12;
					  mediump vec3 res_14;
					  mediump vec3 x_15;
					  x_15.x = dot (unity_SHAr, normal_13);
					  x_15.y = dot (unity_SHAg, normal_13);
					  x_15.z = dot (unity_SHAb, normal_13);
					  mediump vec3 x1_16;
					  mediump vec4 tmpvar_17;
					  tmpvar_17 = (normal_13.xyzz * normal_13.yzzx);
					  x1_16.x = dot (unity_SHBr, tmpvar_17);
					  x1_16.y = dot (unity_SHBg, tmpvar_17);
					  x1_16.z = dot (unity_SHBb, tmpvar_17);
					  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
					    ((normal_13.x * normal_13.x) - (normal_13.y * normal_13.y))
					  )));
					  res_14 = max (((1.055 * 
					    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_3 = res_14;
					  gl_Position = tmpvar_4;
					  xlv_TEXCOORD0 = tmpvar_1;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD2 = o_6;
					  xlv_TEXCOORD3 = tmpvar_2;
					  xlv_TEXCOORD4 = tmpvar_3;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _MainTex;
					uniform sampler2D _SpecTex;
					uniform lowp vec4 _Color;
					uniform sampler2D _LightBuffer;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = (texture2D (_SpecTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_3 = tmpvar_6;
					  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
					  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
					  lowp vec4 c_7;
					  lowp float spec_8;
					  mediump float tmpvar_9;
					  tmpvar_9 = (light_3.w * tmpvar_5.x);
					  spec_8 = tmpvar_9;
					  c_7.xyz = (((tmpvar_4.xyz * _Color.xyz) * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_8));
					  c_7.w = ((tmpvar_4.w * _Color.w) + (spec_8 * _SpecColor.w));
					  c_2.xyz = c_7.xyz;
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
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  highp vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  highp vec4 o_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7 = (tmpvar_4 * 0.5);
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = tmpvar_7.x;
					  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
					  o_6.xy = (tmpvar_8 + tmpvar_7.w);
					  o_6.zw = tmpvar_4.zw;
					  tmpvar_2.zw = vec2(0.0, 0.0);
					  tmpvar_2.xy = vec2(0.0, 0.0);
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].x;
					  v_9.y = unity_WorldToObject[1].x;
					  v_9.z = unity_WorldToObject[2].x;
					  v_9.w = unity_WorldToObject[3].x;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].y;
					  v_10.y = unity_WorldToObject[1].y;
					  v_10.z = unity_WorldToObject[2].y;
					  v_10.w = unity_WorldToObject[3].y;
					  highp vec4 v_11;
					  v_11.x = unity_WorldToObject[0].z;
					  v_11.y = unity_WorldToObject[1].z;
					  v_11.z = unity_WorldToObject[2].z;
					  v_11.w = unity_WorldToObject[3].z;
					  highp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = normalize(((
					    (v_9.xyz * _glesNormal.x)
					   + 
					    (v_10.xyz * _glesNormal.y)
					  ) + (v_11.xyz * _glesNormal.z)));
					  mediump vec4 normal_13;
					  normal_13 = tmpvar_12;
					  mediump vec3 res_14;
					  mediump vec3 x_15;
					  x_15.x = dot (unity_SHAr, normal_13);
					  x_15.y = dot (unity_SHAg, normal_13);
					  x_15.z = dot (unity_SHAb, normal_13);
					  mediump vec3 x1_16;
					  mediump vec4 tmpvar_17;
					  tmpvar_17 = (normal_13.xyzz * normal_13.yzzx);
					  x1_16.x = dot (unity_SHBr, tmpvar_17);
					  x1_16.y = dot (unity_SHBg, tmpvar_17);
					  x1_16.z = dot (unity_SHBb, tmpvar_17);
					  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
					    ((normal_13.x * normal_13.x) - (normal_13.y * normal_13.y))
					  )));
					  res_14 = max (((1.055 * 
					    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_3 = res_14;
					  gl_Position = tmpvar_4;
					  xlv_TEXCOORD0 = tmpvar_1;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD2 = o_6;
					  xlv_TEXCOORD3 = tmpvar_2;
					  xlv_TEXCOORD4 = tmpvar_3;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _MainTex;
					uniform sampler2D _SpecTex;
					uniform lowp vec4 _Color;
					uniform sampler2D _LightBuffer;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = (texture2D (_SpecTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_3 = tmpvar_6;
					  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
					  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
					  lowp vec4 c_7;
					  lowp float spec_8;
					  mediump float tmpvar_9;
					  tmpvar_9 = (light_3.w * tmpvar_5.x);
					  spec_8 = tmpvar_9;
					  c_7.xyz = (((tmpvar_4.xyz * _Color.xyz) * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_8));
					  c_7.w = ((tmpvar_4.w * _Color.w) + (spec_8 * _SpecColor.w));
					  c_2.xyz = c_7.xyz;
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
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
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
					uniform 	lowp vec4 _SpecColor;
					uniform 	lowp vec4 _Color;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _SpecTex;
					uniform lowp sampler2D _LightBuffer;
					in highp vec4 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					in highp vec4 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump float u_xlat16_0;
					lowp float u_xlat10_0;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_3;
					lowp vec3 u_xlat10_4;
					vec2 u_xlat5;
					mediump vec3 u_xlat16_7;
					void main()
					{
					    u_xlat10_0 = texture(_SpecTex, vs_TEXCOORD0.xy).x;
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0.x;
					    u_xlat5.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat10_1 = texture(_LightBuffer, u_xlat5.xy);
					    u_xlat16_1 = max(u_xlat10_1, vec4(0.00100000005, 0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat16_1 = log2(u_xlat16_1);
					    u_xlat16_2.x = u_xlat16_0 * (-u_xlat16_1.w);
					    u_xlat0.xyz = (-u_xlat16_1.xyz) + vs_TEXCOORD4.xyz;
					    u_xlat16_7.xyz = u_xlat0.xyz * _SpecColor.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
					    u_xlat10_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_3.xyz * vs_COLOR0.xyz;
					    u_xlat10_4.xyz = u_xlat16_3.xyz * _Color.xyz;
					    u_xlat16_2.xyz = u_xlat10_4.xyz * u_xlat0.xyz + u_xlat16_2.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz;
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
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
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
					uniform 	lowp vec4 _SpecColor;
					uniform 	lowp vec4 _Color;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _SpecTex;
					uniform lowp sampler2D _LightBuffer;
					in highp vec4 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					in highp vec4 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump float u_xlat16_0;
					lowp float u_xlat10_0;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_3;
					lowp vec3 u_xlat10_4;
					vec2 u_xlat5;
					mediump vec3 u_xlat16_7;
					void main()
					{
					    u_xlat10_0 = texture(_SpecTex, vs_TEXCOORD0.xy).x;
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0.x;
					    u_xlat5.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat10_1 = texture(_LightBuffer, u_xlat5.xy);
					    u_xlat16_1 = max(u_xlat10_1, vec4(0.00100000005, 0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat16_1 = log2(u_xlat16_1);
					    u_xlat16_2.x = u_xlat16_0 * (-u_xlat16_1.w);
					    u_xlat0.xyz = (-u_xlat16_1.xyz) + vs_TEXCOORD4.xyz;
					    u_xlat16_7.xyz = u_xlat0.xyz * _SpecColor.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
					    u_xlat10_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_3.xyz * vs_COLOR0.xyz;
					    u_xlat10_4.xyz = u_xlat16_3.xyz * _Color.xyz;
					    u_xlat16_2.xyz = u_xlat10_4.xyz * u_xlat0.xyz + u_xlat16_2.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz;
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
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
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
					uniform 	lowp vec4 _SpecColor;
					uniform 	lowp vec4 _Color;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _SpecTex;
					uniform lowp sampler2D _LightBuffer;
					in highp vec4 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					in highp vec4 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump float u_xlat16_0;
					lowp float u_xlat10_0;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_3;
					lowp vec3 u_xlat10_4;
					vec2 u_xlat5;
					mediump vec3 u_xlat16_7;
					void main()
					{
					    u_xlat10_0 = texture(_SpecTex, vs_TEXCOORD0.xy).x;
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0.x;
					    u_xlat5.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat10_1 = texture(_LightBuffer, u_xlat5.xy);
					    u_xlat16_1 = max(u_xlat10_1, vec4(0.00100000005, 0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat16_1 = log2(u_xlat16_1);
					    u_xlat16_2.x = u_xlat16_0 * (-u_xlat16_1.w);
					    u_xlat0.xyz = (-u_xlat16_1.xyz) + vs_TEXCOORD4.xyz;
					    u_xlat16_7.xyz = u_xlat0.xyz * _SpecColor.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
					    u_xlat10_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_3.xyz * vs_COLOR0.xyz;
					    u_xlat10_4.xyz = u_xlat16_3.xyz * _Color.xyz;
					    u_xlat16_2.xyz = u_xlat10_4.xyz * u_xlat0.xyz + u_xlat16_2.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz;
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
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  highp vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  highp vec4 o_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7 = (tmpvar_4 * 0.5);
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = tmpvar_7.x;
					  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
					  o_6.xy = (tmpvar_8 + tmpvar_7.w);
					  o_6.zw = tmpvar_4.zw;
					  tmpvar_2.zw = vec2(0.0, 0.0);
					  tmpvar_2.xy = vec2(0.0, 0.0);
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].x;
					  v_9.y = unity_WorldToObject[1].x;
					  v_9.z = unity_WorldToObject[2].x;
					  v_9.w = unity_WorldToObject[3].x;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].y;
					  v_10.y = unity_WorldToObject[1].y;
					  v_10.z = unity_WorldToObject[2].y;
					  v_10.w = unity_WorldToObject[3].y;
					  highp vec4 v_11;
					  v_11.x = unity_WorldToObject[0].z;
					  v_11.y = unity_WorldToObject[1].z;
					  v_11.z = unity_WorldToObject[2].z;
					  v_11.w = unity_WorldToObject[3].z;
					  highp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = normalize(((
					    (v_9.xyz * _glesNormal.x)
					   + 
					    (v_10.xyz * _glesNormal.y)
					  ) + (v_11.xyz * _glesNormal.z)));
					  mediump vec4 normal_13;
					  normal_13 = tmpvar_12;
					  mediump vec3 res_14;
					  mediump vec3 x_15;
					  x_15.x = dot (unity_SHAr, normal_13);
					  x_15.y = dot (unity_SHAg, normal_13);
					  x_15.z = dot (unity_SHAb, normal_13);
					  mediump vec3 x1_16;
					  mediump vec4 tmpvar_17;
					  tmpvar_17 = (normal_13.xyzz * normal_13.yzzx);
					  x1_16.x = dot (unity_SHBr, tmpvar_17);
					  x1_16.y = dot (unity_SHBg, tmpvar_17);
					  x1_16.z = dot (unity_SHBb, tmpvar_17);
					  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
					    ((normal_13.x * normal_13.x) - (normal_13.y * normal_13.y))
					  )));
					  res_14 = max (((1.055 * 
					    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_3 = res_14;
					  gl_Position = tmpvar_4;
					  xlv_TEXCOORD0 = tmpvar_1;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD2 = o_6;
					  xlv_TEXCOORD3 = tmpvar_2;
					  xlv_TEXCOORD4 = tmpvar_3;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _MainTex;
					uniform sampler2D _SpecTex;
					uniform lowp vec4 _Color;
					uniform sampler2D _LightBuffer;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = (texture2D (_SpecTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_3 = tmpvar_6;
					  mediump vec4 tmpvar_7;
					  tmpvar_7 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
					  light_3.w = tmpvar_7.w;
					  light_3.xyz = (tmpvar_7.xyz + xlv_TEXCOORD4);
					  lowp vec4 c_8;
					  lowp float spec_9;
					  mediump float tmpvar_10;
					  tmpvar_10 = (tmpvar_7.w * tmpvar_5.x);
					  spec_9 = tmpvar_10;
					  c_8.xyz = (((tmpvar_4.xyz * _Color.xyz) * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_9));
					  c_8.w = ((tmpvar_4.w * _Color.w) + (spec_9 * _SpecColor.w));
					  c_2.xyz = c_8.xyz;
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
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  highp vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  highp vec4 o_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7 = (tmpvar_4 * 0.5);
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = tmpvar_7.x;
					  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
					  o_6.xy = (tmpvar_8 + tmpvar_7.w);
					  o_6.zw = tmpvar_4.zw;
					  tmpvar_2.zw = vec2(0.0, 0.0);
					  tmpvar_2.xy = vec2(0.0, 0.0);
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].x;
					  v_9.y = unity_WorldToObject[1].x;
					  v_9.z = unity_WorldToObject[2].x;
					  v_9.w = unity_WorldToObject[3].x;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].y;
					  v_10.y = unity_WorldToObject[1].y;
					  v_10.z = unity_WorldToObject[2].y;
					  v_10.w = unity_WorldToObject[3].y;
					  highp vec4 v_11;
					  v_11.x = unity_WorldToObject[0].z;
					  v_11.y = unity_WorldToObject[1].z;
					  v_11.z = unity_WorldToObject[2].z;
					  v_11.w = unity_WorldToObject[3].z;
					  highp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = normalize(((
					    (v_9.xyz * _glesNormal.x)
					   + 
					    (v_10.xyz * _glesNormal.y)
					  ) + (v_11.xyz * _glesNormal.z)));
					  mediump vec4 normal_13;
					  normal_13 = tmpvar_12;
					  mediump vec3 res_14;
					  mediump vec3 x_15;
					  x_15.x = dot (unity_SHAr, normal_13);
					  x_15.y = dot (unity_SHAg, normal_13);
					  x_15.z = dot (unity_SHAb, normal_13);
					  mediump vec3 x1_16;
					  mediump vec4 tmpvar_17;
					  tmpvar_17 = (normal_13.xyzz * normal_13.yzzx);
					  x1_16.x = dot (unity_SHBr, tmpvar_17);
					  x1_16.y = dot (unity_SHBg, tmpvar_17);
					  x1_16.z = dot (unity_SHBb, tmpvar_17);
					  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
					    ((normal_13.x * normal_13.x) - (normal_13.y * normal_13.y))
					  )));
					  res_14 = max (((1.055 * 
					    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_3 = res_14;
					  gl_Position = tmpvar_4;
					  xlv_TEXCOORD0 = tmpvar_1;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD2 = o_6;
					  xlv_TEXCOORD3 = tmpvar_2;
					  xlv_TEXCOORD4 = tmpvar_3;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _MainTex;
					uniform sampler2D _SpecTex;
					uniform lowp vec4 _Color;
					uniform sampler2D _LightBuffer;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = (texture2D (_SpecTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_3 = tmpvar_6;
					  mediump vec4 tmpvar_7;
					  tmpvar_7 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
					  light_3.w = tmpvar_7.w;
					  light_3.xyz = (tmpvar_7.xyz + xlv_TEXCOORD4);
					  lowp vec4 c_8;
					  lowp float spec_9;
					  mediump float tmpvar_10;
					  tmpvar_10 = (tmpvar_7.w * tmpvar_5.x);
					  spec_9 = tmpvar_10;
					  c_8.xyz = (((tmpvar_4.xyz * _Color.xyz) * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_9));
					  c_8.w = ((tmpvar_4.w * _Color.w) + (spec_9 * _SpecColor.w));
					  c_2.xyz = c_8.xyz;
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
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  highp vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  highp vec4 o_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7 = (tmpvar_4 * 0.5);
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = tmpvar_7.x;
					  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
					  o_6.xy = (tmpvar_8 + tmpvar_7.w);
					  o_6.zw = tmpvar_4.zw;
					  tmpvar_2.zw = vec2(0.0, 0.0);
					  tmpvar_2.xy = vec2(0.0, 0.0);
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].x;
					  v_9.y = unity_WorldToObject[1].x;
					  v_9.z = unity_WorldToObject[2].x;
					  v_9.w = unity_WorldToObject[3].x;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].y;
					  v_10.y = unity_WorldToObject[1].y;
					  v_10.z = unity_WorldToObject[2].y;
					  v_10.w = unity_WorldToObject[3].y;
					  highp vec4 v_11;
					  v_11.x = unity_WorldToObject[0].z;
					  v_11.y = unity_WorldToObject[1].z;
					  v_11.z = unity_WorldToObject[2].z;
					  v_11.w = unity_WorldToObject[3].z;
					  highp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = normalize(((
					    (v_9.xyz * _glesNormal.x)
					   + 
					    (v_10.xyz * _glesNormal.y)
					  ) + (v_11.xyz * _glesNormal.z)));
					  mediump vec4 normal_13;
					  normal_13 = tmpvar_12;
					  mediump vec3 res_14;
					  mediump vec3 x_15;
					  x_15.x = dot (unity_SHAr, normal_13);
					  x_15.y = dot (unity_SHAg, normal_13);
					  x_15.z = dot (unity_SHAb, normal_13);
					  mediump vec3 x1_16;
					  mediump vec4 tmpvar_17;
					  tmpvar_17 = (normal_13.xyzz * normal_13.yzzx);
					  x1_16.x = dot (unity_SHBr, tmpvar_17);
					  x1_16.y = dot (unity_SHBg, tmpvar_17);
					  x1_16.z = dot (unity_SHBb, tmpvar_17);
					  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
					    ((normal_13.x * normal_13.x) - (normal_13.y * normal_13.y))
					  )));
					  res_14 = max (((1.055 * 
					    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_3 = res_14;
					  gl_Position = tmpvar_4;
					  xlv_TEXCOORD0 = tmpvar_1;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD2 = o_6;
					  xlv_TEXCOORD3 = tmpvar_2;
					  xlv_TEXCOORD4 = tmpvar_3;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _MainTex;
					uniform sampler2D _SpecTex;
					uniform lowp vec4 _Color;
					uniform sampler2D _LightBuffer;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = (texture2D (_SpecTex, xlv_TEXCOORD0.xy) * xlv_COLOR0);
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_3 = tmpvar_6;
					  mediump vec4 tmpvar_7;
					  tmpvar_7 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
					  light_3.w = tmpvar_7.w;
					  light_3.xyz = (tmpvar_7.xyz + xlv_TEXCOORD4);
					  lowp vec4 c_8;
					  lowp float spec_9;
					  mediump float tmpvar_10;
					  tmpvar_10 = (tmpvar_7.w * tmpvar_5.x);
					  spec_9 = tmpvar_10;
					  c_8.xyz = (((tmpvar_4.xyz * _Color.xyz) * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_9));
					  c_8.w = ((tmpvar_4.w * _Color.w) + (spec_9 * _SpecColor.w));
					  c_2.xyz = c_8.xyz;
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
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
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
					uniform 	lowp vec4 _SpecColor;
					uniform 	lowp vec4 _Color;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _SpecTex;
					uniform lowp sampler2D _LightBuffer;
					in highp vec4 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					in highp vec4 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump float u_xlat16_0;
					lowp float u_xlat10_0;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_3;
					lowp vec3 u_xlat10_4;
					vec2 u_xlat5;
					mediump vec3 u_xlat16_7;
					void main()
					{
					    u_xlat10_0 = texture(_SpecTex, vs_TEXCOORD0.xy).x;
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0.x;
					    u_xlat5.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat10_1 = texture(_LightBuffer, u_xlat5.xy);
					    u_xlat16_1 = max(u_xlat10_1, vec4(0.00100000005, 0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat16_2.x = u_xlat16_0 * u_xlat16_1.w;
					    u_xlat0.xyz = u_xlat16_1.xyz + vs_TEXCOORD4.xyz;
					    u_xlat16_7.xyz = u_xlat0.xyz * _SpecColor.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
					    u_xlat10_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_3.xyz * vs_COLOR0.xyz;
					    u_xlat10_4.xyz = u_xlat16_3.xyz * _Color.xyz;
					    u_xlat16_2.xyz = u_xlat10_4.xyz * u_xlat0.xyz + u_xlat16_2.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz;
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
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
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
					uniform 	lowp vec4 _SpecColor;
					uniform 	lowp vec4 _Color;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _SpecTex;
					uniform lowp sampler2D _LightBuffer;
					in highp vec4 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					in highp vec4 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump float u_xlat16_0;
					lowp float u_xlat10_0;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_3;
					lowp vec3 u_xlat10_4;
					vec2 u_xlat5;
					mediump vec3 u_xlat16_7;
					void main()
					{
					    u_xlat10_0 = texture(_SpecTex, vs_TEXCOORD0.xy).x;
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0.x;
					    u_xlat5.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat10_1 = texture(_LightBuffer, u_xlat5.xy);
					    u_xlat16_1 = max(u_xlat10_1, vec4(0.00100000005, 0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat16_2.x = u_xlat16_0 * u_xlat16_1.w;
					    u_xlat0.xyz = u_xlat16_1.xyz + vs_TEXCOORD4.xyz;
					    u_xlat16_7.xyz = u_xlat0.xyz * _SpecColor.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
					    u_xlat10_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_3.xyz * vs_COLOR0.xyz;
					    u_xlat10_4.xyz = u_xlat16_3.xyz * _Color.xyz;
					    u_xlat16_2.xyz = u_xlat10_4.xyz * u_xlat0.xyz + u_xlat16_2.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz;
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
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
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
					uniform 	lowp vec4 _SpecColor;
					uniform 	lowp vec4 _Color;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _SpecTex;
					uniform lowp sampler2D _LightBuffer;
					in highp vec4 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					in highp vec4 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump float u_xlat16_0;
					lowp float u_xlat10_0;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_3;
					lowp vec3 u_xlat10_4;
					vec2 u_xlat5;
					mediump vec3 u_xlat16_7;
					void main()
					{
					    u_xlat10_0 = texture(_SpecTex, vs_TEXCOORD0.xy).x;
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0.x;
					    u_xlat5.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat10_1 = texture(_LightBuffer, u_xlat5.xy);
					    u_xlat16_1 = max(u_xlat10_1, vec4(0.00100000005, 0.00100000005, 0.00100000005, 0.00100000005));
					    u_xlat16_2.x = u_xlat16_0 * u_xlat16_1.w;
					    u_xlat0.xyz = u_xlat16_1.xyz + vs_TEXCOORD4.xyz;
					    u_xlat16_7.xyz = u_xlat0.xyz * _SpecColor.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
					    u_xlat10_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_3.xyz * vs_COLOR0.xyz;
					    u_xlat10_4.xyz = u_xlat16_3.xyz * _Color.xyz;
					    u_xlat16_2.xyz = u_xlat10_4.xyz * u_xlat0.xyz + u_xlat16_2.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz;
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
  Name "SHADOWCASTER"
  Tags { "LIGHTMODE"="SHADOWCASTER" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  GpuProgramID 325001
Program "vp" {
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform highp vec4 unity_LightShadowBias;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					void main ()
					{
					  highp vec3 vertex_1;
					  vertex_1 = _glesVertex.xyz;
					  highp vec4 clipPos_2;
					  if ((unity_LightShadowBias.z != 0.0)) {
					    highp vec4 tmpvar_3;
					    tmpvar_3.w = 1.0;
					    tmpvar_3.xyz = vertex_1;
					    highp vec3 tmpvar_4;
					    tmpvar_4 = (unity_ObjectToWorld * tmpvar_3).xyz;
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
					    highp float tmpvar_9;
					    tmpvar_9 = dot (tmpvar_8, normalize((_WorldSpaceLightPos0.xyz - 
					      (tmpvar_4 * _WorldSpaceLightPos0.w)
					    )));
					    highp vec4 tmpvar_10;
					    tmpvar_10.w = 1.0;
					    tmpvar_10.xyz = (tmpvar_4 - (tmpvar_8 * (unity_LightShadowBias.z * 
					      sqrt((1.0 - (tmpvar_9 * tmpvar_9)))
					    )));
					    clipPos_2 = (unity_MatrixVP * tmpvar_10);
					  } else {
					    highp vec4 tmpvar_11;
					    tmpvar_11.w = 1.0;
					    tmpvar_11.xyz = vertex_1;
					    clipPos_2 = (glstate_matrix_mvp * tmpvar_11);
					  };
					  highp vec4 clipPos_12;
					  clipPos_12.xyw = clipPos_2.xyw;
					  clipPos_12.z = (clipPos_2.z + clamp ((unity_LightShadowBias.x / clipPos_2.w), 0.0, 1.0));
					  clipPos_12.z = mix (clipPos_12.z, max (clipPos_12.z, -(clipPos_2.w)), unity_LightShadowBias.y);
					  gl_Position = clipPos_12;
					}
					
					
					#endif
					#ifdef FRAGMENT
					void main ()
					{
					  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform highp vec4 unity_LightShadowBias;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					void main ()
					{
					  highp vec3 vertex_1;
					  vertex_1 = _glesVertex.xyz;
					  highp vec4 clipPos_2;
					  if ((unity_LightShadowBias.z != 0.0)) {
					    highp vec4 tmpvar_3;
					    tmpvar_3.w = 1.0;
					    tmpvar_3.xyz = vertex_1;
					    highp vec3 tmpvar_4;
					    tmpvar_4 = (unity_ObjectToWorld * tmpvar_3).xyz;
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
					    highp float tmpvar_9;
					    tmpvar_9 = dot (tmpvar_8, normalize((_WorldSpaceLightPos0.xyz - 
					      (tmpvar_4 * _WorldSpaceLightPos0.w)
					    )));
					    highp vec4 tmpvar_10;
					    tmpvar_10.w = 1.0;
					    tmpvar_10.xyz = (tmpvar_4 - (tmpvar_8 * (unity_LightShadowBias.z * 
					      sqrt((1.0 - (tmpvar_9 * tmpvar_9)))
					    )));
					    clipPos_2 = (unity_MatrixVP * tmpvar_10);
					  } else {
					    highp vec4 tmpvar_11;
					    tmpvar_11.w = 1.0;
					    tmpvar_11.xyz = vertex_1;
					    clipPos_2 = (glstate_matrix_mvp * tmpvar_11);
					  };
					  highp vec4 clipPos_12;
					  clipPos_12.xyw = clipPos_2.xyw;
					  clipPos_12.z = (clipPos_2.z + clamp ((unity_LightShadowBias.x / clipPos_2.w), 0.0, 1.0));
					  clipPos_12.z = mix (clipPos_12.z, max (clipPos_12.z, -(clipPos_2.w)), unity_LightShadowBias.y);
					  gl_Position = clipPos_12;
					}
					
					
					#endif
					#ifdef FRAGMENT
					void main ()
					{
					  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_DEPTH" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform highp vec4 unity_LightShadowBias;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					void main ()
					{
					  highp vec3 vertex_1;
					  vertex_1 = _glesVertex.xyz;
					  highp vec4 clipPos_2;
					  if ((unity_LightShadowBias.z != 0.0)) {
					    highp vec4 tmpvar_3;
					    tmpvar_3.w = 1.0;
					    tmpvar_3.xyz = vertex_1;
					    highp vec3 tmpvar_4;
					    tmpvar_4 = (unity_ObjectToWorld * tmpvar_3).xyz;
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
					    highp float tmpvar_9;
					    tmpvar_9 = dot (tmpvar_8, normalize((_WorldSpaceLightPos0.xyz - 
					      (tmpvar_4 * _WorldSpaceLightPos0.w)
					    )));
					    highp vec4 tmpvar_10;
					    tmpvar_10.w = 1.0;
					    tmpvar_10.xyz = (tmpvar_4 - (tmpvar_8 * (unity_LightShadowBias.z * 
					      sqrt((1.0 - (tmpvar_9 * tmpvar_9)))
					    )));
					    clipPos_2 = (unity_MatrixVP * tmpvar_10);
					  } else {
					    highp vec4 tmpvar_11;
					    tmpvar_11.w = 1.0;
					    tmpvar_11.xyz = vertex_1;
					    clipPos_2 = (glstate_matrix_mvp * tmpvar_11);
					  };
					  highp vec4 clipPos_12;
					  clipPos_12.xyw = clipPos_2.xyw;
					  clipPos_12.z = (clipPos_2.z + clamp ((unity_LightShadowBias.x / clipPos_2.w), 0.0, 1.0));
					  clipPos_12.z = mix (clipPos_12.z, max (clipPos_12.z, -(clipPos_2.w)), unity_LightShadowBias.y);
					  gl_Position = clipPos_12;
					}
					
					
					#endif
					#ifdef FRAGMENT
					void main ()
					{
					  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
					}
					
					
					#endif
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	vec4 unity_LightShadowBias;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bool u_xlatb2;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
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
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_ObjectToWorld[3].xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
					    u_xlat9 = sqrt(u_xlat9);
					    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4unity_MatrixVP[3];
					    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat1 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4glstate_matrix_mvp[3];
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(unity_LightShadowBias.z!=0.0);
					#else
					    u_xlatb2 = unity_LightShadowBias.z!=0.0;
					#endif
					    u_xlat0 = (bool(u_xlatb2)) ? u_xlat0 : u_xlat1;
					    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat6 = u_xlat0.z + u_xlat1.x;
					    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
					    gl_Position.xyw = u_xlat0.xyw;
					    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					layout(location = 0) out lowp vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	vec4 unity_LightShadowBias;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bool u_xlatb2;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
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
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_ObjectToWorld[3].xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
					    u_xlat9 = sqrt(u_xlat9);
					    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4unity_MatrixVP[3];
					    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat1 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4glstate_matrix_mvp[3];
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(unity_LightShadowBias.z!=0.0);
					#else
					    u_xlatb2 = unity_LightShadowBias.z!=0.0;
					#endif
					    u_xlat0 = (bool(u_xlatb2)) ? u_xlat0 : u_xlat1;
					    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat6 = u_xlat0.z + u_xlat1.x;
					    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
					    gl_Position.xyw = u_xlat0.xyw;
					    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					layout(location = 0) out lowp vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier03 " {
Keywords { "SHADOWS_DEPTH" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	vec4 unity_LightShadowBias;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bool u_xlatb2;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
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
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_ObjectToWorld[3].xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
					    u_xlat9 = sqrt(u_xlat9);
					    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4unity_MatrixVP[3];
					    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat1 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4glstate_matrix_mvp[3];
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(unity_LightShadowBias.z!=0.0);
					#else
					    u_xlatb2 = unity_LightShadowBias.z!=0.0;
					#endif
					    u_xlat0 = (bool(u_xlatb2)) ? u_xlat0 : u_xlat1;
					    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat6 = u_xlat0.z + u_xlat1.x;
					    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
					    gl_Position.xyw = u_xlat0.xyw;
					    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					layout(location = 0) out lowp vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					#endif
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _LightPositionRange;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					varying highp vec3 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.w = 1.0;
					  tmpvar_1.xyz = _glesVertex.xyz;
					  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
					  gl_Position = (glstate_matrix_mvp * tmpvar_1);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _LightPositionRange;
					uniform highp vec4 unity_LightShadowBias;
					varying highp vec3 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  highp vec4 enc_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
					    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
					  , 0.999)));
					  enc_2 = (tmpvar_3 - (tmpvar_3.yzww * 0.003921569));
					  tmpvar_1 = enc_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _LightPositionRange;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					varying highp vec3 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.w = 1.0;
					  tmpvar_1.xyz = _glesVertex.xyz;
					  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
					  gl_Position = (glstate_matrix_mvp * tmpvar_1);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _LightPositionRange;
					uniform highp vec4 unity_LightShadowBias;
					varying highp vec3 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  highp vec4 enc_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
					    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
					  , 0.999)));
					  enc_2 = (tmpvar_3 - (tmpvar_3.yzww * 0.003921569));
					  tmpvar_1 = enc_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_CUBE" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _LightPositionRange;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					varying highp vec3 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.w = 1.0;
					  tmpvar_1.xyz = _glesVertex.xyz;
					  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
					  gl_Position = (glstate_matrix_mvp * tmpvar_1);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _LightPositionRange;
					uniform highp vec4 unity_LightShadowBias;
					varying highp vec3 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  highp vec4 enc_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
					    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
					  , 0.999)));
					  enc_2 = (tmpvar_3 - (tmpvar_3.yzww * 0.003921569));
					  tmpvar_1 = enc_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _LightPositionRange;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					in highp vec4 in_POSITION0;
					out highp vec3 vs_TEXCOORD0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz + (-_LightPositionRange.xyz);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _LightPositionRange;
					uniform 	vec4 unity_LightShadowBias;
					in highp vec3 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + unity_LightShadowBias.x;
					    u_xlat0.x = u_xlat0.x * _LightPositionRange.w;
					    u_xlat0.x = min(u_xlat0.x, 0.999000013);
					    u_xlat0 = u_xlat0.xxxx * vec4(1.0, 255.0, 65025.0, 16581375.0);
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = (-u_xlat0.yzww) * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _LightPositionRange;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					in highp vec4 in_POSITION0;
					out highp vec3 vs_TEXCOORD0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz + (-_LightPositionRange.xyz);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _LightPositionRange;
					uniform 	vec4 unity_LightShadowBias;
					in highp vec3 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + unity_LightShadowBias.x;
					    u_xlat0.x = u_xlat0.x * _LightPositionRange.w;
					    u_xlat0.x = min(u_xlat0.x, 0.999000013);
					    u_xlat0 = u_xlat0.xxxx * vec4(1.0, 255.0, 65025.0, 16581375.0);
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = (-u_xlat0.yzww) * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier03 " {
Keywords { "SHADOWS_CUBE" }
					
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _LightPositionRange;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					in highp vec4 in_POSITION0;
					out highp vec3 vs_TEXCOORD0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz + (-_LightPositionRange.xyz);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _LightPositionRange;
					uniform 	vec4 unity_LightShadowBias;
					in highp vec3 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + unity_LightShadowBias.x;
					    u_xlat0.x = u_xlat0.x * _LightPositionRange.w;
					    u_xlat0.x = min(u_xlat0.x, 0.999000013);
					    u_xlat0 = u_xlat0.xxxx * vec4(1.0, 255.0, 65025.0, 16581375.0);
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = (-u_xlat0.yzww) * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif
}
}
Program "fp" {
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
					
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
					
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_DEPTH" }
					
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
					
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
					
}
SubProgram "gles3 hw_tier03 " {
Keywords { "SHADOWS_DEPTH" }
					
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
					
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
					
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_CUBE" }
					
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
					
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
					
}
SubProgram "gles3 hw_tier03 " {
Keywords { "SHADOWS_CUBE" }
					
}
}
 }
}
Fallback "Specular"
}