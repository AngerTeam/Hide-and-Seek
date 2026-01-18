Shader "kaleb/Cutout Vertex Color Decal Animated" {
Properties {
 _MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
 _Color ("Color", Color) = (1.000000,1.000000,1.000000,1.000000)
 _Power ("Power", Float) = 1.000000
 _XFrames ("X Frames", Float) = 4.000000
 _YFrames ("Y Frames", Float) = 4.000000
 _Step ("Frame", Float) = 0.000000
}
SubShader { 
 LOD 200
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
  Blend SrcAlpha OneMinusSrcAlpha
  ColorMask RGB
  Offset -1.000000, -1.000000
  GpuProgramID 33859
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
					uniform highp vec4 _Color;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Step;
					uniform highp float _Power;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  lowp float tmpvar_5;
					  lowp vec3 lightDir_6;
					  mediump vec3 tmpvar_7;
					  tmpvar_7 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_7;
					  tmpvar_3 = vec3(0.0, 0.0, 0.0);
					  tmpvar_5 = 0.0;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec3 tmpvar_8;
					  lowp float tmpvar_9;
					  tmpvar_8 = tmpvar_3;
					  tmpvar_9 = tmpvar_5;
					  lowp vec4 c_10;
					  highp vec2 spriteUV_11;
					  highp float tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = float(_XFrames);
					  tmpvar_12 = (1.0/(tmpvar_13));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(float(_YFrames)));
					  spriteUV_11 = xlv_TEXCOORD0;
					  highp float tmpvar_15;
					  tmpvar_15 = (_Step / tmpvar_13);
					  highp float tmpvar_16;
					  tmpvar_16 = (fract(abs(tmpvar_15)) * tmpvar_13);
					  highp float tmpvar_17;
					  if ((tmpvar_15 >= 0.0)) {
					    tmpvar_17 = tmpvar_16;
					  } else {
					    tmpvar_17 = -(tmpvar_16);
					  };
					  spriteUV_11.x = ((xlv_TEXCOORD0.x + float(
					    int(tmpvar_17)
					  )) * tmpvar_12);
					  spriteUV_11.y = ((xlv_TEXCOORD0.y + float(
					    int((float(_YFrames) - (_Step / float(_XFrames))))
					  )) * tmpvar_14);
					  lowp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_MainTex, spriteUV_11);
					  highp vec4 tmpvar_19;
					  tmpvar_19 = ((tmpvar_18 * xlv_COLOR0) * _Color);
					  c_10 = tmpvar_19;
					  tmpvar_8 = (c_10.xyz * _Power);
					  tmpvar_9 = c_10.w;
					  tmpvar_3 = tmpvar_8;
					  tmpvar_5 = tmpvar_9;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  lowp vec4 c_20;
					  lowp vec4 c_21;
					  lowp float diff_22;
					  mediump float tmpvar_23;
					  tmpvar_23 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_22 = tmpvar_23;
					  c_21.xyz = ((tmpvar_8 * tmpvar_1) * diff_22);
					  c_21.w = tmpvar_9;
					  c_20.w = c_21.w;
					  c_20.xyz = (c_21.xyz + (tmpvar_8 * xlv_TEXCOORD3));
					  gl_FragData[0] = c_20;
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
					uniform highp vec4 _Color;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Step;
					uniform highp float _Power;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  lowp float tmpvar_5;
					  lowp vec3 lightDir_6;
					  mediump vec3 tmpvar_7;
					  tmpvar_7 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_7;
					  tmpvar_3 = vec3(0.0, 0.0, 0.0);
					  tmpvar_5 = 0.0;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec3 tmpvar_8;
					  lowp float tmpvar_9;
					  tmpvar_8 = tmpvar_3;
					  tmpvar_9 = tmpvar_5;
					  lowp vec4 c_10;
					  highp vec2 spriteUV_11;
					  highp float tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = float(_XFrames);
					  tmpvar_12 = (1.0/(tmpvar_13));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(float(_YFrames)));
					  spriteUV_11 = xlv_TEXCOORD0;
					  highp float tmpvar_15;
					  tmpvar_15 = (_Step / tmpvar_13);
					  highp float tmpvar_16;
					  tmpvar_16 = (fract(abs(tmpvar_15)) * tmpvar_13);
					  highp float tmpvar_17;
					  if ((tmpvar_15 >= 0.0)) {
					    tmpvar_17 = tmpvar_16;
					  } else {
					    tmpvar_17 = -(tmpvar_16);
					  };
					  spriteUV_11.x = ((xlv_TEXCOORD0.x + float(
					    int(tmpvar_17)
					  )) * tmpvar_12);
					  spriteUV_11.y = ((xlv_TEXCOORD0.y + float(
					    int((float(_YFrames) - (_Step / float(_XFrames))))
					  )) * tmpvar_14);
					  lowp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_MainTex, spriteUV_11);
					  highp vec4 tmpvar_19;
					  tmpvar_19 = ((tmpvar_18 * xlv_COLOR0) * _Color);
					  c_10 = tmpvar_19;
					  tmpvar_8 = (c_10.xyz * _Power);
					  tmpvar_9 = c_10.w;
					  tmpvar_3 = tmpvar_8;
					  tmpvar_5 = tmpvar_9;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  lowp vec4 c_20;
					  lowp vec4 c_21;
					  lowp float diff_22;
					  mediump float tmpvar_23;
					  tmpvar_23 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_22 = tmpvar_23;
					  c_21.xyz = ((tmpvar_8 * tmpvar_1) * diff_22);
					  c_21.w = tmpvar_9;
					  c_20.w = c_21.w;
					  c_20.xyz = (c_21.xyz + (tmpvar_8 * xlv_TEXCOORD3));
					  gl_FragData[0] = c_20;
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
					uniform highp vec4 _Color;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Step;
					uniform highp float _Power;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  lowp float tmpvar_5;
					  lowp vec3 lightDir_6;
					  mediump vec3 tmpvar_7;
					  tmpvar_7 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_7;
					  tmpvar_3 = vec3(0.0, 0.0, 0.0);
					  tmpvar_5 = 0.0;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec3 tmpvar_8;
					  lowp float tmpvar_9;
					  tmpvar_8 = tmpvar_3;
					  tmpvar_9 = tmpvar_5;
					  lowp vec4 c_10;
					  highp vec2 spriteUV_11;
					  highp float tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = float(_XFrames);
					  tmpvar_12 = (1.0/(tmpvar_13));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(float(_YFrames)));
					  spriteUV_11 = xlv_TEXCOORD0;
					  highp float tmpvar_15;
					  tmpvar_15 = (_Step / tmpvar_13);
					  highp float tmpvar_16;
					  tmpvar_16 = (fract(abs(tmpvar_15)) * tmpvar_13);
					  highp float tmpvar_17;
					  if ((tmpvar_15 >= 0.0)) {
					    tmpvar_17 = tmpvar_16;
					  } else {
					    tmpvar_17 = -(tmpvar_16);
					  };
					  spriteUV_11.x = ((xlv_TEXCOORD0.x + float(
					    int(tmpvar_17)
					  )) * tmpvar_12);
					  spriteUV_11.y = ((xlv_TEXCOORD0.y + float(
					    int((float(_YFrames) - (_Step / float(_XFrames))))
					  )) * tmpvar_14);
					  lowp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_MainTex, spriteUV_11);
					  highp vec4 tmpvar_19;
					  tmpvar_19 = ((tmpvar_18 * xlv_COLOR0) * _Color);
					  c_10 = tmpvar_19;
					  tmpvar_8 = (c_10.xyz * _Power);
					  tmpvar_9 = c_10.w;
					  tmpvar_3 = tmpvar_8;
					  tmpvar_5 = tmpvar_9;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  lowp vec4 c_20;
					  lowp vec4 c_21;
					  lowp float diff_22;
					  mediump float tmpvar_23;
					  tmpvar_23 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_22 = tmpvar_23;
					  c_21.xyz = ((tmpvar_8 * tmpvar_1) * diff_22);
					  c_21.w = tmpvar_9;
					  c_20.w = c_21.w;
					  c_20.xyz = (c_21.xyz + (tmpvar_8 * xlv_TEXCOORD3));
					  gl_FragData[0] = c_20;
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
					uniform 	vec4 _Color;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Step;
					uniform 	float _Power;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					vec2 u_xlat1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec2 u_xlat8;
					uint u_xlatu8;
					float u_xlat12;
					uint u_xlatu12;
					bool u_xlatb12;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat8.x = _Step / u_xlat0.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb12 = !!(u_xlat8.x>=(-u_xlat8.x));
					#else
					    u_xlatb12 = u_xlat8.x>=(-u_xlat8.x);
					#endif
					    u_xlat1.x = fract(abs(u_xlat8.x));
					    u_xlat8.x = (-u_xlat8.x) + u_xlat0.y;
					    u_xlatu8 = uint(u_xlat8.x);
					    u_xlat8.x = float(u_xlatu8);
					    u_xlat12 = (u_xlatb12) ? u_xlat1.x : (-u_xlat1.x);
					    u_xlat12 = u_xlat0.x * u_xlat12;
					    u_xlat0.xy = vec2(1.0, 1.0) / u_xlat0.xy;
					    u_xlatu12 = uint(u_xlat12);
					    u_xlat8.y = float(u_xlatu12);
					    u_xlat8.xy = u_xlat8.xy + vs_TEXCOORD0.yx;
					    u_xlat1.xy = u_xlat0.xy * u_xlat8.yx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    u_xlat0 = u_xlat16_0 * _Color;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Power, _Power, _Power));
					    SV_Target0.w = u_xlat0.w;
					    u_xlat16_2.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat16_3.xyz = u_xlat0.xyz * vs_TEXCOORD3.xyz;
					    u_xlat16_14 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_14 = max(u_xlat16_14, 0.0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_14) + u_xlat16_3.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz;
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
					uniform 	vec4 _Color;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Step;
					uniform 	float _Power;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					vec2 u_xlat1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec2 u_xlat8;
					uint u_xlatu8;
					float u_xlat12;
					uint u_xlatu12;
					bool u_xlatb12;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat8.x = _Step / u_xlat0.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb12 = !!(u_xlat8.x>=(-u_xlat8.x));
					#else
					    u_xlatb12 = u_xlat8.x>=(-u_xlat8.x);
					#endif
					    u_xlat1.x = fract(abs(u_xlat8.x));
					    u_xlat8.x = (-u_xlat8.x) + u_xlat0.y;
					    u_xlatu8 = uint(u_xlat8.x);
					    u_xlat8.x = float(u_xlatu8);
					    u_xlat12 = (u_xlatb12) ? u_xlat1.x : (-u_xlat1.x);
					    u_xlat12 = u_xlat0.x * u_xlat12;
					    u_xlat0.xy = vec2(1.0, 1.0) / u_xlat0.xy;
					    u_xlatu12 = uint(u_xlat12);
					    u_xlat8.y = float(u_xlatu12);
					    u_xlat8.xy = u_xlat8.xy + vs_TEXCOORD0.yx;
					    u_xlat1.xy = u_xlat0.xy * u_xlat8.yx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    u_xlat0 = u_xlat16_0 * _Color;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Power, _Power, _Power));
					    SV_Target0.w = u_xlat0.w;
					    u_xlat16_2.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat16_3.xyz = u_xlat0.xyz * vs_TEXCOORD3.xyz;
					    u_xlat16_14 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_14 = max(u_xlat16_14, 0.0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_14) + u_xlat16_3.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz;
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
					uniform 	vec4 _Color;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Step;
					uniform 	float _Power;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					vec2 u_xlat1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec2 u_xlat8;
					uint u_xlatu8;
					float u_xlat12;
					uint u_xlatu12;
					bool u_xlatb12;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat8.x = _Step / u_xlat0.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb12 = !!(u_xlat8.x>=(-u_xlat8.x));
					#else
					    u_xlatb12 = u_xlat8.x>=(-u_xlat8.x);
					#endif
					    u_xlat1.x = fract(abs(u_xlat8.x));
					    u_xlat8.x = (-u_xlat8.x) + u_xlat0.y;
					    u_xlatu8 = uint(u_xlat8.x);
					    u_xlat8.x = float(u_xlatu8);
					    u_xlat12 = (u_xlatb12) ? u_xlat1.x : (-u_xlat1.x);
					    u_xlat12 = u_xlat0.x * u_xlat12;
					    u_xlat0.xy = vec2(1.0, 1.0) / u_xlat0.xy;
					    u_xlatu12 = uint(u_xlat12);
					    u_xlat8.y = float(u_xlatu12);
					    u_xlat8.xy = u_xlat8.xy + vs_TEXCOORD0.yx;
					    u_xlat1.xy = u_xlat0.xy * u_xlat8.yx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    u_xlat0 = u_xlat16_0 * _Color;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Power, _Power, _Power));
					    SV_Target0.w = u_xlat0.w;
					    u_xlat16_2.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat16_3.xyz = u_xlat0.xyz * vs_TEXCOORD3.xyz;
					    u_xlat16_14 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_14 = max(u_xlat16_14, 0.0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_14) + u_xlat16_3.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz;
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
					uniform highp vec4 _Color;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Step;
					uniform highp float _Power;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  lowp float tmpvar_5;
					  lowp vec3 lightDir_6;
					  mediump vec3 tmpvar_7;
					  tmpvar_7 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_7;
					  tmpvar_3 = vec3(0.0, 0.0, 0.0);
					  tmpvar_5 = 0.0;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec3 tmpvar_8;
					  lowp float tmpvar_9;
					  tmpvar_8 = tmpvar_3;
					  tmpvar_9 = tmpvar_5;
					  lowp vec4 c_10;
					  highp vec2 spriteUV_11;
					  highp float tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = float(_XFrames);
					  tmpvar_12 = (1.0/(tmpvar_13));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(float(_YFrames)));
					  spriteUV_11 = xlv_TEXCOORD0;
					  highp float tmpvar_15;
					  tmpvar_15 = (_Step / tmpvar_13);
					  highp float tmpvar_16;
					  tmpvar_16 = (fract(abs(tmpvar_15)) * tmpvar_13);
					  highp float tmpvar_17;
					  if ((tmpvar_15 >= 0.0)) {
					    tmpvar_17 = tmpvar_16;
					  } else {
					    tmpvar_17 = -(tmpvar_16);
					  };
					  spriteUV_11.x = ((xlv_TEXCOORD0.x + float(
					    int(tmpvar_17)
					  )) * tmpvar_12);
					  spriteUV_11.y = ((xlv_TEXCOORD0.y + float(
					    int((float(_YFrames) - (_Step / float(_XFrames))))
					  )) * tmpvar_14);
					  lowp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_MainTex, spriteUV_11);
					  highp vec4 tmpvar_19;
					  tmpvar_19 = ((tmpvar_18 * xlv_COLOR0) * _Color);
					  c_10 = tmpvar_19;
					  tmpvar_8 = (c_10.xyz * _Power);
					  tmpvar_9 = c_10.w;
					  tmpvar_3 = tmpvar_8;
					  tmpvar_5 = tmpvar_9;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  lowp vec4 c_20;
					  lowp vec4 c_21;
					  lowp float diff_22;
					  mediump float tmpvar_23;
					  tmpvar_23 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_22 = tmpvar_23;
					  c_21.xyz = ((tmpvar_8 * tmpvar_1) * diff_22);
					  c_21.w = tmpvar_9;
					  c_20.w = c_21.w;
					  c_20.xyz = (c_21.xyz + (tmpvar_8 * xlv_TEXCOORD3));
					  gl_FragData[0] = c_20;
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
					uniform highp vec4 _Color;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Step;
					uniform highp float _Power;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  lowp float tmpvar_5;
					  lowp vec3 lightDir_6;
					  mediump vec3 tmpvar_7;
					  tmpvar_7 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_7;
					  tmpvar_3 = vec3(0.0, 0.0, 0.0);
					  tmpvar_5 = 0.0;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec3 tmpvar_8;
					  lowp float tmpvar_9;
					  tmpvar_8 = tmpvar_3;
					  tmpvar_9 = tmpvar_5;
					  lowp vec4 c_10;
					  highp vec2 spriteUV_11;
					  highp float tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = float(_XFrames);
					  tmpvar_12 = (1.0/(tmpvar_13));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(float(_YFrames)));
					  spriteUV_11 = xlv_TEXCOORD0;
					  highp float tmpvar_15;
					  tmpvar_15 = (_Step / tmpvar_13);
					  highp float tmpvar_16;
					  tmpvar_16 = (fract(abs(tmpvar_15)) * tmpvar_13);
					  highp float tmpvar_17;
					  if ((tmpvar_15 >= 0.0)) {
					    tmpvar_17 = tmpvar_16;
					  } else {
					    tmpvar_17 = -(tmpvar_16);
					  };
					  spriteUV_11.x = ((xlv_TEXCOORD0.x + float(
					    int(tmpvar_17)
					  )) * tmpvar_12);
					  spriteUV_11.y = ((xlv_TEXCOORD0.y + float(
					    int((float(_YFrames) - (_Step / float(_XFrames))))
					  )) * tmpvar_14);
					  lowp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_MainTex, spriteUV_11);
					  highp vec4 tmpvar_19;
					  tmpvar_19 = ((tmpvar_18 * xlv_COLOR0) * _Color);
					  c_10 = tmpvar_19;
					  tmpvar_8 = (c_10.xyz * _Power);
					  tmpvar_9 = c_10.w;
					  tmpvar_3 = tmpvar_8;
					  tmpvar_5 = tmpvar_9;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  lowp vec4 c_20;
					  lowp vec4 c_21;
					  lowp float diff_22;
					  mediump float tmpvar_23;
					  tmpvar_23 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_22 = tmpvar_23;
					  c_21.xyz = ((tmpvar_8 * tmpvar_1) * diff_22);
					  c_21.w = tmpvar_9;
					  c_20.w = c_21.w;
					  c_20.xyz = (c_21.xyz + (tmpvar_8 * xlv_TEXCOORD3));
					  gl_FragData[0] = c_20;
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
					uniform highp vec4 _Color;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Step;
					uniform highp float _Power;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  lowp float tmpvar_5;
					  lowp vec3 lightDir_6;
					  mediump vec3 tmpvar_7;
					  tmpvar_7 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_7;
					  tmpvar_3 = vec3(0.0, 0.0, 0.0);
					  tmpvar_5 = 0.0;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec3 tmpvar_8;
					  lowp float tmpvar_9;
					  tmpvar_8 = tmpvar_3;
					  tmpvar_9 = tmpvar_5;
					  lowp vec4 c_10;
					  highp vec2 spriteUV_11;
					  highp float tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = float(_XFrames);
					  tmpvar_12 = (1.0/(tmpvar_13));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(float(_YFrames)));
					  spriteUV_11 = xlv_TEXCOORD0;
					  highp float tmpvar_15;
					  tmpvar_15 = (_Step / tmpvar_13);
					  highp float tmpvar_16;
					  tmpvar_16 = (fract(abs(tmpvar_15)) * tmpvar_13);
					  highp float tmpvar_17;
					  if ((tmpvar_15 >= 0.0)) {
					    tmpvar_17 = tmpvar_16;
					  } else {
					    tmpvar_17 = -(tmpvar_16);
					  };
					  spriteUV_11.x = ((xlv_TEXCOORD0.x + float(
					    int(tmpvar_17)
					  )) * tmpvar_12);
					  spriteUV_11.y = ((xlv_TEXCOORD0.y + float(
					    int((float(_YFrames) - (_Step / float(_XFrames))))
					  )) * tmpvar_14);
					  lowp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_MainTex, spriteUV_11);
					  highp vec4 tmpvar_19;
					  tmpvar_19 = ((tmpvar_18 * xlv_COLOR0) * _Color);
					  c_10 = tmpvar_19;
					  tmpvar_8 = (c_10.xyz * _Power);
					  tmpvar_9 = c_10.w;
					  tmpvar_3 = tmpvar_8;
					  tmpvar_5 = tmpvar_9;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  lowp vec4 c_20;
					  lowp vec4 c_21;
					  lowp float diff_22;
					  mediump float tmpvar_23;
					  tmpvar_23 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_22 = tmpvar_23;
					  c_21.xyz = ((tmpvar_8 * tmpvar_1) * diff_22);
					  c_21.w = tmpvar_9;
					  c_20.w = c_21.w;
					  c_20.xyz = (c_21.xyz + (tmpvar_8 * xlv_TEXCOORD3));
					  gl_FragData[0] = c_20;
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
					uniform 	vec4 _Color;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Step;
					uniform 	float _Power;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					vec2 u_xlat1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec2 u_xlat8;
					uint u_xlatu8;
					float u_xlat12;
					uint u_xlatu12;
					bool u_xlatb12;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat8.x = _Step / u_xlat0.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb12 = !!(u_xlat8.x>=(-u_xlat8.x));
					#else
					    u_xlatb12 = u_xlat8.x>=(-u_xlat8.x);
					#endif
					    u_xlat1.x = fract(abs(u_xlat8.x));
					    u_xlat8.x = (-u_xlat8.x) + u_xlat0.y;
					    u_xlatu8 = uint(u_xlat8.x);
					    u_xlat8.x = float(u_xlatu8);
					    u_xlat12 = (u_xlatb12) ? u_xlat1.x : (-u_xlat1.x);
					    u_xlat12 = u_xlat0.x * u_xlat12;
					    u_xlat0.xy = vec2(1.0, 1.0) / u_xlat0.xy;
					    u_xlatu12 = uint(u_xlat12);
					    u_xlat8.y = float(u_xlatu12);
					    u_xlat8.xy = u_xlat8.xy + vs_TEXCOORD0.yx;
					    u_xlat1.xy = u_xlat0.xy * u_xlat8.yx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    u_xlat0 = u_xlat16_0 * _Color;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Power, _Power, _Power));
					    SV_Target0.w = u_xlat0.w;
					    u_xlat16_2.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat16_3.xyz = u_xlat0.xyz * vs_TEXCOORD3.xyz;
					    u_xlat16_14 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_14 = max(u_xlat16_14, 0.0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_14) + u_xlat16_3.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz;
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
					uniform 	vec4 _Color;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Step;
					uniform 	float _Power;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					vec2 u_xlat1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec2 u_xlat8;
					uint u_xlatu8;
					float u_xlat12;
					uint u_xlatu12;
					bool u_xlatb12;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat8.x = _Step / u_xlat0.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb12 = !!(u_xlat8.x>=(-u_xlat8.x));
					#else
					    u_xlatb12 = u_xlat8.x>=(-u_xlat8.x);
					#endif
					    u_xlat1.x = fract(abs(u_xlat8.x));
					    u_xlat8.x = (-u_xlat8.x) + u_xlat0.y;
					    u_xlatu8 = uint(u_xlat8.x);
					    u_xlat8.x = float(u_xlatu8);
					    u_xlat12 = (u_xlatb12) ? u_xlat1.x : (-u_xlat1.x);
					    u_xlat12 = u_xlat0.x * u_xlat12;
					    u_xlat0.xy = vec2(1.0, 1.0) / u_xlat0.xy;
					    u_xlatu12 = uint(u_xlat12);
					    u_xlat8.y = float(u_xlatu12);
					    u_xlat8.xy = u_xlat8.xy + vs_TEXCOORD0.yx;
					    u_xlat1.xy = u_xlat0.xy * u_xlat8.yx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    u_xlat0 = u_xlat16_0 * _Color;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Power, _Power, _Power));
					    SV_Target0.w = u_xlat0.w;
					    u_xlat16_2.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat16_3.xyz = u_xlat0.xyz * vs_TEXCOORD3.xyz;
					    u_xlat16_14 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_14 = max(u_xlat16_14, 0.0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_14) + u_xlat16_3.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz;
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
					uniform 	vec4 _Color;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Step;
					uniform 	float _Power;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					vec2 u_xlat1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					vec2 u_xlat8;
					uint u_xlatu8;
					float u_xlat12;
					uint u_xlatu12;
					bool u_xlatb12;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat8.x = _Step / u_xlat0.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb12 = !!(u_xlat8.x>=(-u_xlat8.x));
					#else
					    u_xlatb12 = u_xlat8.x>=(-u_xlat8.x);
					#endif
					    u_xlat1.x = fract(abs(u_xlat8.x));
					    u_xlat8.x = (-u_xlat8.x) + u_xlat0.y;
					    u_xlatu8 = uint(u_xlat8.x);
					    u_xlat8.x = float(u_xlatu8);
					    u_xlat12 = (u_xlatb12) ? u_xlat1.x : (-u_xlat1.x);
					    u_xlat12 = u_xlat0.x * u_xlat12;
					    u_xlat0.xy = vec2(1.0, 1.0) / u_xlat0.xy;
					    u_xlatu12 = uint(u_xlat12);
					    u_xlat8.y = float(u_xlatu12);
					    u_xlat8.xy = u_xlat8.xy + vs_TEXCOORD0.yx;
					    u_xlat1.xy = u_xlat0.xy * u_xlat8.yx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    u_xlat0 = u_xlat16_0 * _Color;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Power, _Power, _Power));
					    SV_Target0.w = u_xlat0.w;
					    u_xlat16_2.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat16_3.xyz = u_xlat0.xyz * vs_TEXCOORD3.xyz;
					    u_xlat16_14 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_14 = max(u_xlat16_14, 0.0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_14) + u_xlat16_3.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz;
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
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
  Blend SrcAlpha One
  ColorMask RGB
  Offset -1.000000, -1.000000
  GpuProgramID 95990
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
					uniform highp vec4 _Color;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Step;
					uniform highp float _Power;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  lowp float tmpvar_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_6 = tmpvar_7;
					  tmpvar_3 = vec3(0.0, 0.0, 0.0);
					  tmpvar_5 = 0.0;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec3 tmpvar_8;
					  lowp float tmpvar_9;
					  tmpvar_8 = tmpvar_3;
					  tmpvar_9 = tmpvar_5;
					  lowp vec4 c_10;
					  highp vec2 spriteUV_11;
					  highp float tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = float(_XFrames);
					  tmpvar_12 = (1.0/(tmpvar_13));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(float(_YFrames)));
					  spriteUV_11 = xlv_TEXCOORD0;
					  highp float tmpvar_15;
					  tmpvar_15 = (_Step / tmpvar_13);
					  highp float tmpvar_16;
					  tmpvar_16 = (fract(abs(tmpvar_15)) * tmpvar_13);
					  highp float tmpvar_17;
					  if ((tmpvar_15 >= 0.0)) {
					    tmpvar_17 = tmpvar_16;
					  } else {
					    tmpvar_17 = -(tmpvar_16);
					  };
					  spriteUV_11.x = ((xlv_TEXCOORD0.x + float(
					    int(tmpvar_17)
					  )) * tmpvar_12);
					  spriteUV_11.y = ((xlv_TEXCOORD0.y + float(
					    int((float(_YFrames) - (_Step / float(_XFrames))))
					  )) * tmpvar_14);
					  lowp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_MainTex, spriteUV_11);
					  highp vec4 tmpvar_19;
					  tmpvar_19 = ((tmpvar_18 * xlv_COLOR0) * _Color);
					  c_10 = tmpvar_19;
					  tmpvar_8 = (c_10.xyz * _Power);
					  tmpvar_9 = c_10.w;
					  tmpvar_3 = tmpvar_8;
					  tmpvar_5 = tmpvar_9;
					  highp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = xlv_TEXCOORD2;
					  highp vec3 tmpvar_21;
					  tmpvar_21 = (unity_WorldToLight * tmpvar_20).xyz;
					  highp float tmpvar_22;
					  tmpvar_22 = dot (tmpvar_21, tmpvar_21);
					  lowp float tmpvar_23;
					  tmpvar_23 = texture2D (_LightTexture0, vec2(tmpvar_22)).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_23);
					  lowp vec4 c_24;
					  lowp vec4 c_25;
					  lowp float diff_26;
					  mediump float tmpvar_27;
					  tmpvar_27 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_26 = tmpvar_27;
					  c_25.xyz = ((tmpvar_8 * tmpvar_1) * diff_26);
					  c_25.w = tmpvar_9;
					  c_24.w = c_25.w;
					  c_24.xyz = c_25.xyz;
					  gl_FragData[0] = c_24;
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
					uniform highp vec4 _Color;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Step;
					uniform highp float _Power;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  lowp float tmpvar_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_6 = tmpvar_7;
					  tmpvar_3 = vec3(0.0, 0.0, 0.0);
					  tmpvar_5 = 0.0;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec3 tmpvar_8;
					  lowp float tmpvar_9;
					  tmpvar_8 = tmpvar_3;
					  tmpvar_9 = tmpvar_5;
					  lowp vec4 c_10;
					  highp vec2 spriteUV_11;
					  highp float tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = float(_XFrames);
					  tmpvar_12 = (1.0/(tmpvar_13));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(float(_YFrames)));
					  spriteUV_11 = xlv_TEXCOORD0;
					  highp float tmpvar_15;
					  tmpvar_15 = (_Step / tmpvar_13);
					  highp float tmpvar_16;
					  tmpvar_16 = (fract(abs(tmpvar_15)) * tmpvar_13);
					  highp float tmpvar_17;
					  if ((tmpvar_15 >= 0.0)) {
					    tmpvar_17 = tmpvar_16;
					  } else {
					    tmpvar_17 = -(tmpvar_16);
					  };
					  spriteUV_11.x = ((xlv_TEXCOORD0.x + float(
					    int(tmpvar_17)
					  )) * tmpvar_12);
					  spriteUV_11.y = ((xlv_TEXCOORD0.y + float(
					    int((float(_YFrames) - (_Step / float(_XFrames))))
					  )) * tmpvar_14);
					  lowp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_MainTex, spriteUV_11);
					  highp vec4 tmpvar_19;
					  tmpvar_19 = ((tmpvar_18 * xlv_COLOR0) * _Color);
					  c_10 = tmpvar_19;
					  tmpvar_8 = (c_10.xyz * _Power);
					  tmpvar_9 = c_10.w;
					  tmpvar_3 = tmpvar_8;
					  tmpvar_5 = tmpvar_9;
					  highp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = xlv_TEXCOORD2;
					  highp vec3 tmpvar_21;
					  tmpvar_21 = (unity_WorldToLight * tmpvar_20).xyz;
					  highp float tmpvar_22;
					  tmpvar_22 = dot (tmpvar_21, tmpvar_21);
					  lowp float tmpvar_23;
					  tmpvar_23 = texture2D (_LightTexture0, vec2(tmpvar_22)).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_23);
					  lowp vec4 c_24;
					  lowp vec4 c_25;
					  lowp float diff_26;
					  mediump float tmpvar_27;
					  tmpvar_27 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_26 = tmpvar_27;
					  c_25.xyz = ((tmpvar_8 * tmpvar_1) * diff_26);
					  c_25.w = tmpvar_9;
					  c_24.w = c_25.w;
					  c_24.xyz = c_25.xyz;
					  gl_FragData[0] = c_24;
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
					uniform highp vec4 _Color;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Step;
					uniform highp float _Power;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  lowp float tmpvar_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_6 = tmpvar_7;
					  tmpvar_3 = vec3(0.0, 0.0, 0.0);
					  tmpvar_5 = 0.0;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec3 tmpvar_8;
					  lowp float tmpvar_9;
					  tmpvar_8 = tmpvar_3;
					  tmpvar_9 = tmpvar_5;
					  lowp vec4 c_10;
					  highp vec2 spriteUV_11;
					  highp float tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = float(_XFrames);
					  tmpvar_12 = (1.0/(tmpvar_13));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(float(_YFrames)));
					  spriteUV_11 = xlv_TEXCOORD0;
					  highp float tmpvar_15;
					  tmpvar_15 = (_Step / tmpvar_13);
					  highp float tmpvar_16;
					  tmpvar_16 = (fract(abs(tmpvar_15)) * tmpvar_13);
					  highp float tmpvar_17;
					  if ((tmpvar_15 >= 0.0)) {
					    tmpvar_17 = tmpvar_16;
					  } else {
					    tmpvar_17 = -(tmpvar_16);
					  };
					  spriteUV_11.x = ((xlv_TEXCOORD0.x + float(
					    int(tmpvar_17)
					  )) * tmpvar_12);
					  spriteUV_11.y = ((xlv_TEXCOORD0.y + float(
					    int((float(_YFrames) - (_Step / float(_XFrames))))
					  )) * tmpvar_14);
					  lowp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_MainTex, spriteUV_11);
					  highp vec4 tmpvar_19;
					  tmpvar_19 = ((tmpvar_18 * xlv_COLOR0) * _Color);
					  c_10 = tmpvar_19;
					  tmpvar_8 = (c_10.xyz * _Power);
					  tmpvar_9 = c_10.w;
					  tmpvar_3 = tmpvar_8;
					  tmpvar_5 = tmpvar_9;
					  highp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = xlv_TEXCOORD2;
					  highp vec3 tmpvar_21;
					  tmpvar_21 = (unity_WorldToLight * tmpvar_20).xyz;
					  highp float tmpvar_22;
					  tmpvar_22 = dot (tmpvar_21, tmpvar_21);
					  lowp float tmpvar_23;
					  tmpvar_23 = texture2D (_LightTexture0, vec2(tmpvar_22)).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_23);
					  lowp vec4 c_24;
					  lowp vec4 c_25;
					  lowp float diff_26;
					  mediump float tmpvar_27;
					  tmpvar_27 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_26 = tmpvar_27;
					  c_25.xyz = ((tmpvar_8 * tmpvar_1) * diff_26);
					  c_25.w = tmpvar_9;
					  c_24.w = c_25.w;
					  c_24.xyz = c_25.xyz;
					  gl_FragData[0] = c_24;
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
					uniform 	vec4 _Color;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Step;
					uniform 	float _Power;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _LightTexture0;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_2;
					vec2 u_xlat6;
					uint u_xlatu6;
					float u_xlat9;
					lowp float u_xlat10_9;
					uint u_xlatu9;
					bool u_xlatb9;
					mediump float u_xlat16_11;
					void main()
					{
					    u_xlat0.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat6.x = _Step / u_xlat0.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(u_xlat6.x>=(-u_xlat6.x));
					#else
					    u_xlatb9 = u_xlat6.x>=(-u_xlat6.x);
					#endif
					    u_xlat1.x = fract(abs(u_xlat6.x));
					    u_xlat6.x = (-u_xlat6.x) + u_xlat0.y;
					    u_xlatu6 = uint(u_xlat6.x);
					    u_xlat6.x = float(u_xlatu6);
					    u_xlat9 = (u_xlatb9) ? u_xlat1.x : (-u_xlat1.x);
					    u_xlat9 = u_xlat0.x * u_xlat9;
					    u_xlat0.xy = vec2(1.0, 1.0) / u_xlat0.xy;
					    u_xlatu9 = uint(u_xlat9);
					    u_xlat6.y = float(u_xlatu9);
					    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD0.yx;
					    u_xlat1.xy = u_xlat0.xy * u_xlat6.yx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    u_xlat0 = u_xlat16_0 * _Color;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Power, _Power, _Power));
					    SV_Target0.w = u_xlat0.w;
					    u_xlat1.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_WorldToLight[3].xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10_9 = texture(_LightTexture0, vec2(u_xlat9)).w;
					    u_xlat16_2.xyz = vec3(u_xlat10_9) * _LightColor0.xyz;
					    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat16_11 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat16_11 = max(u_xlat16_11, 0.0);
					    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz;
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
					uniform 	vec4 _Color;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Step;
					uniform 	float _Power;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _LightTexture0;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_2;
					vec2 u_xlat6;
					uint u_xlatu6;
					float u_xlat9;
					lowp float u_xlat10_9;
					uint u_xlatu9;
					bool u_xlatb9;
					mediump float u_xlat16_11;
					void main()
					{
					    u_xlat0.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat6.x = _Step / u_xlat0.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(u_xlat6.x>=(-u_xlat6.x));
					#else
					    u_xlatb9 = u_xlat6.x>=(-u_xlat6.x);
					#endif
					    u_xlat1.x = fract(abs(u_xlat6.x));
					    u_xlat6.x = (-u_xlat6.x) + u_xlat0.y;
					    u_xlatu6 = uint(u_xlat6.x);
					    u_xlat6.x = float(u_xlatu6);
					    u_xlat9 = (u_xlatb9) ? u_xlat1.x : (-u_xlat1.x);
					    u_xlat9 = u_xlat0.x * u_xlat9;
					    u_xlat0.xy = vec2(1.0, 1.0) / u_xlat0.xy;
					    u_xlatu9 = uint(u_xlat9);
					    u_xlat6.y = float(u_xlatu9);
					    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD0.yx;
					    u_xlat1.xy = u_xlat0.xy * u_xlat6.yx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    u_xlat0 = u_xlat16_0 * _Color;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Power, _Power, _Power));
					    SV_Target0.w = u_xlat0.w;
					    u_xlat1.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_WorldToLight[3].xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10_9 = texture(_LightTexture0, vec2(u_xlat9)).w;
					    u_xlat16_2.xyz = vec3(u_xlat10_9) * _LightColor0.xyz;
					    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat16_11 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat16_11 = max(u_xlat16_11, 0.0);
					    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz;
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
					uniform 	vec4 _Color;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Step;
					uniform 	float _Power;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _LightTexture0;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_2;
					vec2 u_xlat6;
					uint u_xlatu6;
					float u_xlat9;
					lowp float u_xlat10_9;
					uint u_xlatu9;
					bool u_xlatb9;
					mediump float u_xlat16_11;
					void main()
					{
					    u_xlat0.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat6.x = _Step / u_xlat0.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(u_xlat6.x>=(-u_xlat6.x));
					#else
					    u_xlatb9 = u_xlat6.x>=(-u_xlat6.x);
					#endif
					    u_xlat1.x = fract(abs(u_xlat6.x));
					    u_xlat6.x = (-u_xlat6.x) + u_xlat0.y;
					    u_xlatu6 = uint(u_xlat6.x);
					    u_xlat6.x = float(u_xlatu6);
					    u_xlat9 = (u_xlatb9) ? u_xlat1.x : (-u_xlat1.x);
					    u_xlat9 = u_xlat0.x * u_xlat9;
					    u_xlat0.xy = vec2(1.0, 1.0) / u_xlat0.xy;
					    u_xlatu9 = uint(u_xlat9);
					    u_xlat6.y = float(u_xlatu9);
					    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD0.yx;
					    u_xlat1.xy = u_xlat0.xy * u_xlat6.yx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    u_xlat0 = u_xlat16_0 * _Color;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Power, _Power, _Power));
					    SV_Target0.w = u_xlat0.w;
					    u_xlat1.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_WorldToLight[3].xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10_9 = texture(_LightTexture0, vec2(u_xlat9)).w;
					    u_xlat16_2.xyz = vec3(u_xlat10_9) * _LightColor0.xyz;
					    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat16_11 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat16_11 = max(u_xlat16_11, 0.0);
					    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz;
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
					uniform highp vec4 _Color;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Step;
					uniform highp float _Power;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  lowp float tmpvar_5;
					  lowp vec3 lightDir_6;
					  mediump vec3 tmpvar_7;
					  tmpvar_7 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_7;
					  tmpvar_3 = vec3(0.0, 0.0, 0.0);
					  tmpvar_5 = 0.0;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec3 tmpvar_8;
					  lowp float tmpvar_9;
					  tmpvar_8 = tmpvar_3;
					  tmpvar_9 = tmpvar_5;
					  lowp vec4 c_10;
					  highp vec2 spriteUV_11;
					  highp float tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = float(_XFrames);
					  tmpvar_12 = (1.0/(tmpvar_13));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(float(_YFrames)));
					  spriteUV_11 = xlv_TEXCOORD0;
					  highp float tmpvar_15;
					  tmpvar_15 = (_Step / tmpvar_13);
					  highp float tmpvar_16;
					  tmpvar_16 = (fract(abs(tmpvar_15)) * tmpvar_13);
					  highp float tmpvar_17;
					  if ((tmpvar_15 >= 0.0)) {
					    tmpvar_17 = tmpvar_16;
					  } else {
					    tmpvar_17 = -(tmpvar_16);
					  };
					  spriteUV_11.x = ((xlv_TEXCOORD0.x + float(
					    int(tmpvar_17)
					  )) * tmpvar_12);
					  spriteUV_11.y = ((xlv_TEXCOORD0.y + float(
					    int((float(_YFrames) - (_Step / float(_XFrames))))
					  )) * tmpvar_14);
					  lowp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_MainTex, spriteUV_11);
					  highp vec4 tmpvar_19;
					  tmpvar_19 = ((tmpvar_18 * xlv_COLOR0) * _Color);
					  c_10 = tmpvar_19;
					  tmpvar_8 = (c_10.xyz * _Power);
					  tmpvar_9 = c_10.w;
					  tmpvar_3 = tmpvar_8;
					  tmpvar_5 = tmpvar_9;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  lowp vec4 c_20;
					  lowp vec4 c_21;
					  lowp float diff_22;
					  mediump float tmpvar_23;
					  tmpvar_23 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_22 = tmpvar_23;
					  c_21.xyz = ((tmpvar_8 * tmpvar_1) * diff_22);
					  c_21.w = tmpvar_9;
					  c_20.w = c_21.w;
					  c_20.xyz = c_21.xyz;
					  gl_FragData[0] = c_20;
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
					uniform highp vec4 _Color;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Step;
					uniform highp float _Power;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  lowp float tmpvar_5;
					  lowp vec3 lightDir_6;
					  mediump vec3 tmpvar_7;
					  tmpvar_7 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_7;
					  tmpvar_3 = vec3(0.0, 0.0, 0.0);
					  tmpvar_5 = 0.0;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec3 tmpvar_8;
					  lowp float tmpvar_9;
					  tmpvar_8 = tmpvar_3;
					  tmpvar_9 = tmpvar_5;
					  lowp vec4 c_10;
					  highp vec2 spriteUV_11;
					  highp float tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = float(_XFrames);
					  tmpvar_12 = (1.0/(tmpvar_13));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(float(_YFrames)));
					  spriteUV_11 = xlv_TEXCOORD0;
					  highp float tmpvar_15;
					  tmpvar_15 = (_Step / tmpvar_13);
					  highp float tmpvar_16;
					  tmpvar_16 = (fract(abs(tmpvar_15)) * tmpvar_13);
					  highp float tmpvar_17;
					  if ((tmpvar_15 >= 0.0)) {
					    tmpvar_17 = tmpvar_16;
					  } else {
					    tmpvar_17 = -(tmpvar_16);
					  };
					  spriteUV_11.x = ((xlv_TEXCOORD0.x + float(
					    int(tmpvar_17)
					  )) * tmpvar_12);
					  spriteUV_11.y = ((xlv_TEXCOORD0.y + float(
					    int((float(_YFrames) - (_Step / float(_XFrames))))
					  )) * tmpvar_14);
					  lowp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_MainTex, spriteUV_11);
					  highp vec4 tmpvar_19;
					  tmpvar_19 = ((tmpvar_18 * xlv_COLOR0) * _Color);
					  c_10 = tmpvar_19;
					  tmpvar_8 = (c_10.xyz * _Power);
					  tmpvar_9 = c_10.w;
					  tmpvar_3 = tmpvar_8;
					  tmpvar_5 = tmpvar_9;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  lowp vec4 c_20;
					  lowp vec4 c_21;
					  lowp float diff_22;
					  mediump float tmpvar_23;
					  tmpvar_23 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_22 = tmpvar_23;
					  c_21.xyz = ((tmpvar_8 * tmpvar_1) * diff_22);
					  c_21.w = tmpvar_9;
					  c_20.w = c_21.w;
					  c_20.xyz = c_21.xyz;
					  gl_FragData[0] = c_20;
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
					uniform highp vec4 _Color;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Step;
					uniform highp float _Power;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  lowp float tmpvar_5;
					  lowp vec3 lightDir_6;
					  mediump vec3 tmpvar_7;
					  tmpvar_7 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_7;
					  tmpvar_3 = vec3(0.0, 0.0, 0.0);
					  tmpvar_5 = 0.0;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec3 tmpvar_8;
					  lowp float tmpvar_9;
					  tmpvar_8 = tmpvar_3;
					  tmpvar_9 = tmpvar_5;
					  lowp vec4 c_10;
					  highp vec2 spriteUV_11;
					  highp float tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = float(_XFrames);
					  tmpvar_12 = (1.0/(tmpvar_13));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(float(_YFrames)));
					  spriteUV_11 = xlv_TEXCOORD0;
					  highp float tmpvar_15;
					  tmpvar_15 = (_Step / tmpvar_13);
					  highp float tmpvar_16;
					  tmpvar_16 = (fract(abs(tmpvar_15)) * tmpvar_13);
					  highp float tmpvar_17;
					  if ((tmpvar_15 >= 0.0)) {
					    tmpvar_17 = tmpvar_16;
					  } else {
					    tmpvar_17 = -(tmpvar_16);
					  };
					  spriteUV_11.x = ((xlv_TEXCOORD0.x + float(
					    int(tmpvar_17)
					  )) * tmpvar_12);
					  spriteUV_11.y = ((xlv_TEXCOORD0.y + float(
					    int((float(_YFrames) - (_Step / float(_XFrames))))
					  )) * tmpvar_14);
					  lowp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_MainTex, spriteUV_11);
					  highp vec4 tmpvar_19;
					  tmpvar_19 = ((tmpvar_18 * xlv_COLOR0) * _Color);
					  c_10 = tmpvar_19;
					  tmpvar_8 = (c_10.xyz * _Power);
					  tmpvar_9 = c_10.w;
					  tmpvar_3 = tmpvar_8;
					  tmpvar_5 = tmpvar_9;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  lowp vec4 c_20;
					  lowp vec4 c_21;
					  lowp float diff_22;
					  mediump float tmpvar_23;
					  tmpvar_23 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_22 = tmpvar_23;
					  c_21.xyz = ((tmpvar_8 * tmpvar_1) * diff_22);
					  c_21.w = tmpvar_9;
					  c_20.w = c_21.w;
					  c_20.xyz = c_21.xyz;
					  gl_FragData[0] = c_20;
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
					uniform 	vec4 _Color;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Step;
					uniform 	float _Power;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					vec2 u_xlat1;
					mediump vec3 u_xlat16_2;
					vec2 u_xlat6;
					uint u_xlatu6;
					float u_xlat9;
					uint u_xlatu9;
					bool u_xlatb9;
					mediump float u_xlat16_11;
					void main()
					{
					    u_xlat0.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat6.x = _Step / u_xlat0.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(u_xlat6.x>=(-u_xlat6.x));
					#else
					    u_xlatb9 = u_xlat6.x>=(-u_xlat6.x);
					#endif
					    u_xlat1.x = fract(abs(u_xlat6.x));
					    u_xlat6.x = (-u_xlat6.x) + u_xlat0.y;
					    u_xlatu6 = uint(u_xlat6.x);
					    u_xlat6.x = float(u_xlatu6);
					    u_xlat9 = (u_xlatb9) ? u_xlat1.x : (-u_xlat1.x);
					    u_xlat9 = u_xlat0.x * u_xlat9;
					    u_xlat0.xy = vec2(1.0, 1.0) / u_xlat0.xy;
					    u_xlatu9 = uint(u_xlat9);
					    u_xlat6.y = float(u_xlatu9);
					    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD0.yx;
					    u_xlat1.xy = u_xlat0.xy * u_xlat6.yx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    u_xlat0 = u_xlat16_0 * _Color;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Power, _Power, _Power));
					    SV_Target0.w = u_xlat0.w;
					    u_xlat16_2.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat16_11 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_11 = max(u_xlat16_11, 0.0);
					    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz;
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
					uniform 	vec4 _Color;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Step;
					uniform 	float _Power;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					vec2 u_xlat1;
					mediump vec3 u_xlat16_2;
					vec2 u_xlat6;
					uint u_xlatu6;
					float u_xlat9;
					uint u_xlatu9;
					bool u_xlatb9;
					mediump float u_xlat16_11;
					void main()
					{
					    u_xlat0.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat6.x = _Step / u_xlat0.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(u_xlat6.x>=(-u_xlat6.x));
					#else
					    u_xlatb9 = u_xlat6.x>=(-u_xlat6.x);
					#endif
					    u_xlat1.x = fract(abs(u_xlat6.x));
					    u_xlat6.x = (-u_xlat6.x) + u_xlat0.y;
					    u_xlatu6 = uint(u_xlat6.x);
					    u_xlat6.x = float(u_xlatu6);
					    u_xlat9 = (u_xlatb9) ? u_xlat1.x : (-u_xlat1.x);
					    u_xlat9 = u_xlat0.x * u_xlat9;
					    u_xlat0.xy = vec2(1.0, 1.0) / u_xlat0.xy;
					    u_xlatu9 = uint(u_xlat9);
					    u_xlat6.y = float(u_xlatu9);
					    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD0.yx;
					    u_xlat1.xy = u_xlat0.xy * u_xlat6.yx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    u_xlat0 = u_xlat16_0 * _Color;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Power, _Power, _Power));
					    SV_Target0.w = u_xlat0.w;
					    u_xlat16_2.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat16_11 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_11 = max(u_xlat16_11, 0.0);
					    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz;
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
					uniform 	vec4 _Color;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Step;
					uniform 	float _Power;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					vec2 u_xlat1;
					mediump vec3 u_xlat16_2;
					vec2 u_xlat6;
					uint u_xlatu6;
					float u_xlat9;
					uint u_xlatu9;
					bool u_xlatb9;
					mediump float u_xlat16_11;
					void main()
					{
					    u_xlat0.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat6.x = _Step / u_xlat0.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(u_xlat6.x>=(-u_xlat6.x));
					#else
					    u_xlatb9 = u_xlat6.x>=(-u_xlat6.x);
					#endif
					    u_xlat1.x = fract(abs(u_xlat6.x));
					    u_xlat6.x = (-u_xlat6.x) + u_xlat0.y;
					    u_xlatu6 = uint(u_xlat6.x);
					    u_xlat6.x = float(u_xlatu6);
					    u_xlat9 = (u_xlatb9) ? u_xlat1.x : (-u_xlat1.x);
					    u_xlat9 = u_xlat0.x * u_xlat9;
					    u_xlat0.xy = vec2(1.0, 1.0) / u_xlat0.xy;
					    u_xlatu9 = uint(u_xlat9);
					    u_xlat6.y = float(u_xlatu9);
					    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD0.yx;
					    u_xlat1.xy = u_xlat0.xy * u_xlat6.yx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    u_xlat0 = u_xlat16_0 * _Color;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Power, _Power, _Power));
					    SV_Target0.w = u_xlat0.w;
					    u_xlat16_2.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat16_11 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_11 = max(u_xlat16_11, 0.0);
					    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz;
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
					uniform highp vec4 _Color;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Step;
					uniform highp float _Power;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp float atten_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 tmpvar_5;
					  lowp float tmpvar_6;
					  lowp vec3 lightDir_7;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_7 = tmpvar_8;
					  tmpvar_4 = vec3(0.0, 0.0, 0.0);
					  tmpvar_6 = 0.0;
					  tmpvar_5 = xlv_TEXCOORD1;
					  lowp vec3 tmpvar_9;
					  lowp float tmpvar_10;
					  tmpvar_9 = tmpvar_4;
					  tmpvar_10 = tmpvar_6;
					  lowp vec4 c_11;
					  highp vec2 spriteUV_12;
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = float(_XFrames);
					  tmpvar_13 = (1.0/(tmpvar_14));
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0/(float(_YFrames)));
					  spriteUV_12 = xlv_TEXCOORD0;
					  highp float tmpvar_16;
					  tmpvar_16 = (_Step / tmpvar_14);
					  highp float tmpvar_17;
					  tmpvar_17 = (fract(abs(tmpvar_16)) * tmpvar_14);
					  highp float tmpvar_18;
					  if ((tmpvar_16 >= 0.0)) {
					    tmpvar_18 = tmpvar_17;
					  } else {
					    tmpvar_18 = -(tmpvar_17);
					  };
					  spriteUV_12.x = ((xlv_TEXCOORD0.x + float(
					    int(tmpvar_18)
					  )) * tmpvar_13);
					  spriteUV_12.y = ((xlv_TEXCOORD0.y + float(
					    int((float(_YFrames) - (_Step / float(_XFrames))))
					  )) * tmpvar_15);
					  lowp vec4 tmpvar_19;
					  tmpvar_19 = texture2D (_MainTex, spriteUV_12);
					  highp vec4 tmpvar_20;
					  tmpvar_20 = ((tmpvar_19 * xlv_COLOR0) * _Color);
					  c_11 = tmpvar_20;
					  tmpvar_9 = (c_11.xyz * _Power);
					  tmpvar_10 = c_11.w;
					  tmpvar_4 = tmpvar_9;
					  tmpvar_6 = tmpvar_10;
					  highp vec4 tmpvar_21;
					  tmpvar_21.w = 1.0;
					  tmpvar_21.xyz = xlv_TEXCOORD2;
					  highp vec4 tmpvar_22;
					  tmpvar_22 = (unity_WorldToLight * tmpvar_21);
					  lowp vec4 tmpvar_23;
					  highp vec2 P_24;
					  P_24 = ((tmpvar_22.xy / tmpvar_22.w) + 0.5);
					  tmpvar_23 = texture2D (_LightTexture0, P_24);
					  highp float tmpvar_25;
					  tmpvar_25 = dot (tmpvar_22.xyz, tmpvar_22.xyz);
					  lowp vec4 tmpvar_26;
					  tmpvar_26 = texture2D (_LightTextureB0, vec2(tmpvar_25));
					  highp float tmpvar_27;
					  tmpvar_27 = ((float(
					    (tmpvar_22.z > 0.0)
					  ) * tmpvar_23.w) * tmpvar_26.w);
					  atten_3 = tmpvar_27;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_7;
					  tmpvar_1 = (tmpvar_1 * atten_3);
					  lowp vec4 c_28;
					  lowp vec4 c_29;
					  lowp float diff_30;
					  mediump float tmpvar_31;
					  tmpvar_31 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_30 = tmpvar_31;
					  c_29.xyz = ((tmpvar_9 * tmpvar_1) * diff_30);
					  c_29.w = tmpvar_10;
					  c_28.w = c_29.w;
					  c_28.xyz = c_29.xyz;
					  gl_FragData[0] = c_28;
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
					uniform highp vec4 _Color;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Step;
					uniform highp float _Power;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp float atten_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 tmpvar_5;
					  lowp float tmpvar_6;
					  lowp vec3 lightDir_7;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_7 = tmpvar_8;
					  tmpvar_4 = vec3(0.0, 0.0, 0.0);
					  tmpvar_6 = 0.0;
					  tmpvar_5 = xlv_TEXCOORD1;
					  lowp vec3 tmpvar_9;
					  lowp float tmpvar_10;
					  tmpvar_9 = tmpvar_4;
					  tmpvar_10 = tmpvar_6;
					  lowp vec4 c_11;
					  highp vec2 spriteUV_12;
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = float(_XFrames);
					  tmpvar_13 = (1.0/(tmpvar_14));
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0/(float(_YFrames)));
					  spriteUV_12 = xlv_TEXCOORD0;
					  highp float tmpvar_16;
					  tmpvar_16 = (_Step / tmpvar_14);
					  highp float tmpvar_17;
					  tmpvar_17 = (fract(abs(tmpvar_16)) * tmpvar_14);
					  highp float tmpvar_18;
					  if ((tmpvar_16 >= 0.0)) {
					    tmpvar_18 = tmpvar_17;
					  } else {
					    tmpvar_18 = -(tmpvar_17);
					  };
					  spriteUV_12.x = ((xlv_TEXCOORD0.x + float(
					    int(tmpvar_18)
					  )) * tmpvar_13);
					  spriteUV_12.y = ((xlv_TEXCOORD0.y + float(
					    int((float(_YFrames) - (_Step / float(_XFrames))))
					  )) * tmpvar_15);
					  lowp vec4 tmpvar_19;
					  tmpvar_19 = texture2D (_MainTex, spriteUV_12);
					  highp vec4 tmpvar_20;
					  tmpvar_20 = ((tmpvar_19 * xlv_COLOR0) * _Color);
					  c_11 = tmpvar_20;
					  tmpvar_9 = (c_11.xyz * _Power);
					  tmpvar_10 = c_11.w;
					  tmpvar_4 = tmpvar_9;
					  tmpvar_6 = tmpvar_10;
					  highp vec4 tmpvar_21;
					  tmpvar_21.w = 1.0;
					  tmpvar_21.xyz = xlv_TEXCOORD2;
					  highp vec4 tmpvar_22;
					  tmpvar_22 = (unity_WorldToLight * tmpvar_21);
					  lowp vec4 tmpvar_23;
					  highp vec2 P_24;
					  P_24 = ((tmpvar_22.xy / tmpvar_22.w) + 0.5);
					  tmpvar_23 = texture2D (_LightTexture0, P_24);
					  highp float tmpvar_25;
					  tmpvar_25 = dot (tmpvar_22.xyz, tmpvar_22.xyz);
					  lowp vec4 tmpvar_26;
					  tmpvar_26 = texture2D (_LightTextureB0, vec2(tmpvar_25));
					  highp float tmpvar_27;
					  tmpvar_27 = ((float(
					    (tmpvar_22.z > 0.0)
					  ) * tmpvar_23.w) * tmpvar_26.w);
					  atten_3 = tmpvar_27;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_7;
					  tmpvar_1 = (tmpvar_1 * atten_3);
					  lowp vec4 c_28;
					  lowp vec4 c_29;
					  lowp float diff_30;
					  mediump float tmpvar_31;
					  tmpvar_31 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_30 = tmpvar_31;
					  c_29.xyz = ((tmpvar_9 * tmpvar_1) * diff_30);
					  c_29.w = tmpvar_10;
					  c_28.w = c_29.w;
					  c_28.xyz = c_29.xyz;
					  gl_FragData[0] = c_28;
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
					uniform highp vec4 _Color;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Step;
					uniform highp float _Power;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp float atten_3;
					  lowp vec3 tmpvar_4;
					  lowp vec3 tmpvar_5;
					  lowp float tmpvar_6;
					  lowp vec3 lightDir_7;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_7 = tmpvar_8;
					  tmpvar_4 = vec3(0.0, 0.0, 0.0);
					  tmpvar_6 = 0.0;
					  tmpvar_5 = xlv_TEXCOORD1;
					  lowp vec3 tmpvar_9;
					  lowp float tmpvar_10;
					  tmpvar_9 = tmpvar_4;
					  tmpvar_10 = tmpvar_6;
					  lowp vec4 c_11;
					  highp vec2 spriteUV_12;
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = float(_XFrames);
					  tmpvar_13 = (1.0/(tmpvar_14));
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0/(float(_YFrames)));
					  spriteUV_12 = xlv_TEXCOORD0;
					  highp float tmpvar_16;
					  tmpvar_16 = (_Step / tmpvar_14);
					  highp float tmpvar_17;
					  tmpvar_17 = (fract(abs(tmpvar_16)) * tmpvar_14);
					  highp float tmpvar_18;
					  if ((tmpvar_16 >= 0.0)) {
					    tmpvar_18 = tmpvar_17;
					  } else {
					    tmpvar_18 = -(tmpvar_17);
					  };
					  spriteUV_12.x = ((xlv_TEXCOORD0.x + float(
					    int(tmpvar_18)
					  )) * tmpvar_13);
					  spriteUV_12.y = ((xlv_TEXCOORD0.y + float(
					    int((float(_YFrames) - (_Step / float(_XFrames))))
					  )) * tmpvar_15);
					  lowp vec4 tmpvar_19;
					  tmpvar_19 = texture2D (_MainTex, spriteUV_12);
					  highp vec4 tmpvar_20;
					  tmpvar_20 = ((tmpvar_19 * xlv_COLOR0) * _Color);
					  c_11 = tmpvar_20;
					  tmpvar_9 = (c_11.xyz * _Power);
					  tmpvar_10 = c_11.w;
					  tmpvar_4 = tmpvar_9;
					  tmpvar_6 = tmpvar_10;
					  highp vec4 tmpvar_21;
					  tmpvar_21.w = 1.0;
					  tmpvar_21.xyz = xlv_TEXCOORD2;
					  highp vec4 tmpvar_22;
					  tmpvar_22 = (unity_WorldToLight * tmpvar_21);
					  lowp vec4 tmpvar_23;
					  highp vec2 P_24;
					  P_24 = ((tmpvar_22.xy / tmpvar_22.w) + 0.5);
					  tmpvar_23 = texture2D (_LightTexture0, P_24);
					  highp float tmpvar_25;
					  tmpvar_25 = dot (tmpvar_22.xyz, tmpvar_22.xyz);
					  lowp vec4 tmpvar_26;
					  tmpvar_26 = texture2D (_LightTextureB0, vec2(tmpvar_25));
					  highp float tmpvar_27;
					  tmpvar_27 = ((float(
					    (tmpvar_22.z > 0.0)
					  ) * tmpvar_23.w) * tmpvar_26.w);
					  atten_3 = tmpvar_27;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_7;
					  tmpvar_1 = (tmpvar_1 * atten_3);
					  lowp vec4 c_28;
					  lowp vec4 c_29;
					  lowp float diff_30;
					  mediump float tmpvar_31;
					  tmpvar_31 = max (0.0, dot (tmpvar_5, tmpvar_2));
					  diff_30 = tmpvar_31;
					  c_29.xyz = ((tmpvar_9 * tmpvar_1) * diff_30);
					  c_29.w = tmpvar_10;
					  c_28.w = c_29.w;
					  c_28.xyz = c_29.xyz;
					  gl_FragData[0] = c_28;
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
					uniform 	vec4 _Color;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Step;
					uniform 	float _Power;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _LightTexture0;
					uniform lowp sampler2D _LightTextureB0;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					vec2 u_xlat1;
					bool u_xlatb1;
					lowp float u_xlat10_2;
					mediump vec3 u_xlat16_3;
					vec2 u_xlat8;
					uint u_xlatu8;
					float u_xlat12;
					lowp float u_xlat10_12;
					uint u_xlatu12;
					bool u_xlatb12;
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
					    u_xlat10_0.x = texture(_LightTextureB0, u_xlat0.xx).w;
					    u_xlat10_2 = (u_xlatb1) ? 1.0 : 0.0;
					    u_xlat10_2 = u_xlat10_12 * u_xlat10_2;
					    u_xlat10_2 = u_xlat10_0.x * u_xlat10_2;
					    u_xlat16_3.xyz = vec3(u_xlat10_2) * _LightColor0.xyz;
					    u_xlat0.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat8.x = _Step / u_xlat0.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb12 = !!(u_xlat8.x>=(-u_xlat8.x));
					#else
					    u_xlatb12 = u_xlat8.x>=(-u_xlat8.x);
					#endif
					    u_xlat1.x = fract(abs(u_xlat8.x));
					    u_xlat8.x = (-u_xlat8.x) + u_xlat0.y;
					    u_xlatu8 = uint(u_xlat8.x);
					    u_xlat8.x = float(u_xlatu8);
					    u_xlat12 = (u_xlatb12) ? u_xlat1.x : (-u_xlat1.x);
					    u_xlat12 = u_xlat0.x * u_xlat12;
					    u_xlat0.xy = vec2(1.0, 1.0) / u_xlat0.xy;
					    u_xlatu12 = uint(u_xlat12);
					    u_xlat8.y = float(u_xlatu12);
					    u_xlat8.xy = u_xlat8.xy + vs_TEXCOORD0.yx;
					    u_xlat1.xy = u_xlat0.xy * u_xlat8.yx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    u_xlat0 = u_xlat16_0 * _Color;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Power, _Power, _Power));
					    SV_Target0.w = u_xlat0.w;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat0.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat16_15 = max(u_xlat16_15, 0.0);
					    u_xlat16_3.xyz = vec3(u_xlat16_15) * u_xlat16_3.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
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
					uniform 	vec4 _Color;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Step;
					uniform 	float _Power;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _LightTexture0;
					uniform lowp sampler2D _LightTextureB0;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					vec2 u_xlat1;
					bool u_xlatb1;
					lowp float u_xlat10_2;
					mediump vec3 u_xlat16_3;
					vec2 u_xlat8;
					uint u_xlatu8;
					float u_xlat12;
					lowp float u_xlat10_12;
					uint u_xlatu12;
					bool u_xlatb12;
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
					    u_xlat10_0.x = texture(_LightTextureB0, u_xlat0.xx).w;
					    u_xlat10_2 = (u_xlatb1) ? 1.0 : 0.0;
					    u_xlat10_2 = u_xlat10_12 * u_xlat10_2;
					    u_xlat10_2 = u_xlat10_0.x * u_xlat10_2;
					    u_xlat16_3.xyz = vec3(u_xlat10_2) * _LightColor0.xyz;
					    u_xlat0.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat8.x = _Step / u_xlat0.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb12 = !!(u_xlat8.x>=(-u_xlat8.x));
					#else
					    u_xlatb12 = u_xlat8.x>=(-u_xlat8.x);
					#endif
					    u_xlat1.x = fract(abs(u_xlat8.x));
					    u_xlat8.x = (-u_xlat8.x) + u_xlat0.y;
					    u_xlatu8 = uint(u_xlat8.x);
					    u_xlat8.x = float(u_xlatu8);
					    u_xlat12 = (u_xlatb12) ? u_xlat1.x : (-u_xlat1.x);
					    u_xlat12 = u_xlat0.x * u_xlat12;
					    u_xlat0.xy = vec2(1.0, 1.0) / u_xlat0.xy;
					    u_xlatu12 = uint(u_xlat12);
					    u_xlat8.y = float(u_xlatu12);
					    u_xlat8.xy = u_xlat8.xy + vs_TEXCOORD0.yx;
					    u_xlat1.xy = u_xlat0.xy * u_xlat8.yx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    u_xlat0 = u_xlat16_0 * _Color;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Power, _Power, _Power));
					    SV_Target0.w = u_xlat0.w;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat0.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat16_15 = max(u_xlat16_15, 0.0);
					    u_xlat16_3.xyz = vec3(u_xlat16_15) * u_xlat16_3.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
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
					uniform 	vec4 _Color;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Step;
					uniform 	float _Power;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _LightTexture0;
					uniform lowp sampler2D _LightTextureB0;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					vec2 u_xlat1;
					bool u_xlatb1;
					lowp float u_xlat10_2;
					mediump vec3 u_xlat16_3;
					vec2 u_xlat8;
					uint u_xlatu8;
					float u_xlat12;
					lowp float u_xlat10_12;
					uint u_xlatu12;
					bool u_xlatb12;
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
					    u_xlat10_0.x = texture(_LightTextureB0, u_xlat0.xx).w;
					    u_xlat10_2 = (u_xlatb1) ? 1.0 : 0.0;
					    u_xlat10_2 = u_xlat10_12 * u_xlat10_2;
					    u_xlat10_2 = u_xlat10_0.x * u_xlat10_2;
					    u_xlat16_3.xyz = vec3(u_xlat10_2) * _LightColor0.xyz;
					    u_xlat0.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat8.x = _Step / u_xlat0.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb12 = !!(u_xlat8.x>=(-u_xlat8.x));
					#else
					    u_xlatb12 = u_xlat8.x>=(-u_xlat8.x);
					#endif
					    u_xlat1.x = fract(abs(u_xlat8.x));
					    u_xlat8.x = (-u_xlat8.x) + u_xlat0.y;
					    u_xlatu8 = uint(u_xlat8.x);
					    u_xlat8.x = float(u_xlatu8);
					    u_xlat12 = (u_xlatb12) ? u_xlat1.x : (-u_xlat1.x);
					    u_xlat12 = u_xlat0.x * u_xlat12;
					    u_xlat0.xy = vec2(1.0, 1.0) / u_xlat0.xy;
					    u_xlatu12 = uint(u_xlat12);
					    u_xlat8.y = float(u_xlatu12);
					    u_xlat8.xy = u_xlat8.xy + vs_TEXCOORD0.yx;
					    u_xlat1.xy = u_xlat0.xy * u_xlat8.yx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    u_xlat0 = u_xlat16_0 * _Color;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Power, _Power, _Power));
					    SV_Target0.w = u_xlat0.w;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat0.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat16_15 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat16_15 = max(u_xlat16_15, 0.0);
					    u_xlat16_3.xyz = vec3(u_xlat16_15) * u_xlat16_3.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz;
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
					uniform highp vec4 _Color;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Step;
					uniform highp float _Power;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  lowp float tmpvar_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_6 = tmpvar_7;
					  tmpvar_3 = vec3(0.0, 0.0, 0.0);
					  tmpvar_5 = 0.0;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec3 tmpvar_8;
					  lowp float tmpvar_9;
					  tmpvar_8 = tmpvar_3;
					  tmpvar_9 = tmpvar_5;
					  lowp vec4 c_10;
					  highp vec2 spriteUV_11;
					  highp float tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = float(_XFrames);
					  tmpvar_12 = (1.0/(tmpvar_13));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(float(_YFrames)));
					  spriteUV_11 = xlv_TEXCOORD0;
					  highp float tmpvar_15;
					  tmpvar_15 = (_Step / tmpvar_13);
					  highp float tmpvar_16;
					  tmpvar_16 = (fract(abs(tmpvar_15)) * tmpvar_13);
					  highp float tmpvar_17;
					  if ((tmpvar_15 >= 0.0)) {
					    tmpvar_17 = tmpvar_16;
					  } else {
					    tmpvar_17 = -(tmpvar_16);
					  };
					  spriteUV_11.x = ((xlv_TEXCOORD0.x + float(
					    int(tmpvar_17)
					  )) * tmpvar_12);
					  spriteUV_11.y = ((xlv_TEXCOORD0.y + float(
					    int((float(_YFrames) - (_Step / float(_XFrames))))
					  )) * tmpvar_14);
					  lowp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_MainTex, spriteUV_11);
					  highp vec4 tmpvar_19;
					  tmpvar_19 = ((tmpvar_18 * xlv_COLOR0) * _Color);
					  c_10 = tmpvar_19;
					  tmpvar_8 = (c_10.xyz * _Power);
					  tmpvar_9 = c_10.w;
					  tmpvar_3 = tmpvar_8;
					  tmpvar_5 = tmpvar_9;
					  highp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = xlv_TEXCOORD2;
					  highp vec3 tmpvar_21;
					  tmpvar_21 = (unity_WorldToLight * tmpvar_20).xyz;
					  highp float tmpvar_22;
					  tmpvar_22 = dot (tmpvar_21, tmpvar_21);
					  lowp float tmpvar_23;
					  tmpvar_23 = (texture2D (_LightTextureB0, vec2(tmpvar_22)).w * textureCube (_LightTexture0, tmpvar_21).w);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_23);
					  lowp vec4 c_24;
					  lowp vec4 c_25;
					  lowp float diff_26;
					  mediump float tmpvar_27;
					  tmpvar_27 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_26 = tmpvar_27;
					  c_25.xyz = ((tmpvar_8 * tmpvar_1) * diff_26);
					  c_25.w = tmpvar_9;
					  c_24.w = c_25.w;
					  c_24.xyz = c_25.xyz;
					  gl_FragData[0] = c_24;
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
					uniform highp vec4 _Color;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Step;
					uniform highp float _Power;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  lowp float tmpvar_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_6 = tmpvar_7;
					  tmpvar_3 = vec3(0.0, 0.0, 0.0);
					  tmpvar_5 = 0.0;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec3 tmpvar_8;
					  lowp float tmpvar_9;
					  tmpvar_8 = tmpvar_3;
					  tmpvar_9 = tmpvar_5;
					  lowp vec4 c_10;
					  highp vec2 spriteUV_11;
					  highp float tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = float(_XFrames);
					  tmpvar_12 = (1.0/(tmpvar_13));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(float(_YFrames)));
					  spriteUV_11 = xlv_TEXCOORD0;
					  highp float tmpvar_15;
					  tmpvar_15 = (_Step / tmpvar_13);
					  highp float tmpvar_16;
					  tmpvar_16 = (fract(abs(tmpvar_15)) * tmpvar_13);
					  highp float tmpvar_17;
					  if ((tmpvar_15 >= 0.0)) {
					    tmpvar_17 = tmpvar_16;
					  } else {
					    tmpvar_17 = -(tmpvar_16);
					  };
					  spriteUV_11.x = ((xlv_TEXCOORD0.x + float(
					    int(tmpvar_17)
					  )) * tmpvar_12);
					  spriteUV_11.y = ((xlv_TEXCOORD0.y + float(
					    int((float(_YFrames) - (_Step / float(_XFrames))))
					  )) * tmpvar_14);
					  lowp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_MainTex, spriteUV_11);
					  highp vec4 tmpvar_19;
					  tmpvar_19 = ((tmpvar_18 * xlv_COLOR0) * _Color);
					  c_10 = tmpvar_19;
					  tmpvar_8 = (c_10.xyz * _Power);
					  tmpvar_9 = c_10.w;
					  tmpvar_3 = tmpvar_8;
					  tmpvar_5 = tmpvar_9;
					  highp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = xlv_TEXCOORD2;
					  highp vec3 tmpvar_21;
					  tmpvar_21 = (unity_WorldToLight * tmpvar_20).xyz;
					  highp float tmpvar_22;
					  tmpvar_22 = dot (tmpvar_21, tmpvar_21);
					  lowp float tmpvar_23;
					  tmpvar_23 = (texture2D (_LightTextureB0, vec2(tmpvar_22)).w * textureCube (_LightTexture0, tmpvar_21).w);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_23);
					  lowp vec4 c_24;
					  lowp vec4 c_25;
					  lowp float diff_26;
					  mediump float tmpvar_27;
					  tmpvar_27 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_26 = tmpvar_27;
					  c_25.xyz = ((tmpvar_8 * tmpvar_1) * diff_26);
					  c_25.w = tmpvar_9;
					  c_24.w = c_25.w;
					  c_24.xyz = c_25.xyz;
					  gl_FragData[0] = c_24;
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
					uniform highp vec4 _Color;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Step;
					uniform highp float _Power;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  lowp float tmpvar_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
					  lightDir_6 = tmpvar_7;
					  tmpvar_3 = vec3(0.0, 0.0, 0.0);
					  tmpvar_5 = 0.0;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec3 tmpvar_8;
					  lowp float tmpvar_9;
					  tmpvar_8 = tmpvar_3;
					  tmpvar_9 = tmpvar_5;
					  lowp vec4 c_10;
					  highp vec2 spriteUV_11;
					  highp float tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = float(_XFrames);
					  tmpvar_12 = (1.0/(tmpvar_13));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(float(_YFrames)));
					  spriteUV_11 = xlv_TEXCOORD0;
					  highp float tmpvar_15;
					  tmpvar_15 = (_Step / tmpvar_13);
					  highp float tmpvar_16;
					  tmpvar_16 = (fract(abs(tmpvar_15)) * tmpvar_13);
					  highp float tmpvar_17;
					  if ((tmpvar_15 >= 0.0)) {
					    tmpvar_17 = tmpvar_16;
					  } else {
					    tmpvar_17 = -(tmpvar_16);
					  };
					  spriteUV_11.x = ((xlv_TEXCOORD0.x + float(
					    int(tmpvar_17)
					  )) * tmpvar_12);
					  spriteUV_11.y = ((xlv_TEXCOORD0.y + float(
					    int((float(_YFrames) - (_Step / float(_XFrames))))
					  )) * tmpvar_14);
					  lowp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_MainTex, spriteUV_11);
					  highp vec4 tmpvar_19;
					  tmpvar_19 = ((tmpvar_18 * xlv_COLOR0) * _Color);
					  c_10 = tmpvar_19;
					  tmpvar_8 = (c_10.xyz * _Power);
					  tmpvar_9 = c_10.w;
					  tmpvar_3 = tmpvar_8;
					  tmpvar_5 = tmpvar_9;
					  highp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = xlv_TEXCOORD2;
					  highp vec3 tmpvar_21;
					  tmpvar_21 = (unity_WorldToLight * tmpvar_20).xyz;
					  highp float tmpvar_22;
					  tmpvar_22 = dot (tmpvar_21, tmpvar_21);
					  lowp float tmpvar_23;
					  tmpvar_23 = (texture2D (_LightTextureB0, vec2(tmpvar_22)).w * textureCube (_LightTexture0, tmpvar_21).w);
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_23);
					  lowp vec4 c_24;
					  lowp vec4 c_25;
					  lowp float diff_26;
					  mediump float tmpvar_27;
					  tmpvar_27 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_26 = tmpvar_27;
					  c_25.xyz = ((tmpvar_8 * tmpvar_1) * diff_26);
					  c_25.w = tmpvar_9;
					  c_24.w = c_25.w;
					  c_24.xyz = c_25.xyz;
					  gl_FragData[0] = c_24;
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
					uniform 	vec4 _Color;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Step;
					uniform 	float _Power;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _LightTextureB0;
					uniform lowp samplerCube _LightTexture0;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					mediump vec3 u_xlat16_2;
					vec2 u_xlat6;
					uint u_xlatu6;
					float u_xlat9;
					mediump float u_xlat16_9;
					lowp float u_xlat10_9;
					uint u_xlatu9;
					bool u_xlatb9;
					mediump float u_xlat16_11;
					void main()
					{
					    u_xlat0.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat6.x = _Step / u_xlat0.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(u_xlat6.x>=(-u_xlat6.x));
					#else
					    u_xlatb9 = u_xlat6.x>=(-u_xlat6.x);
					#endif
					    u_xlat1.x = fract(abs(u_xlat6.x));
					    u_xlat6.x = (-u_xlat6.x) + u_xlat0.y;
					    u_xlatu6 = uint(u_xlat6.x);
					    u_xlat6.x = float(u_xlatu6);
					    u_xlat9 = (u_xlatb9) ? u_xlat1.x : (-u_xlat1.x);
					    u_xlat9 = u_xlat0.x * u_xlat9;
					    u_xlat0.xy = vec2(1.0, 1.0) / u_xlat0.xy;
					    u_xlatu9 = uint(u_xlat9);
					    u_xlat6.y = float(u_xlatu9);
					    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD0.yx;
					    u_xlat1.xy = u_xlat0.xy * u_xlat6.yx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    u_xlat0 = u_xlat16_0 * _Color;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Power, _Power, _Power));
					    SV_Target0.w = u_xlat0.w;
					    u_xlat1.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_WorldToLight[3].xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10_1 = texture(_LightTexture0, u_xlat1.xyz).w;
					    u_xlat10_9 = texture(_LightTextureB0, vec2(u_xlat9)).w;
					    u_xlat16_9 = u_xlat10_1 * u_xlat10_9;
					    u_xlat16_2.xyz = vec3(u_xlat16_9) * _LightColor0.xyz;
					    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat16_11 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat16_11 = max(u_xlat16_11, 0.0);
					    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz;
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
					uniform 	vec4 _Color;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Step;
					uniform 	float _Power;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _LightTextureB0;
					uniform lowp samplerCube _LightTexture0;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					mediump vec3 u_xlat16_2;
					vec2 u_xlat6;
					uint u_xlatu6;
					float u_xlat9;
					mediump float u_xlat16_9;
					lowp float u_xlat10_9;
					uint u_xlatu9;
					bool u_xlatb9;
					mediump float u_xlat16_11;
					void main()
					{
					    u_xlat0.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat6.x = _Step / u_xlat0.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(u_xlat6.x>=(-u_xlat6.x));
					#else
					    u_xlatb9 = u_xlat6.x>=(-u_xlat6.x);
					#endif
					    u_xlat1.x = fract(abs(u_xlat6.x));
					    u_xlat6.x = (-u_xlat6.x) + u_xlat0.y;
					    u_xlatu6 = uint(u_xlat6.x);
					    u_xlat6.x = float(u_xlatu6);
					    u_xlat9 = (u_xlatb9) ? u_xlat1.x : (-u_xlat1.x);
					    u_xlat9 = u_xlat0.x * u_xlat9;
					    u_xlat0.xy = vec2(1.0, 1.0) / u_xlat0.xy;
					    u_xlatu9 = uint(u_xlat9);
					    u_xlat6.y = float(u_xlatu9);
					    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD0.yx;
					    u_xlat1.xy = u_xlat0.xy * u_xlat6.yx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    u_xlat0 = u_xlat16_0 * _Color;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Power, _Power, _Power));
					    SV_Target0.w = u_xlat0.w;
					    u_xlat1.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_WorldToLight[3].xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10_1 = texture(_LightTexture0, u_xlat1.xyz).w;
					    u_xlat10_9 = texture(_LightTextureB0, vec2(u_xlat9)).w;
					    u_xlat16_9 = u_xlat10_1 * u_xlat10_9;
					    u_xlat16_2.xyz = vec3(u_xlat16_9) * _LightColor0.xyz;
					    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat16_11 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat16_11 = max(u_xlat16_11, 0.0);
					    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz;
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
					uniform 	vec4 _Color;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Step;
					uniform 	float _Power;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _LightTextureB0;
					uniform lowp samplerCube _LightTexture0;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					mediump vec3 u_xlat16_2;
					vec2 u_xlat6;
					uint u_xlatu6;
					float u_xlat9;
					mediump float u_xlat16_9;
					lowp float u_xlat10_9;
					uint u_xlatu9;
					bool u_xlatb9;
					mediump float u_xlat16_11;
					void main()
					{
					    u_xlat0.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat6.x = _Step / u_xlat0.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(u_xlat6.x>=(-u_xlat6.x));
					#else
					    u_xlatb9 = u_xlat6.x>=(-u_xlat6.x);
					#endif
					    u_xlat1.x = fract(abs(u_xlat6.x));
					    u_xlat6.x = (-u_xlat6.x) + u_xlat0.y;
					    u_xlatu6 = uint(u_xlat6.x);
					    u_xlat6.x = float(u_xlatu6);
					    u_xlat9 = (u_xlatb9) ? u_xlat1.x : (-u_xlat1.x);
					    u_xlat9 = u_xlat0.x * u_xlat9;
					    u_xlat0.xy = vec2(1.0, 1.0) / u_xlat0.xy;
					    u_xlatu9 = uint(u_xlat9);
					    u_xlat6.y = float(u_xlatu9);
					    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD0.yx;
					    u_xlat1.xy = u_xlat0.xy * u_xlat6.yx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    u_xlat0 = u_xlat16_0 * _Color;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Power, _Power, _Power));
					    SV_Target0.w = u_xlat0.w;
					    u_xlat1.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_WorldToLight[3].xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10_1 = texture(_LightTexture0, u_xlat1.xyz).w;
					    u_xlat10_9 = texture(_LightTextureB0, vec2(u_xlat9)).w;
					    u_xlat16_9 = u_xlat10_1 * u_xlat10_9;
					    u_xlat16_2.xyz = vec3(u_xlat16_9) * _LightColor0.xyz;
					    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat16_11 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat16_11 = max(u_xlat16_11, 0.0);
					    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz;
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
					uniform highp vec4 _Color;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Step;
					uniform highp float _Power;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  lowp float tmpvar_5;
					  lowp vec3 lightDir_6;
					  mediump vec3 tmpvar_7;
					  tmpvar_7 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_7;
					  tmpvar_3 = vec3(0.0, 0.0, 0.0);
					  tmpvar_5 = 0.0;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec3 tmpvar_8;
					  lowp float tmpvar_9;
					  tmpvar_8 = tmpvar_3;
					  tmpvar_9 = tmpvar_5;
					  lowp vec4 c_10;
					  highp vec2 spriteUV_11;
					  highp float tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = float(_XFrames);
					  tmpvar_12 = (1.0/(tmpvar_13));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(float(_YFrames)));
					  spriteUV_11 = xlv_TEXCOORD0;
					  highp float tmpvar_15;
					  tmpvar_15 = (_Step / tmpvar_13);
					  highp float tmpvar_16;
					  tmpvar_16 = (fract(abs(tmpvar_15)) * tmpvar_13);
					  highp float tmpvar_17;
					  if ((tmpvar_15 >= 0.0)) {
					    tmpvar_17 = tmpvar_16;
					  } else {
					    tmpvar_17 = -(tmpvar_16);
					  };
					  spriteUV_11.x = ((xlv_TEXCOORD0.x + float(
					    int(tmpvar_17)
					  )) * tmpvar_12);
					  spriteUV_11.y = ((xlv_TEXCOORD0.y + float(
					    int((float(_YFrames) - (_Step / float(_XFrames))))
					  )) * tmpvar_14);
					  lowp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_MainTex, spriteUV_11);
					  highp vec4 tmpvar_19;
					  tmpvar_19 = ((tmpvar_18 * xlv_COLOR0) * _Color);
					  c_10 = tmpvar_19;
					  tmpvar_8 = (c_10.xyz * _Power);
					  tmpvar_9 = c_10.w;
					  tmpvar_3 = tmpvar_8;
					  tmpvar_5 = tmpvar_9;
					  highp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = xlv_TEXCOORD2;
					  highp vec2 tmpvar_21;
					  tmpvar_21 = (unity_WorldToLight * tmpvar_20).xy;
					  lowp float tmpvar_22;
					  tmpvar_22 = texture2D (_LightTexture0, tmpvar_21).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_22);
					  lowp vec4 c_23;
					  lowp vec4 c_24;
					  lowp float diff_25;
					  mediump float tmpvar_26;
					  tmpvar_26 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_25 = tmpvar_26;
					  c_24.xyz = ((tmpvar_8 * tmpvar_1) * diff_25);
					  c_24.w = tmpvar_9;
					  c_23.w = c_24.w;
					  c_23.xyz = c_24.xyz;
					  gl_FragData[0] = c_23;
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
					uniform highp vec4 _Color;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Step;
					uniform highp float _Power;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  lowp float tmpvar_5;
					  lowp vec3 lightDir_6;
					  mediump vec3 tmpvar_7;
					  tmpvar_7 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_7;
					  tmpvar_3 = vec3(0.0, 0.0, 0.0);
					  tmpvar_5 = 0.0;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec3 tmpvar_8;
					  lowp float tmpvar_9;
					  tmpvar_8 = tmpvar_3;
					  tmpvar_9 = tmpvar_5;
					  lowp vec4 c_10;
					  highp vec2 spriteUV_11;
					  highp float tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = float(_XFrames);
					  tmpvar_12 = (1.0/(tmpvar_13));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(float(_YFrames)));
					  spriteUV_11 = xlv_TEXCOORD0;
					  highp float tmpvar_15;
					  tmpvar_15 = (_Step / tmpvar_13);
					  highp float tmpvar_16;
					  tmpvar_16 = (fract(abs(tmpvar_15)) * tmpvar_13);
					  highp float tmpvar_17;
					  if ((tmpvar_15 >= 0.0)) {
					    tmpvar_17 = tmpvar_16;
					  } else {
					    tmpvar_17 = -(tmpvar_16);
					  };
					  spriteUV_11.x = ((xlv_TEXCOORD0.x + float(
					    int(tmpvar_17)
					  )) * tmpvar_12);
					  spriteUV_11.y = ((xlv_TEXCOORD0.y + float(
					    int((float(_YFrames) - (_Step / float(_XFrames))))
					  )) * tmpvar_14);
					  lowp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_MainTex, spriteUV_11);
					  highp vec4 tmpvar_19;
					  tmpvar_19 = ((tmpvar_18 * xlv_COLOR0) * _Color);
					  c_10 = tmpvar_19;
					  tmpvar_8 = (c_10.xyz * _Power);
					  tmpvar_9 = c_10.w;
					  tmpvar_3 = tmpvar_8;
					  tmpvar_5 = tmpvar_9;
					  highp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = xlv_TEXCOORD2;
					  highp vec2 tmpvar_21;
					  tmpvar_21 = (unity_WorldToLight * tmpvar_20).xy;
					  lowp float tmpvar_22;
					  tmpvar_22 = texture2D (_LightTexture0, tmpvar_21).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_22);
					  lowp vec4 c_23;
					  lowp vec4 c_24;
					  lowp float diff_25;
					  mediump float tmpvar_26;
					  tmpvar_26 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_25 = tmpvar_26;
					  c_24.xyz = ((tmpvar_8 * tmpvar_1) * diff_25);
					  c_24.w = tmpvar_9;
					  c_23.w = c_24.w;
					  c_23.xyz = c_24.xyz;
					  gl_FragData[0] = c_23;
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
					uniform highp vec4 _Color;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Step;
					uniform highp float _Power;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  lowp float tmpvar_5;
					  lowp vec3 lightDir_6;
					  mediump vec3 tmpvar_7;
					  tmpvar_7 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_7;
					  tmpvar_3 = vec3(0.0, 0.0, 0.0);
					  tmpvar_5 = 0.0;
					  tmpvar_4 = xlv_TEXCOORD1;
					  lowp vec3 tmpvar_8;
					  lowp float tmpvar_9;
					  tmpvar_8 = tmpvar_3;
					  tmpvar_9 = tmpvar_5;
					  lowp vec4 c_10;
					  highp vec2 spriteUV_11;
					  highp float tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = float(_XFrames);
					  tmpvar_12 = (1.0/(tmpvar_13));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(float(_YFrames)));
					  spriteUV_11 = xlv_TEXCOORD0;
					  highp float tmpvar_15;
					  tmpvar_15 = (_Step / tmpvar_13);
					  highp float tmpvar_16;
					  tmpvar_16 = (fract(abs(tmpvar_15)) * tmpvar_13);
					  highp float tmpvar_17;
					  if ((tmpvar_15 >= 0.0)) {
					    tmpvar_17 = tmpvar_16;
					  } else {
					    tmpvar_17 = -(tmpvar_16);
					  };
					  spriteUV_11.x = ((xlv_TEXCOORD0.x + float(
					    int(tmpvar_17)
					  )) * tmpvar_12);
					  spriteUV_11.y = ((xlv_TEXCOORD0.y + float(
					    int((float(_YFrames) - (_Step / float(_XFrames))))
					  )) * tmpvar_14);
					  lowp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_MainTex, spriteUV_11);
					  highp vec4 tmpvar_19;
					  tmpvar_19 = ((tmpvar_18 * xlv_COLOR0) * _Color);
					  c_10 = tmpvar_19;
					  tmpvar_8 = (c_10.xyz * _Power);
					  tmpvar_9 = c_10.w;
					  tmpvar_3 = tmpvar_8;
					  tmpvar_5 = tmpvar_9;
					  highp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = xlv_TEXCOORD2;
					  highp vec2 tmpvar_21;
					  tmpvar_21 = (unity_WorldToLight * tmpvar_20).xy;
					  lowp float tmpvar_22;
					  tmpvar_22 = texture2D (_LightTexture0, tmpvar_21).w;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_22);
					  lowp vec4 c_23;
					  lowp vec4 c_24;
					  lowp float diff_25;
					  mediump float tmpvar_26;
					  tmpvar_26 = max (0.0, dot (tmpvar_4, tmpvar_2));
					  diff_25 = tmpvar_26;
					  c_24.xyz = ((tmpvar_8 * tmpvar_1) * diff_25);
					  c_24.w = tmpvar_9;
					  c_23.w = c_24.w;
					  c_23.xyz = c_24.xyz;
					  gl_FragData[0] = c_23;
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
					uniform 	vec4 _Color;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Step;
					uniform 	float _Power;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _LightTexture0;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					vec2 u_xlat1;
					mediump vec3 u_xlat16_2;
					vec2 u_xlat6;
					uint u_xlatu6;
					float u_xlat9;
					lowp float u_xlat10_9;
					uint u_xlatu9;
					bool u_xlatb9;
					mediump float u_xlat16_11;
					void main()
					{
					    u_xlat0.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat6.x = _Step / u_xlat0.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(u_xlat6.x>=(-u_xlat6.x));
					#else
					    u_xlatb9 = u_xlat6.x>=(-u_xlat6.x);
					#endif
					    u_xlat1.x = fract(abs(u_xlat6.x));
					    u_xlat6.x = (-u_xlat6.x) + u_xlat0.y;
					    u_xlatu6 = uint(u_xlat6.x);
					    u_xlat6.x = float(u_xlatu6);
					    u_xlat9 = (u_xlatb9) ? u_xlat1.x : (-u_xlat1.x);
					    u_xlat9 = u_xlat0.x * u_xlat9;
					    u_xlat0.xy = vec2(1.0, 1.0) / u_xlat0.xy;
					    u_xlatu9 = uint(u_xlat9);
					    u_xlat6.y = float(u_xlatu9);
					    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD0.yx;
					    u_xlat1.xy = u_xlat0.xy * u_xlat6.yx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    u_xlat0 = u_xlat16_0 * _Color;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Power, _Power, _Power));
					    SV_Target0.w = u_xlat0.w;
					    u_xlat1.xy = vs_TEXCOORD2.yy * hlslcc_mtx4unity_WorldToLight[1].xy;
					    u_xlat1.xy = hlslcc_mtx4unity_WorldToLight[0].xy * vs_TEXCOORD2.xx + u_xlat1.xy;
					    u_xlat1.xy = hlslcc_mtx4unity_WorldToLight[2].xy * vs_TEXCOORD2.zz + u_xlat1.xy;
					    u_xlat1.xy = u_xlat1.xy + hlslcc_mtx4unity_WorldToLight[3].xy;
					    u_xlat10_9 = texture(_LightTexture0, u_xlat1.xy).w;
					    u_xlat16_2.xyz = vec3(u_xlat10_9) * _LightColor0.xyz;
					    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
					    u_xlat16_11 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_11 = max(u_xlat16_11, 0.0);
					    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz;
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
					uniform 	vec4 _Color;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Step;
					uniform 	float _Power;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _LightTexture0;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					vec2 u_xlat1;
					mediump vec3 u_xlat16_2;
					vec2 u_xlat6;
					uint u_xlatu6;
					float u_xlat9;
					lowp float u_xlat10_9;
					uint u_xlatu9;
					bool u_xlatb9;
					mediump float u_xlat16_11;
					void main()
					{
					    u_xlat0.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat6.x = _Step / u_xlat0.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(u_xlat6.x>=(-u_xlat6.x));
					#else
					    u_xlatb9 = u_xlat6.x>=(-u_xlat6.x);
					#endif
					    u_xlat1.x = fract(abs(u_xlat6.x));
					    u_xlat6.x = (-u_xlat6.x) + u_xlat0.y;
					    u_xlatu6 = uint(u_xlat6.x);
					    u_xlat6.x = float(u_xlatu6);
					    u_xlat9 = (u_xlatb9) ? u_xlat1.x : (-u_xlat1.x);
					    u_xlat9 = u_xlat0.x * u_xlat9;
					    u_xlat0.xy = vec2(1.0, 1.0) / u_xlat0.xy;
					    u_xlatu9 = uint(u_xlat9);
					    u_xlat6.y = float(u_xlatu9);
					    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD0.yx;
					    u_xlat1.xy = u_xlat0.xy * u_xlat6.yx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    u_xlat0 = u_xlat16_0 * _Color;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Power, _Power, _Power));
					    SV_Target0.w = u_xlat0.w;
					    u_xlat1.xy = vs_TEXCOORD2.yy * hlslcc_mtx4unity_WorldToLight[1].xy;
					    u_xlat1.xy = hlslcc_mtx4unity_WorldToLight[0].xy * vs_TEXCOORD2.xx + u_xlat1.xy;
					    u_xlat1.xy = hlslcc_mtx4unity_WorldToLight[2].xy * vs_TEXCOORD2.zz + u_xlat1.xy;
					    u_xlat1.xy = u_xlat1.xy + hlslcc_mtx4unity_WorldToLight[3].xy;
					    u_xlat10_9 = texture(_LightTexture0, u_xlat1.xy).w;
					    u_xlat16_2.xyz = vec3(u_xlat10_9) * _LightColor0.xyz;
					    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
					    u_xlat16_11 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_11 = max(u_xlat16_11, 0.0);
					    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz;
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
					uniform 	vec4 _Color;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Step;
					uniform 	float _Power;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _LightTexture0;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					vec2 u_xlat1;
					mediump vec3 u_xlat16_2;
					vec2 u_xlat6;
					uint u_xlatu6;
					float u_xlat9;
					lowp float u_xlat10_9;
					uint u_xlatu9;
					bool u_xlatb9;
					mediump float u_xlat16_11;
					void main()
					{
					    u_xlat0.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat6.x = _Step / u_xlat0.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb9 = !!(u_xlat6.x>=(-u_xlat6.x));
					#else
					    u_xlatb9 = u_xlat6.x>=(-u_xlat6.x);
					#endif
					    u_xlat1.x = fract(abs(u_xlat6.x));
					    u_xlat6.x = (-u_xlat6.x) + u_xlat0.y;
					    u_xlatu6 = uint(u_xlat6.x);
					    u_xlat6.x = float(u_xlatu6);
					    u_xlat9 = (u_xlatb9) ? u_xlat1.x : (-u_xlat1.x);
					    u_xlat9 = u_xlat0.x * u_xlat9;
					    u_xlat0.xy = vec2(1.0, 1.0) / u_xlat0.xy;
					    u_xlatu9 = uint(u_xlat9);
					    u_xlat6.y = float(u_xlatu9);
					    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD0.yx;
					    u_xlat1.xy = u_xlat0.xy * u_xlat6.yx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    u_xlat0 = u_xlat16_0 * _Color;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Power, _Power, _Power));
					    SV_Target0.w = u_xlat0.w;
					    u_xlat1.xy = vs_TEXCOORD2.yy * hlslcc_mtx4unity_WorldToLight[1].xy;
					    u_xlat1.xy = hlslcc_mtx4unity_WorldToLight[0].xy * vs_TEXCOORD2.xx + u_xlat1.xy;
					    u_xlat1.xy = hlslcc_mtx4unity_WorldToLight[2].xy * vs_TEXCOORD2.zz + u_xlat1.xy;
					    u_xlat1.xy = u_xlat1.xy + hlslcc_mtx4unity_WorldToLight[3].xy;
					    u_xlat10_9 = texture(_LightTexture0, u_xlat1.xy).w;
					    u_xlat16_2.xyz = vec3(u_xlat10_9) * _LightColor0.xyz;
					    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
					    u_xlat16_11 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_11 = max(u_xlat16_11, 0.0);
					    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
					    SV_Target0.xyz = u_xlat16_2.xyz;
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
}
}