Shader "mitay-walle/Cutout Vertex Color Unlit Shadows" {
Properties {
 _MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
 _XFrames ("X Frames", Float) = 4.000000
 _YFrames ("Y Frames", Float) = 4.000000
 _Speed ("Speed", Float) = 0.000000
 _Cutoff ("Alpha cutoff", Range(0.000000,1.000000)) = 0.500000
}
SubShader { 
 LOD 100
 Tags { "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "SHADOWSUPPORT"="true" "RenderType"="TransparentCutout" }
  ColorMask RGB
  GpuProgramID 24692
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 c_1;
					  highp vec2 spriteUV_2;
					  highp float tmpvar_3;
					  tmpvar_3 = fract((_Time.y * _Speed));
					  highp float tmpvar_4;
					  tmpvar_4 = float(_XFrames);
					  highp float tmpvar_5;
					  tmpvar_5 = float(_YFrames);
					  spriteUV_2.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_3 * tmpvar_4) * tmpvar_5)
					  )) * (1.0/(tmpvar_4)));
					  spriteUV_2.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_3 * tmpvar_4)
					  )) * (1.0/(tmpvar_5)));
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = (texture2D (_MainTex, spriteUV_2) * xlv_COLOR0);
					  lowp float x_7;
					  x_7 = (tmpvar_6.w - _Cutoff);
					  if ((x_7 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_8;
					  lowp vec4 c_9;
					  c_9.xyz = vec3(0.0, 0.0, 0.0);
					  c_9.w = tmpvar_6.w;
					  c_8.w = c_9.w;
					  c_8.xyz = c_9.xyz;
					  c_1.w = c_8.w;
					  c_1.xyz = tmpvar_6.xyz;
					  gl_FragData[0] = c_1;
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 c_1;
					  highp vec2 spriteUV_2;
					  highp float tmpvar_3;
					  tmpvar_3 = fract((_Time.y * _Speed));
					  highp float tmpvar_4;
					  tmpvar_4 = float(_XFrames);
					  highp float tmpvar_5;
					  tmpvar_5 = float(_YFrames);
					  spriteUV_2.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_3 * tmpvar_4) * tmpvar_5)
					  )) * (1.0/(tmpvar_4)));
					  spriteUV_2.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_3 * tmpvar_4)
					  )) * (1.0/(tmpvar_5)));
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = (texture2D (_MainTex, spriteUV_2) * xlv_COLOR0);
					  lowp float x_7;
					  x_7 = (tmpvar_6.w - _Cutoff);
					  if ((x_7 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_8;
					  lowp vec4 c_9;
					  c_9.xyz = vec3(0.0, 0.0, 0.0);
					  c_9.w = tmpvar_6.w;
					  c_8.w = c_9.w;
					  c_8.xyz = c_9.xyz;
					  c_1.w = c_8.w;
					  c_1.xyz = tmpvar_6.xyz;
					  gl_FragData[0] = c_1;
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 c_1;
					  highp vec2 spriteUV_2;
					  highp float tmpvar_3;
					  tmpvar_3 = fract((_Time.y * _Speed));
					  highp float tmpvar_4;
					  tmpvar_4 = float(_XFrames);
					  highp float tmpvar_5;
					  tmpvar_5 = float(_YFrames);
					  spriteUV_2.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_3 * tmpvar_4) * tmpvar_5)
					  )) * (1.0/(tmpvar_4)));
					  spriteUV_2.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_3 * tmpvar_4)
					  )) * (1.0/(tmpvar_5)));
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = (texture2D (_MainTex, spriteUV_2) * xlv_COLOR0);
					  lowp float x_7;
					  x_7 = (tmpvar_6.w - _Cutoff);
					  if ((x_7 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_8;
					  lowp vec4 c_9;
					  c_9.xyz = vec3(0.0, 0.0, 0.0);
					  c_9.w = tmpvar_6.w;
					  c_8.w = c_9.w;
					  c_8.xyz = c_9.xyz;
					  c_1.w = c_8.w;
					  c_1.xyz = tmpvar_6.xyz;
					  gl_FragData[0] = c_1;
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat10_2 = u_xlat10_0.w * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat10_2 = u_xlat10_0.w * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat10_2 = u_xlat10_0.w * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 c_1;
					  highp vec2 spriteUV_2;
					  highp float tmpvar_3;
					  tmpvar_3 = fract((_Time.y * _Speed));
					  highp float tmpvar_4;
					  tmpvar_4 = float(_XFrames);
					  highp float tmpvar_5;
					  tmpvar_5 = float(_YFrames);
					  spriteUV_2.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_3 * tmpvar_4) * tmpvar_5)
					  )) * (1.0/(tmpvar_4)));
					  spriteUV_2.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_3 * tmpvar_4)
					  )) * (1.0/(tmpvar_5)));
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = (texture2D (_MainTex, spriteUV_2) * xlv_COLOR0);
					  lowp float x_7;
					  x_7 = (tmpvar_6.w - _Cutoff);
					  if ((x_7 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_8;
					  lowp vec4 c_9;
					  c_9.xyz = vec3(0.0, 0.0, 0.0);
					  c_9.w = tmpvar_6.w;
					  c_8.w = c_9.w;
					  c_8.xyz = c_9.xyz;
					  c_1.w = c_8.w;
					  c_1.xyz = tmpvar_6.xyz;
					  gl_FragData[0] = c_1;
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 c_1;
					  highp vec2 spriteUV_2;
					  highp float tmpvar_3;
					  tmpvar_3 = fract((_Time.y * _Speed));
					  highp float tmpvar_4;
					  tmpvar_4 = float(_XFrames);
					  highp float tmpvar_5;
					  tmpvar_5 = float(_YFrames);
					  spriteUV_2.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_3 * tmpvar_4) * tmpvar_5)
					  )) * (1.0/(tmpvar_4)));
					  spriteUV_2.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_3 * tmpvar_4)
					  )) * (1.0/(tmpvar_5)));
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = (texture2D (_MainTex, spriteUV_2) * xlv_COLOR0);
					  lowp float x_7;
					  x_7 = (tmpvar_6.w - _Cutoff);
					  if ((x_7 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_8;
					  lowp vec4 c_9;
					  c_9.xyz = vec3(0.0, 0.0, 0.0);
					  c_9.w = tmpvar_6.w;
					  c_8.w = c_9.w;
					  c_8.xyz = c_9.xyz;
					  c_1.w = c_8.w;
					  c_1.xyz = tmpvar_6.xyz;
					  gl_FragData[0] = c_1;
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 c_1;
					  highp vec2 spriteUV_2;
					  highp float tmpvar_3;
					  tmpvar_3 = fract((_Time.y * _Speed));
					  highp float tmpvar_4;
					  tmpvar_4 = float(_XFrames);
					  highp float tmpvar_5;
					  tmpvar_5 = float(_YFrames);
					  spriteUV_2.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_3 * tmpvar_4) * tmpvar_5)
					  )) * (1.0/(tmpvar_4)));
					  spriteUV_2.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_3 * tmpvar_4)
					  )) * (1.0/(tmpvar_5)));
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = (texture2D (_MainTex, spriteUV_2) * xlv_COLOR0);
					  lowp float x_7;
					  x_7 = (tmpvar_6.w - _Cutoff);
					  if ((x_7 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_8;
					  lowp vec4 c_9;
					  c_9.xyz = vec3(0.0, 0.0, 0.0);
					  c_9.w = tmpvar_6.w;
					  c_8.w = c_9.w;
					  c_8.xyz = c_9.xyz;
					  c_1.w = c_8.w;
					  c_1.xyz = tmpvar_6.xyz;
					  gl_FragData[0] = c_1;
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat10_2 = u_xlat10_0.w * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat10_2 = u_xlat10_0.w * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat10_2 = u_xlat10_0.w * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 c_1;
					  highp vec2 spriteUV_2;
					  highp float tmpvar_3;
					  tmpvar_3 = fract((_Time.y * _Speed));
					  highp float tmpvar_4;
					  tmpvar_4 = float(_XFrames);
					  highp float tmpvar_5;
					  tmpvar_5 = float(_YFrames);
					  spriteUV_2.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_3 * tmpvar_4) * tmpvar_5)
					  )) * (1.0/(tmpvar_4)));
					  spriteUV_2.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_3 * tmpvar_4)
					  )) * (1.0/(tmpvar_5)));
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = (texture2D (_MainTex, spriteUV_2) * xlv_COLOR0);
					  lowp float x_7;
					  x_7 = (tmpvar_6.w - _Cutoff);
					  if ((x_7 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_8;
					  lowp vec4 c_9;
					  c_9.xyz = vec3(0.0, 0.0, 0.0);
					  c_9.w = tmpvar_6.w;
					  c_8.w = c_9.w;
					  c_8.xyz = c_9.xyz;
					  c_1.w = c_8.w;
					  c_1.xyz = tmpvar_6.xyz;
					  gl_FragData[0] = c_1;
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 c_1;
					  highp vec2 spriteUV_2;
					  highp float tmpvar_3;
					  tmpvar_3 = fract((_Time.y * _Speed));
					  highp float tmpvar_4;
					  tmpvar_4 = float(_XFrames);
					  highp float tmpvar_5;
					  tmpvar_5 = float(_YFrames);
					  spriteUV_2.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_3 * tmpvar_4) * tmpvar_5)
					  )) * (1.0/(tmpvar_4)));
					  spriteUV_2.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_3 * tmpvar_4)
					  )) * (1.0/(tmpvar_5)));
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = (texture2D (_MainTex, spriteUV_2) * xlv_COLOR0);
					  lowp float x_7;
					  x_7 = (tmpvar_6.w - _Cutoff);
					  if ((x_7 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_8;
					  lowp vec4 c_9;
					  c_9.xyz = vec3(0.0, 0.0, 0.0);
					  c_9.w = tmpvar_6.w;
					  c_8.w = c_9.w;
					  c_8.xyz = c_9.xyz;
					  c_1.w = c_8.w;
					  c_1.xyz = tmpvar_6.xyz;
					  gl_FragData[0] = c_1;
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 c_1;
					  highp vec2 spriteUV_2;
					  highp float tmpvar_3;
					  tmpvar_3 = fract((_Time.y * _Speed));
					  highp float tmpvar_4;
					  tmpvar_4 = float(_XFrames);
					  highp float tmpvar_5;
					  tmpvar_5 = float(_YFrames);
					  spriteUV_2.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_3 * tmpvar_4) * tmpvar_5)
					  )) * (1.0/(tmpvar_4)));
					  spriteUV_2.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_3 * tmpvar_4)
					  )) * (1.0/(tmpvar_5)));
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = (texture2D (_MainTex, spriteUV_2) * xlv_COLOR0);
					  lowp float x_7;
					  x_7 = (tmpvar_6.w - _Cutoff);
					  if ((x_7 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_8;
					  lowp vec4 c_9;
					  c_9.xyz = vec3(0.0, 0.0, 0.0);
					  c_9.w = tmpvar_6.w;
					  c_8.w = c_9.w;
					  c_8.xyz = c_9.xyz;
					  c_1.w = c_8.w;
					  c_1.xyz = tmpvar_6.xyz;
					  gl_FragData[0] = c_1;
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat10_2 = u_xlat10_0.w * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat10_2 = u_xlat10_0.w * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat10_2 = u_xlat10_0.w * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 c_1;
					  highp vec2 spriteUV_2;
					  highp float tmpvar_3;
					  tmpvar_3 = fract((_Time.y * _Speed));
					  highp float tmpvar_4;
					  tmpvar_4 = float(_XFrames);
					  highp float tmpvar_5;
					  tmpvar_5 = float(_YFrames);
					  spriteUV_2.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_3 * tmpvar_4) * tmpvar_5)
					  )) * (1.0/(tmpvar_4)));
					  spriteUV_2.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_3 * tmpvar_4)
					  )) * (1.0/(tmpvar_5)));
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = (texture2D (_MainTex, spriteUV_2) * xlv_COLOR0);
					  lowp float x_7;
					  x_7 = (tmpvar_6.w - _Cutoff);
					  if ((x_7 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_8;
					  lowp vec4 c_9;
					  c_9.xyz = vec3(0.0, 0.0, 0.0);
					  c_9.w = tmpvar_6.w;
					  c_8.w = c_9.w;
					  c_8.xyz = c_9.xyz;
					  c_1.w = c_8.w;
					  c_1.xyz = tmpvar_6.xyz;
					  gl_FragData[0] = c_1;
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 c_1;
					  highp vec2 spriteUV_2;
					  highp float tmpvar_3;
					  tmpvar_3 = fract((_Time.y * _Speed));
					  highp float tmpvar_4;
					  tmpvar_4 = float(_XFrames);
					  highp float tmpvar_5;
					  tmpvar_5 = float(_YFrames);
					  spriteUV_2.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_3 * tmpvar_4) * tmpvar_5)
					  )) * (1.0/(tmpvar_4)));
					  spriteUV_2.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_3 * tmpvar_4)
					  )) * (1.0/(tmpvar_5)));
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = (texture2D (_MainTex, spriteUV_2) * xlv_COLOR0);
					  lowp float x_7;
					  x_7 = (tmpvar_6.w - _Cutoff);
					  if ((x_7 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_8;
					  lowp vec4 c_9;
					  c_9.xyz = vec3(0.0, 0.0, 0.0);
					  c_9.w = tmpvar_6.w;
					  c_8.w = c_9.w;
					  c_8.xyz = c_9.xyz;
					  c_1.w = c_8.w;
					  c_1.xyz = tmpvar_6.xyz;
					  gl_FragData[0] = c_1;
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 c_1;
					  highp vec2 spriteUV_2;
					  highp float tmpvar_3;
					  tmpvar_3 = fract((_Time.y * _Speed));
					  highp float tmpvar_4;
					  tmpvar_4 = float(_XFrames);
					  highp float tmpvar_5;
					  tmpvar_5 = float(_YFrames);
					  spriteUV_2.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_3 * tmpvar_4) * tmpvar_5)
					  )) * (1.0/(tmpvar_4)));
					  spriteUV_2.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_3 * tmpvar_4)
					  )) * (1.0/(tmpvar_5)));
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = (texture2D (_MainTex, spriteUV_2) * xlv_COLOR0);
					  lowp float x_7;
					  x_7 = (tmpvar_6.w - _Cutoff);
					  if ((x_7 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_8;
					  lowp vec4 c_9;
					  c_9.xyz = vec3(0.0, 0.0, 0.0);
					  c_9.w = tmpvar_6.w;
					  c_8.w = c_9.w;
					  c_8.xyz = c_9.xyz;
					  c_1.w = c_8.w;
					  c_1.xyz = tmpvar_6.xyz;
					  gl_FragData[0] = c_1;
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat10_2 = u_xlat10_0.w * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat10_2 = u_xlat10_0.w * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat10_2 = u_xlat10_0.w * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
  Tags { "LIGHTMODE"="ForwardAdd" "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }
  ZWrite Off
  Blend One One
  ColorMask RGB
  GpuProgramID 127402
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec2 spriteUV_1;
					  highp float tmpvar_2;
					  tmpvar_2 = fract((_Time.y * _Speed));
					  highp float tmpvar_3;
					  tmpvar_3 = float(_XFrames);
					  highp float tmpvar_4;
					  tmpvar_4 = float(_YFrames);
					  spriteUV_1.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_2 * tmpvar_3) * tmpvar_4)
					  )) * (1.0/(tmpvar_3)));
					  spriteUV_1.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_2 * tmpvar_3)
					  )) * (1.0/(tmpvar_4)));
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = (texture2D (_MainTex, spriteUV_1) * xlv_COLOR0);
					  lowp float x_6;
					  x_6 = (tmpvar_5.w - _Cutoff);
					  if ((x_6 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_7;
					  lowp vec4 c_8;
					  c_8.xyz = vec3(0.0, 0.0, 0.0);
					  c_8.w = tmpvar_5.w;
					  c_7.w = c_8.w;
					  c_7.xyz = c_8.xyz;
					  gl_FragData[0] = c_7;
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec2 spriteUV_1;
					  highp float tmpvar_2;
					  tmpvar_2 = fract((_Time.y * _Speed));
					  highp float tmpvar_3;
					  tmpvar_3 = float(_XFrames);
					  highp float tmpvar_4;
					  tmpvar_4 = float(_YFrames);
					  spriteUV_1.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_2 * tmpvar_3) * tmpvar_4)
					  )) * (1.0/(tmpvar_3)));
					  spriteUV_1.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_2 * tmpvar_3)
					  )) * (1.0/(tmpvar_4)));
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = (texture2D (_MainTex, spriteUV_1) * xlv_COLOR0);
					  lowp float x_6;
					  x_6 = (tmpvar_5.w - _Cutoff);
					  if ((x_6 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_7;
					  lowp vec4 c_8;
					  c_8.xyz = vec3(0.0, 0.0, 0.0);
					  c_8.w = tmpvar_5.w;
					  c_7.w = c_8.w;
					  c_7.xyz = c_8.xyz;
					  gl_FragData[0] = c_7;
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec2 spriteUV_1;
					  highp float tmpvar_2;
					  tmpvar_2 = fract((_Time.y * _Speed));
					  highp float tmpvar_3;
					  tmpvar_3 = float(_XFrames);
					  highp float tmpvar_4;
					  tmpvar_4 = float(_YFrames);
					  spriteUV_1.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_2 * tmpvar_3) * tmpvar_4)
					  )) * (1.0/(tmpvar_3)));
					  spriteUV_1.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_2 * tmpvar_3)
					  )) * (1.0/(tmpvar_4)));
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = (texture2D (_MainTex, spriteUV_1) * xlv_COLOR0);
					  lowp float x_6;
					  x_6 = (tmpvar_5.w - _Cutoff);
					  if ((x_6 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_7;
					  lowp vec4 c_8;
					  c_8.xyz = vec3(0.0, 0.0, 0.0);
					  c_8.w = tmpvar_5.w;
					  c_7.w = c_8.w;
					  c_7.xyz = c_8.xyz;
					  gl_FragData[0] = c_7;
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump float u_xlat16_0;
					lowp float u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy).w;
					    u_xlat10_2 = u_xlat10_0 * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0.w;
					    SV_Target0.w = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
					    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump float u_xlat16_0;
					lowp float u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy).w;
					    u_xlat10_2 = u_xlat10_0 * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0.w;
					    SV_Target0.w = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
					    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump float u_xlat16_0;
					lowp float u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy).w;
					    u_xlat10_2 = u_xlat10_0 * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0.w;
					    SV_Target0.w = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
					    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec2 spriteUV_1;
					  highp float tmpvar_2;
					  tmpvar_2 = fract((_Time.y * _Speed));
					  highp float tmpvar_3;
					  tmpvar_3 = float(_XFrames);
					  highp float tmpvar_4;
					  tmpvar_4 = float(_YFrames);
					  spriteUV_1.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_2 * tmpvar_3) * tmpvar_4)
					  )) * (1.0/(tmpvar_3)));
					  spriteUV_1.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_2 * tmpvar_3)
					  )) * (1.0/(tmpvar_4)));
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = (texture2D (_MainTex, spriteUV_1) * xlv_COLOR0);
					  lowp float x_6;
					  x_6 = (tmpvar_5.w - _Cutoff);
					  if ((x_6 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_7;
					  lowp vec4 c_8;
					  c_8.xyz = vec3(0.0, 0.0, 0.0);
					  c_8.w = tmpvar_5.w;
					  c_7.w = c_8.w;
					  c_7.xyz = c_8.xyz;
					  gl_FragData[0] = c_7;
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec2 spriteUV_1;
					  highp float tmpvar_2;
					  tmpvar_2 = fract((_Time.y * _Speed));
					  highp float tmpvar_3;
					  tmpvar_3 = float(_XFrames);
					  highp float tmpvar_4;
					  tmpvar_4 = float(_YFrames);
					  spriteUV_1.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_2 * tmpvar_3) * tmpvar_4)
					  )) * (1.0/(tmpvar_3)));
					  spriteUV_1.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_2 * tmpvar_3)
					  )) * (1.0/(tmpvar_4)));
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = (texture2D (_MainTex, spriteUV_1) * xlv_COLOR0);
					  lowp float x_6;
					  x_6 = (tmpvar_5.w - _Cutoff);
					  if ((x_6 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_7;
					  lowp vec4 c_8;
					  c_8.xyz = vec3(0.0, 0.0, 0.0);
					  c_8.w = tmpvar_5.w;
					  c_7.w = c_8.w;
					  c_7.xyz = c_8.xyz;
					  gl_FragData[0] = c_7;
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec2 spriteUV_1;
					  highp float tmpvar_2;
					  tmpvar_2 = fract((_Time.y * _Speed));
					  highp float tmpvar_3;
					  tmpvar_3 = float(_XFrames);
					  highp float tmpvar_4;
					  tmpvar_4 = float(_YFrames);
					  spriteUV_1.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_2 * tmpvar_3) * tmpvar_4)
					  )) * (1.0/(tmpvar_3)));
					  spriteUV_1.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_2 * tmpvar_3)
					  )) * (1.0/(tmpvar_4)));
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = (texture2D (_MainTex, spriteUV_1) * xlv_COLOR0);
					  lowp float x_6;
					  x_6 = (tmpvar_5.w - _Cutoff);
					  if ((x_6 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_7;
					  lowp vec4 c_8;
					  c_8.xyz = vec3(0.0, 0.0, 0.0);
					  c_8.w = tmpvar_5.w;
					  c_7.w = c_8.w;
					  c_7.xyz = c_8.xyz;
					  gl_FragData[0] = c_7;
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump float u_xlat16_0;
					lowp float u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy).w;
					    u_xlat10_2 = u_xlat10_0 * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0.w;
					    SV_Target0.w = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
					    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump float u_xlat16_0;
					lowp float u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy).w;
					    u_xlat10_2 = u_xlat10_0 * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0.w;
					    SV_Target0.w = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
					    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump float u_xlat16_0;
					lowp float u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy).w;
					    u_xlat10_2 = u_xlat10_0 * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0.w;
					    SV_Target0.w = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
					    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec2 spriteUV_1;
					  highp float tmpvar_2;
					  tmpvar_2 = fract((_Time.y * _Speed));
					  highp float tmpvar_3;
					  tmpvar_3 = float(_XFrames);
					  highp float tmpvar_4;
					  tmpvar_4 = float(_YFrames);
					  spriteUV_1.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_2 * tmpvar_3) * tmpvar_4)
					  )) * (1.0/(tmpvar_3)));
					  spriteUV_1.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_2 * tmpvar_3)
					  )) * (1.0/(tmpvar_4)));
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = (texture2D (_MainTex, spriteUV_1) * xlv_COLOR0);
					  lowp float x_6;
					  x_6 = (tmpvar_5.w - _Cutoff);
					  if ((x_6 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_7;
					  lowp vec4 c_8;
					  c_8.xyz = vec3(0.0, 0.0, 0.0);
					  c_8.w = tmpvar_5.w;
					  c_7.w = c_8.w;
					  c_7.xyz = c_8.xyz;
					  gl_FragData[0] = c_7;
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec2 spriteUV_1;
					  highp float tmpvar_2;
					  tmpvar_2 = fract((_Time.y * _Speed));
					  highp float tmpvar_3;
					  tmpvar_3 = float(_XFrames);
					  highp float tmpvar_4;
					  tmpvar_4 = float(_YFrames);
					  spriteUV_1.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_2 * tmpvar_3) * tmpvar_4)
					  )) * (1.0/(tmpvar_3)));
					  spriteUV_1.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_2 * tmpvar_3)
					  )) * (1.0/(tmpvar_4)));
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = (texture2D (_MainTex, spriteUV_1) * xlv_COLOR0);
					  lowp float x_6;
					  x_6 = (tmpvar_5.w - _Cutoff);
					  if ((x_6 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_7;
					  lowp vec4 c_8;
					  c_8.xyz = vec3(0.0, 0.0, 0.0);
					  c_8.w = tmpvar_5.w;
					  c_7.w = c_8.w;
					  c_7.xyz = c_8.xyz;
					  gl_FragData[0] = c_7;
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec2 spriteUV_1;
					  highp float tmpvar_2;
					  tmpvar_2 = fract((_Time.y * _Speed));
					  highp float tmpvar_3;
					  tmpvar_3 = float(_XFrames);
					  highp float tmpvar_4;
					  tmpvar_4 = float(_YFrames);
					  spriteUV_1.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_2 * tmpvar_3) * tmpvar_4)
					  )) * (1.0/(tmpvar_3)));
					  spriteUV_1.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_2 * tmpvar_3)
					  )) * (1.0/(tmpvar_4)));
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = (texture2D (_MainTex, spriteUV_1) * xlv_COLOR0);
					  lowp float x_6;
					  x_6 = (tmpvar_5.w - _Cutoff);
					  if ((x_6 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_7;
					  lowp vec4 c_8;
					  c_8.xyz = vec3(0.0, 0.0, 0.0);
					  c_8.w = tmpvar_5.w;
					  c_7.w = c_8.w;
					  c_7.xyz = c_8.xyz;
					  gl_FragData[0] = c_7;
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump float u_xlat16_0;
					lowp float u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy).w;
					    u_xlat10_2 = u_xlat10_0 * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0.w;
					    SV_Target0.w = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
					    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump float u_xlat16_0;
					lowp float u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy).w;
					    u_xlat10_2 = u_xlat10_0 * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0.w;
					    SV_Target0.w = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
					    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump float u_xlat16_0;
					lowp float u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy).w;
					    u_xlat10_2 = u_xlat10_0 * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0.w;
					    SV_Target0.w = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
					    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec2 spriteUV_1;
					  highp float tmpvar_2;
					  tmpvar_2 = fract((_Time.y * _Speed));
					  highp float tmpvar_3;
					  tmpvar_3 = float(_XFrames);
					  highp float tmpvar_4;
					  tmpvar_4 = float(_YFrames);
					  spriteUV_1.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_2 * tmpvar_3) * tmpvar_4)
					  )) * (1.0/(tmpvar_3)));
					  spriteUV_1.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_2 * tmpvar_3)
					  )) * (1.0/(tmpvar_4)));
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = (texture2D (_MainTex, spriteUV_1) * xlv_COLOR0);
					  lowp float x_6;
					  x_6 = (tmpvar_5.w - _Cutoff);
					  if ((x_6 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_7;
					  lowp vec4 c_8;
					  c_8.xyz = vec3(0.0, 0.0, 0.0);
					  c_8.w = tmpvar_5.w;
					  c_7.w = c_8.w;
					  c_7.xyz = c_8.xyz;
					  gl_FragData[0] = c_7;
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec2 spriteUV_1;
					  highp float tmpvar_2;
					  tmpvar_2 = fract((_Time.y * _Speed));
					  highp float tmpvar_3;
					  tmpvar_3 = float(_XFrames);
					  highp float tmpvar_4;
					  tmpvar_4 = float(_YFrames);
					  spriteUV_1.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_2 * tmpvar_3) * tmpvar_4)
					  )) * (1.0/(tmpvar_3)));
					  spriteUV_1.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_2 * tmpvar_3)
					  )) * (1.0/(tmpvar_4)));
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = (texture2D (_MainTex, spriteUV_1) * xlv_COLOR0);
					  lowp float x_6;
					  x_6 = (tmpvar_5.w - _Cutoff);
					  if ((x_6 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_7;
					  lowp vec4 c_8;
					  c_8.xyz = vec3(0.0, 0.0, 0.0);
					  c_8.w = tmpvar_5.w;
					  c_7.w = c_8.w;
					  c_7.xyz = c_8.xyz;
					  gl_FragData[0] = c_7;
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec2 spriteUV_1;
					  highp float tmpvar_2;
					  tmpvar_2 = fract((_Time.y * _Speed));
					  highp float tmpvar_3;
					  tmpvar_3 = float(_XFrames);
					  highp float tmpvar_4;
					  tmpvar_4 = float(_YFrames);
					  spriteUV_1.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_2 * tmpvar_3) * tmpvar_4)
					  )) * (1.0/(tmpvar_3)));
					  spriteUV_1.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_2 * tmpvar_3)
					  )) * (1.0/(tmpvar_4)));
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = (texture2D (_MainTex, spriteUV_1) * xlv_COLOR0);
					  lowp float x_6;
					  x_6 = (tmpvar_5.w - _Cutoff);
					  if ((x_6 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_7;
					  lowp vec4 c_8;
					  c_8.xyz = vec3(0.0, 0.0, 0.0);
					  c_8.w = tmpvar_5.w;
					  c_7.w = c_8.w;
					  c_7.xyz = c_8.xyz;
					  gl_FragData[0] = c_7;
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump float u_xlat16_0;
					lowp float u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy).w;
					    u_xlat10_2 = u_xlat10_0 * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0.w;
					    SV_Target0.w = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
					    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump float u_xlat16_0;
					lowp float u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy).w;
					    u_xlat10_2 = u_xlat10_0 * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0.w;
					    SV_Target0.w = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
					    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump float u_xlat16_0;
					lowp float u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy).w;
					    u_xlat10_2 = u_xlat10_0 * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0.w;
					    SV_Target0.w = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
					    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec2 spriteUV_1;
					  highp float tmpvar_2;
					  tmpvar_2 = fract((_Time.y * _Speed));
					  highp float tmpvar_3;
					  tmpvar_3 = float(_XFrames);
					  highp float tmpvar_4;
					  tmpvar_4 = float(_YFrames);
					  spriteUV_1.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_2 * tmpvar_3) * tmpvar_4)
					  )) * (1.0/(tmpvar_3)));
					  spriteUV_1.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_2 * tmpvar_3)
					  )) * (1.0/(tmpvar_4)));
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = (texture2D (_MainTex, spriteUV_1) * xlv_COLOR0);
					  lowp float x_6;
					  x_6 = (tmpvar_5.w - _Cutoff);
					  if ((x_6 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_7;
					  lowp vec4 c_8;
					  c_8.xyz = vec3(0.0, 0.0, 0.0);
					  c_8.w = tmpvar_5.w;
					  c_7.w = c_8.w;
					  c_7.xyz = c_8.xyz;
					  gl_FragData[0] = c_7;
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec2 spriteUV_1;
					  highp float tmpvar_2;
					  tmpvar_2 = fract((_Time.y * _Speed));
					  highp float tmpvar_3;
					  tmpvar_3 = float(_XFrames);
					  highp float tmpvar_4;
					  tmpvar_4 = float(_YFrames);
					  spriteUV_1.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_2 * tmpvar_3) * tmpvar_4)
					  )) * (1.0/(tmpvar_3)));
					  spriteUV_1.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_2 * tmpvar_3)
					  )) * (1.0/(tmpvar_4)));
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = (texture2D (_MainTex, spriteUV_1) * xlv_COLOR0);
					  lowp float x_6;
					  x_6 = (tmpvar_5.w - _Cutoff);
					  if ((x_6 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_7;
					  lowp vec4 c_8;
					  c_8.xyz = vec3(0.0, 0.0, 0.0);
					  c_8.w = tmpvar_5.w;
					  c_7.w = c_8.w;
					  c_7.xyz = c_8.xyz;
					  gl_FragData[0] = c_7;
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec2 spriteUV_1;
					  highp float tmpvar_2;
					  tmpvar_2 = fract((_Time.y * _Speed));
					  highp float tmpvar_3;
					  tmpvar_3 = float(_XFrames);
					  highp float tmpvar_4;
					  tmpvar_4 = float(_YFrames);
					  spriteUV_1.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_2 * tmpvar_3) * tmpvar_4)
					  )) * (1.0/(tmpvar_3)));
					  spriteUV_1.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_2 * tmpvar_3)
					  )) * (1.0/(tmpvar_4)));
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = (texture2D (_MainTex, spriteUV_1) * xlv_COLOR0);
					  lowp float x_6;
					  x_6 = (tmpvar_5.w - _Cutoff);
					  if ((x_6 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_7;
					  lowp vec4 c_8;
					  c_8.xyz = vec3(0.0, 0.0, 0.0);
					  c_8.w = tmpvar_5.w;
					  c_7.w = c_8.w;
					  c_7.xyz = c_8.xyz;
					  gl_FragData[0] = c_7;
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump float u_xlat16_0;
					lowp float u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy).w;
					    u_xlat10_2 = u_xlat10_0 * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0.w;
					    SV_Target0.w = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
					    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump float u_xlat16_0;
					lowp float u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy).w;
					    u_xlat10_2 = u_xlat10_0 * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0.w;
					    SV_Target0.w = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
					    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump float u_xlat16_0;
					lowp float u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy).w;
					    u_xlat10_2 = u_xlat10_0 * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0.w;
					    SV_Target0.w = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
					    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
  Tags { "LIGHTMODE"="PrePassBase" "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }
  GpuProgramID 171127
Program "vp" {
SubProgram "gles hw_tier01 " {

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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 res_1;
					  lowp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD1;
					  highp vec2 spriteUV_3;
					  highp float tmpvar_4;
					  tmpvar_4 = fract((_Time.y * _Speed));
					  highp float tmpvar_5;
					  tmpvar_5 = float(_XFrames);
					  highp float tmpvar_6;
					  tmpvar_6 = float(_YFrames);
					  spriteUV_3.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_4 * tmpvar_5) * tmpvar_6)
					  )) * (1.0/(tmpvar_5)));
					  spriteUV_3.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_4 * tmpvar_5)
					  )) * (1.0/(tmpvar_6)));
					  lowp float x_7;
					  x_7 = ((texture2D (_MainTex, spriteUV_3) * xlv_COLOR0).w - _Cutoff);
					  if ((x_7 < 0.0)) {
					    discard;
					  };
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 res_1;
					  lowp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD1;
					  highp vec2 spriteUV_3;
					  highp float tmpvar_4;
					  tmpvar_4 = fract((_Time.y * _Speed));
					  highp float tmpvar_5;
					  tmpvar_5 = float(_XFrames);
					  highp float tmpvar_6;
					  tmpvar_6 = float(_YFrames);
					  spriteUV_3.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_4 * tmpvar_5) * tmpvar_6)
					  )) * (1.0/(tmpvar_5)));
					  spriteUV_3.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_4 * tmpvar_5)
					  )) * (1.0/(tmpvar_6)));
					  lowp float x_7;
					  x_7 = ((texture2D (_MainTex, spriteUV_3) * xlv_COLOR0).w - _Cutoff);
					  if ((x_7 < 0.0)) {
					    discard;
					  };
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 res_1;
					  lowp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD1;
					  highp vec2 spriteUV_3;
					  highp float tmpvar_4;
					  tmpvar_4 = fract((_Time.y * _Speed));
					  highp float tmpvar_5;
					  tmpvar_5 = float(_XFrames);
					  highp float tmpvar_6;
					  tmpvar_6 = float(_YFrames);
					  spriteUV_3.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_4 * tmpvar_5) * tmpvar_6)
					  )) * (1.0/(tmpvar_5)));
					  spriteUV_3.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_4 * tmpvar_5)
					  )) * (1.0/(tmpvar_6)));
					  lowp float x_7;
					  x_7 = ((texture2D (_MainTex, spriteUV_3) * xlv_COLOR0).w - _Cutoff);
					  if ((x_7 < 0.0)) {
					    discard;
					  };
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp float u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy).w;
					    u_xlat10_2 = u_xlat10_0 * vs_COLOR0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
					    SV_Target0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp float u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy).w;
					    u_xlat10_2 = u_xlat10_0 * vs_COLOR0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
					    SV_Target0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp float u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy).w;
					    u_xlat10_2 = u_xlat10_0 * vs_COLOR0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
					    SV_Target0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
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
  Tags { "LIGHTMODE"="PrePassFinal" "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }
  ZWrite Off
  GpuProgramID 213194
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  highp vec2 spriteUV_3;
					  highp float tmpvar_4;
					  tmpvar_4 = fract((_Time.y * _Speed));
					  highp float tmpvar_5;
					  tmpvar_5 = float(_XFrames);
					  highp float tmpvar_6;
					  tmpvar_6 = float(_YFrames);
					  spriteUV_3.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_4 * tmpvar_5) * tmpvar_6)
					  )) * (1.0/(tmpvar_5)));
					  spriteUV_3.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_4 * tmpvar_5)
					  )) * (1.0/(tmpvar_6)));
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, spriteUV_3) * xlv_COLOR0);
					  lowp float x_8;
					  x_8 = (tmpvar_7.w - _Cutoff);
					  if ((x_8 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_9;
					  c_9.xyz = vec3(0.0, 0.0, 0.0);
					  c_9.w = tmpvar_7.w;
					  c_2 = c_9;
					  c_2.xyz = (c_2.xyz + tmpvar_7.xyz);
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  highp vec2 spriteUV_3;
					  highp float tmpvar_4;
					  tmpvar_4 = fract((_Time.y * _Speed));
					  highp float tmpvar_5;
					  tmpvar_5 = float(_XFrames);
					  highp float tmpvar_6;
					  tmpvar_6 = float(_YFrames);
					  spriteUV_3.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_4 * tmpvar_5) * tmpvar_6)
					  )) * (1.0/(tmpvar_5)));
					  spriteUV_3.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_4 * tmpvar_5)
					  )) * (1.0/(tmpvar_6)));
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, spriteUV_3) * xlv_COLOR0);
					  lowp float x_8;
					  x_8 = (tmpvar_7.w - _Cutoff);
					  if ((x_8 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_9;
					  c_9.xyz = vec3(0.0, 0.0, 0.0);
					  c_9.w = tmpvar_7.w;
					  c_2 = c_9;
					  c_2.xyz = (c_2.xyz + tmpvar_7.xyz);
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  highp vec2 spriteUV_3;
					  highp float tmpvar_4;
					  tmpvar_4 = fract((_Time.y * _Speed));
					  highp float tmpvar_5;
					  tmpvar_5 = float(_XFrames);
					  highp float tmpvar_6;
					  tmpvar_6 = float(_YFrames);
					  spriteUV_3.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_4 * tmpvar_5) * tmpvar_6)
					  )) * (1.0/(tmpvar_5)));
					  spriteUV_3.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_4 * tmpvar_5)
					  )) * (1.0/(tmpvar_6)));
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, spriteUV_3) * xlv_COLOR0);
					  lowp float x_8;
					  x_8 = (tmpvar_7.w - _Cutoff);
					  if ((x_8 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_9;
					  c_9.xyz = vec3(0.0, 0.0, 0.0);
					  c_9.w = tmpvar_7.w;
					  c_2 = c_9;
					  c_2.xyz = (c_2.xyz + tmpvar_7.xyz);
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat10_2 = u_xlat10_0.w * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat10_2 = u_xlat10_0.w * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat10_2 = u_xlat10_0.w * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform sampler2D _LightBuffer;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  highp vec2 spriteUV_4;
					  highp float tmpvar_5;
					  tmpvar_5 = fract((_Time.y * _Speed));
					  highp float tmpvar_6;
					  tmpvar_6 = float(_XFrames);
					  highp float tmpvar_7;
					  tmpvar_7 = float(_YFrames);
					  spriteUV_4.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_5 * tmpvar_6) * tmpvar_7)
					  )) * (1.0/(tmpvar_6)));
					  spriteUV_4.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_5 * tmpvar_6)
					  )) * (1.0/(tmpvar_7)));
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, spriteUV_4) * xlv_COLOR0);
					  lowp float x_9;
					  x_9 = (tmpvar_8.w - _Cutoff);
					  if ((x_9 < 0.0)) {
					    discard;
					  };
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_3 = tmpvar_10;
					  mediump vec4 tmpvar_11;
					  tmpvar_11 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
					  light_3.w = tmpvar_11.w;
					  light_3.xyz = (tmpvar_11.xyz + xlv_TEXCOORD4);
					  lowp vec4 c_12;
					  c_12.xyz = vec3(0.0, 0.0, 0.0);
					  c_12.w = tmpvar_8.w;
					  c_2 = c_12;
					  c_2.xyz = (c_2.xyz + tmpvar_8.xyz);
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform sampler2D _LightBuffer;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  highp vec2 spriteUV_4;
					  highp float tmpvar_5;
					  tmpvar_5 = fract((_Time.y * _Speed));
					  highp float tmpvar_6;
					  tmpvar_6 = float(_XFrames);
					  highp float tmpvar_7;
					  tmpvar_7 = float(_YFrames);
					  spriteUV_4.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_5 * tmpvar_6) * tmpvar_7)
					  )) * (1.0/(tmpvar_6)));
					  spriteUV_4.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_5 * tmpvar_6)
					  )) * (1.0/(tmpvar_7)));
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, spriteUV_4) * xlv_COLOR0);
					  lowp float x_9;
					  x_9 = (tmpvar_8.w - _Cutoff);
					  if ((x_9 < 0.0)) {
					    discard;
					  };
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_3 = tmpvar_10;
					  mediump vec4 tmpvar_11;
					  tmpvar_11 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
					  light_3.w = tmpvar_11.w;
					  light_3.xyz = (tmpvar_11.xyz + xlv_TEXCOORD4);
					  lowp vec4 c_12;
					  c_12.xyz = vec3(0.0, 0.0, 0.0);
					  c_12.w = tmpvar_8.w;
					  c_2 = c_12;
					  c_2.xyz = (c_2.xyz + tmpvar_8.xyz);
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform sampler2D _LightBuffer;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  highp vec2 spriteUV_4;
					  highp float tmpvar_5;
					  tmpvar_5 = fract((_Time.y * _Speed));
					  highp float tmpvar_6;
					  tmpvar_6 = float(_XFrames);
					  highp float tmpvar_7;
					  tmpvar_7 = float(_YFrames);
					  spriteUV_4.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_5 * tmpvar_6) * tmpvar_7)
					  )) * (1.0/(tmpvar_6)));
					  spriteUV_4.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_5 * tmpvar_6)
					  )) * (1.0/(tmpvar_7)));
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, spriteUV_4) * xlv_COLOR0);
					  lowp float x_9;
					  x_9 = (tmpvar_8.w - _Cutoff);
					  if ((x_9 < 0.0)) {
					    discard;
					  };
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_3 = tmpvar_10;
					  mediump vec4 tmpvar_11;
					  tmpvar_11 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
					  light_3.w = tmpvar_11.w;
					  light_3.xyz = (tmpvar_11.xyz + xlv_TEXCOORD4);
					  lowp vec4 c_12;
					  c_12.xyz = vec3(0.0, 0.0, 0.0);
					  c_12.w = tmpvar_8.w;
					  c_2 = c_12;
					  c_2.xyz = (c_2.xyz + tmpvar_8.xyz);
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat10_2 = u_xlat10_0.w * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat10_2 = u_xlat10_0.w * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat10_2 = u_xlat10_0.w * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
  Tags { "LIGHTMODE"="Deferred" "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }
  GpuProgramID 264383
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec4 outEmission_1;
					  lowp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD1;
					  highp vec2 spriteUV_3;
					  highp float tmpvar_4;
					  tmpvar_4 = fract((_Time.y * _Speed));
					  highp float tmpvar_5;
					  tmpvar_5 = float(_XFrames);
					  highp float tmpvar_6;
					  tmpvar_6 = float(_YFrames);
					  spriteUV_3.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_4 * tmpvar_5) * tmpvar_6)
					  )) * (1.0/(tmpvar_5)));
					  spriteUV_3.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_4 * tmpvar_5)
					  )) * (1.0/(tmpvar_6)));
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, spriteUV_3) * xlv_COLOR0);
					  lowp float x_8;
					  x_8 = (tmpvar_7.w - _Cutoff);
					  if ((x_8 < 0.0)) {
					    discard;
					  };
					  mediump vec4 outDiffuseOcclusion_9;
					  mediump vec4 outNormal_10;
					  mediump vec4 emission_11;
					  lowp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = vec3(0.0, 0.0, 0.0);
					  outDiffuseOcclusion_9 = tmpvar_12;
					  lowp vec4 tmpvar_13;
					  tmpvar_13.w = 1.0;
					  tmpvar_13.xyz = ((tmpvar_2 * 0.5) + 0.5);
					  outNormal_10 = tmpvar_13;
					  lowp vec4 tmpvar_14;
					  tmpvar_14.w = 1.0;
					  tmpvar_14.xyz = tmpvar_7.xyz;
					  emission_11 = tmpvar_14;
					  emission_11.xyz = emission_11.xyz;
					  outEmission_1.w = emission_11.w;
					  outEmission_1.xyz = exp2(-(emission_11.xyz));
					  gl_FragData[0] = outDiffuseOcclusion_9;
					  gl_FragData[1] = vec4(0.0, 0.0, 0.0, 0.0);
					  gl_FragData[2] = outNormal_10;
					  gl_FragData[3] = outEmission_1;
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec4 outEmission_1;
					  lowp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD1;
					  highp vec2 spriteUV_3;
					  highp float tmpvar_4;
					  tmpvar_4 = fract((_Time.y * _Speed));
					  highp float tmpvar_5;
					  tmpvar_5 = float(_XFrames);
					  highp float tmpvar_6;
					  tmpvar_6 = float(_YFrames);
					  spriteUV_3.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_4 * tmpvar_5) * tmpvar_6)
					  )) * (1.0/(tmpvar_5)));
					  spriteUV_3.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_4 * tmpvar_5)
					  )) * (1.0/(tmpvar_6)));
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, spriteUV_3) * xlv_COLOR0);
					  lowp float x_8;
					  x_8 = (tmpvar_7.w - _Cutoff);
					  if ((x_8 < 0.0)) {
					    discard;
					  };
					  mediump vec4 outDiffuseOcclusion_9;
					  mediump vec4 outNormal_10;
					  mediump vec4 emission_11;
					  lowp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = vec3(0.0, 0.0, 0.0);
					  outDiffuseOcclusion_9 = tmpvar_12;
					  lowp vec4 tmpvar_13;
					  tmpvar_13.w = 1.0;
					  tmpvar_13.xyz = ((tmpvar_2 * 0.5) + 0.5);
					  outNormal_10 = tmpvar_13;
					  lowp vec4 tmpvar_14;
					  tmpvar_14.w = 1.0;
					  tmpvar_14.xyz = tmpvar_7.xyz;
					  emission_11 = tmpvar_14;
					  emission_11.xyz = emission_11.xyz;
					  outEmission_1.w = emission_11.w;
					  outEmission_1.xyz = exp2(-(emission_11.xyz));
					  gl_FragData[0] = outDiffuseOcclusion_9;
					  gl_FragData[1] = vec4(0.0, 0.0, 0.0, 0.0);
					  gl_FragData[2] = outNormal_10;
					  gl_FragData[3] = outEmission_1;
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec4 outEmission_1;
					  lowp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD1;
					  highp vec2 spriteUV_3;
					  highp float tmpvar_4;
					  tmpvar_4 = fract((_Time.y * _Speed));
					  highp float tmpvar_5;
					  tmpvar_5 = float(_XFrames);
					  highp float tmpvar_6;
					  tmpvar_6 = float(_YFrames);
					  spriteUV_3.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_4 * tmpvar_5) * tmpvar_6)
					  )) * (1.0/(tmpvar_5)));
					  spriteUV_3.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_4 * tmpvar_5)
					  )) * (1.0/(tmpvar_6)));
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (texture2D (_MainTex, spriteUV_3) * xlv_COLOR0);
					  lowp float x_8;
					  x_8 = (tmpvar_7.w - _Cutoff);
					  if ((x_8 < 0.0)) {
					    discard;
					  };
					  mediump vec4 outDiffuseOcclusion_9;
					  mediump vec4 outNormal_10;
					  mediump vec4 emission_11;
					  lowp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = vec3(0.0, 0.0, 0.0);
					  outDiffuseOcclusion_9 = tmpvar_12;
					  lowp vec4 tmpvar_13;
					  tmpvar_13.w = 1.0;
					  tmpvar_13.xyz = ((tmpvar_2 * 0.5) + 0.5);
					  outNormal_10 = tmpvar_13;
					  lowp vec4 tmpvar_14;
					  tmpvar_14.w = 1.0;
					  tmpvar_14.xyz = tmpvar_7.xyz;
					  emission_11 = tmpvar_14;
					  emission_11.xyz = emission_11.xyz;
					  outEmission_1.w = emission_11.w;
					  outEmission_1.xyz = exp2(-(emission_11.xyz));
					  gl_FragData[0] = outDiffuseOcclusion_9;
					  gl_FragData[1] = vec4(0.0, 0.0, 0.0, 0.0);
					  gl_FragData[2] = outNormal_10;
					  gl_FragData[3] = outEmission_1;
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp vec3 u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat10_2.x = u_xlat10_0.w * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
					    SV_Target3.xyz = exp2((-u_xlat16_0.xyz));
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2.x<0.0);
					#else
					    u_xlatb0 = u_xlat10_2.x<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp vec3 u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat10_2.x = u_xlat10_0.w * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
					    SV_Target3.xyz = exp2((-u_xlat16_0.xyz));
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2.x<0.0);
					#else
					    u_xlatb0 = u_xlat10_2.x<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp vec3 u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat10_2.x = u_xlat10_0.w * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
					    SV_Target3.xyz = exp2((-u_xlat16_0.xyz));
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2.x<0.0);
					#else
					    u_xlatb0 = u_xlat10_2.x<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec3 tmpvar_1;
					  tmpvar_1 = xlv_TEXCOORD1;
					  highp vec2 spriteUV_2;
					  highp float tmpvar_3;
					  tmpvar_3 = fract((_Time.y * _Speed));
					  highp float tmpvar_4;
					  tmpvar_4 = float(_XFrames);
					  highp float tmpvar_5;
					  tmpvar_5 = float(_YFrames);
					  spriteUV_2.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_3 * tmpvar_4) * tmpvar_5)
					  )) * (1.0/(tmpvar_4)));
					  spriteUV_2.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_3 * tmpvar_4)
					  )) * (1.0/(tmpvar_5)));
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = (texture2D (_MainTex, spriteUV_2) * xlv_COLOR0);
					  lowp float x_7;
					  x_7 = (tmpvar_6.w - _Cutoff);
					  if ((x_7 < 0.0)) {
					    discard;
					  };
					  mediump vec4 outDiffuseOcclusion_8;
					  mediump vec4 outNormal_9;
					  mediump vec4 emission_10;
					  lowp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
					  outDiffuseOcclusion_8 = tmpvar_11;
					  lowp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = ((tmpvar_1 * 0.5) + 0.5);
					  outNormal_9 = tmpvar_12;
					  lowp vec4 tmpvar_13;
					  tmpvar_13.w = 1.0;
					  tmpvar_13.xyz = tmpvar_6.xyz;
					  emission_10 = tmpvar_13;
					  emission_10.xyz = emission_10.xyz;
					  gl_FragData[0] = outDiffuseOcclusion_8;
					  gl_FragData[1] = vec4(0.0, 0.0, 0.0, 0.0);
					  gl_FragData[2] = outNormal_9;
					  gl_FragData[3] = emission_10;
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec3 tmpvar_1;
					  tmpvar_1 = xlv_TEXCOORD1;
					  highp vec2 spriteUV_2;
					  highp float tmpvar_3;
					  tmpvar_3 = fract((_Time.y * _Speed));
					  highp float tmpvar_4;
					  tmpvar_4 = float(_XFrames);
					  highp float tmpvar_5;
					  tmpvar_5 = float(_YFrames);
					  spriteUV_2.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_3 * tmpvar_4) * tmpvar_5)
					  )) * (1.0/(tmpvar_4)));
					  spriteUV_2.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_3 * tmpvar_4)
					  )) * (1.0/(tmpvar_5)));
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = (texture2D (_MainTex, spriteUV_2) * xlv_COLOR0);
					  lowp float x_7;
					  x_7 = (tmpvar_6.w - _Cutoff);
					  if ((x_7 < 0.0)) {
					    discard;
					  };
					  mediump vec4 outDiffuseOcclusion_8;
					  mediump vec4 outNormal_9;
					  mediump vec4 emission_10;
					  lowp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
					  outDiffuseOcclusion_8 = tmpvar_11;
					  lowp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = ((tmpvar_1 * 0.5) + 0.5);
					  outNormal_9 = tmpvar_12;
					  lowp vec4 tmpvar_13;
					  tmpvar_13.w = 1.0;
					  tmpvar_13.xyz = tmpvar_6.xyz;
					  emission_10 = tmpvar_13;
					  emission_10.xyz = emission_10.xyz;
					  gl_FragData[0] = outDiffuseOcclusion_8;
					  gl_FragData[1] = vec4(0.0, 0.0, 0.0, 0.0);
					  gl_FragData[2] = outNormal_9;
					  gl_FragData[3] = emission_10;
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
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec3 tmpvar_1;
					  tmpvar_1 = xlv_TEXCOORD1;
					  highp vec2 spriteUV_2;
					  highp float tmpvar_3;
					  tmpvar_3 = fract((_Time.y * _Speed));
					  highp float tmpvar_4;
					  tmpvar_4 = float(_XFrames);
					  highp float tmpvar_5;
					  tmpvar_5 = float(_YFrames);
					  spriteUV_2.x = ((xlv_TEXCOORD0.x + floor(
					    ((tmpvar_3 * tmpvar_4) * tmpvar_5)
					  )) * (1.0/(tmpvar_4)));
					  spriteUV_2.y = ((xlv_TEXCOORD0.y - floor(
					    (tmpvar_3 * tmpvar_4)
					  )) * (1.0/(tmpvar_5)));
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = (texture2D (_MainTex, spriteUV_2) * xlv_COLOR0);
					  lowp float x_7;
					  x_7 = (tmpvar_6.w - _Cutoff);
					  if ((x_7 < 0.0)) {
					    discard;
					  };
					  mediump vec4 outDiffuseOcclusion_8;
					  mediump vec4 outNormal_9;
					  mediump vec4 emission_10;
					  lowp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = vec3(0.0, 0.0, 0.0);
					  outDiffuseOcclusion_8 = tmpvar_11;
					  lowp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = ((tmpvar_1 * 0.5) + 0.5);
					  outNormal_9 = tmpvar_12;
					  lowp vec4 tmpvar_13;
					  tmpvar_13.w = 1.0;
					  tmpvar_13.xyz = tmpvar_6.xyz;
					  emission_10 = tmpvar_13;
					  emission_10.xyz = emission_10.xyz;
					  gl_FragData[0] = outDiffuseOcclusion_8;
					  gl_FragData[1] = vec4(0.0, 0.0, 0.0, 0.0);
					  gl_FragData[2] = outNormal_9;
					  gl_FragData[3] = emission_10;
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp vec3 u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat10_2.x = u_xlat10_0.w * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
					    SV_Target3.xyz = u_xlat16_0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2.x<0.0);
					#else
					    u_xlatb0 = u_xlat10_2.x<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp vec3 u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat10_2.x = u_xlat10_0.w * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
					    SV_Target3.xyz = u_xlat16_0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2.x<0.0);
					#else
					    u_xlatb0 = u_xlat10_2.x<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
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
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					layout(location = 1) out mediump vec4 SV_Target1;
					layout(location = 2) out mediump vec4 SV_Target2;
					layout(location = 3) out mediump vec4 SV_Target3;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp vec3 u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD0.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD0.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy);
					    u_xlat10_2.x = u_xlat10_0.w * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
					    SV_Target3.xyz = u_xlat16_0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2.x<0.0);
					#else
					    u_xlatb0 = u_xlat10_2.x<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
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
 Pass {
  Name "SHADOWCASTER"
  Tags { "LIGHTMODE"="SHADOWCASTER" "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "SHADOWSUPPORT"="true" "RenderType"="TransparentCutout" }
  GpuProgramID 377642
Program "vp" {
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform highp vec4 unity_LightShadowBias;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = _glesColor;
					  highp vec2 tmpvar_2;
					  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  highp vec3 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp vec3 vertex_4;
					  vertex_4 = _glesVertex.xyz;
					  highp vec4 clipPos_5;
					  if ((unity_LightShadowBias.z != 0.0)) {
					    highp vec4 tmpvar_6;
					    tmpvar_6.w = 1.0;
					    tmpvar_6.xyz = vertex_4;
					    highp vec3 tmpvar_7;
					    tmpvar_7 = (unity_ObjectToWorld * tmpvar_6).xyz;
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
					    highp vec3 tmpvar_11;
					    tmpvar_11 = normalize(((
					      (v_8.xyz * _glesNormal.x)
					     + 
					      (v_9.xyz * _glesNormal.y)
					    ) + (v_10.xyz * _glesNormal.z)));
					    highp float tmpvar_12;
					    tmpvar_12 = dot (tmpvar_11, normalize((_WorldSpaceLightPos0.xyz - 
					      (tmpvar_7 * _WorldSpaceLightPos0.w)
					    )));
					    highp vec4 tmpvar_13;
					    tmpvar_13.w = 1.0;
					    tmpvar_13.xyz = (tmpvar_7 - (tmpvar_11 * (unity_LightShadowBias.z * 
					      sqrt((1.0 - (tmpvar_12 * tmpvar_12)))
					    )));
					    clipPos_5 = (unity_MatrixVP * tmpvar_13);
					  } else {
					    highp vec4 tmpvar_14;
					    tmpvar_14.w = 1.0;
					    tmpvar_14.xyz = vertex_4;
					    clipPos_5 = (glstate_matrix_mvp * tmpvar_14);
					  };
					  highp vec4 clipPos_15;
					  clipPos_15.xyw = clipPos_5.xyw;
					  clipPos_15.z = (clipPos_5.z + clamp ((unity_LightShadowBias.x / clipPos_5.w), 0.0, 1.0));
					  clipPos_15.z = mix (clipPos_15.z, max (clipPos_15.z, -(clipPos_5.w)), unity_LightShadowBias.y);
					  gl_Position = clipPos_15;
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_3;
					  xlv_COLOR0 = tmpvar_1;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec2 spriteUV_1;
					  highp float tmpvar_2;
					  tmpvar_2 = fract((_Time.y * _Speed));
					  highp float tmpvar_3;
					  tmpvar_3 = float(_XFrames);
					  highp float tmpvar_4;
					  tmpvar_4 = float(_YFrames);
					  spriteUV_1.x = ((xlv_TEXCOORD1.x + floor(
					    ((tmpvar_2 * tmpvar_3) * tmpvar_4)
					  )) * (1.0/(tmpvar_3)));
					  spriteUV_1.y = ((xlv_TEXCOORD1.y - floor(
					    (tmpvar_2 * tmpvar_3)
					  )) * (1.0/(tmpvar_4)));
					  lowp float x_5;
					  x_5 = ((texture2D (_MainTex, spriteUV_1) * xlv_COLOR0).w - _Cutoff);
					  if ((x_5 < 0.0)) {
					    discard;
					  };
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
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform highp vec4 unity_LightShadowBias;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = _glesColor;
					  highp vec2 tmpvar_2;
					  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  highp vec3 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp vec3 vertex_4;
					  vertex_4 = _glesVertex.xyz;
					  highp vec4 clipPos_5;
					  if ((unity_LightShadowBias.z != 0.0)) {
					    highp vec4 tmpvar_6;
					    tmpvar_6.w = 1.0;
					    tmpvar_6.xyz = vertex_4;
					    highp vec3 tmpvar_7;
					    tmpvar_7 = (unity_ObjectToWorld * tmpvar_6).xyz;
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
					    highp vec3 tmpvar_11;
					    tmpvar_11 = normalize(((
					      (v_8.xyz * _glesNormal.x)
					     + 
					      (v_9.xyz * _glesNormal.y)
					    ) + (v_10.xyz * _glesNormal.z)));
					    highp float tmpvar_12;
					    tmpvar_12 = dot (tmpvar_11, normalize((_WorldSpaceLightPos0.xyz - 
					      (tmpvar_7 * _WorldSpaceLightPos0.w)
					    )));
					    highp vec4 tmpvar_13;
					    tmpvar_13.w = 1.0;
					    tmpvar_13.xyz = (tmpvar_7 - (tmpvar_11 * (unity_LightShadowBias.z * 
					      sqrt((1.0 - (tmpvar_12 * tmpvar_12)))
					    )));
					    clipPos_5 = (unity_MatrixVP * tmpvar_13);
					  } else {
					    highp vec4 tmpvar_14;
					    tmpvar_14.w = 1.0;
					    tmpvar_14.xyz = vertex_4;
					    clipPos_5 = (glstate_matrix_mvp * tmpvar_14);
					  };
					  highp vec4 clipPos_15;
					  clipPos_15.xyw = clipPos_5.xyw;
					  clipPos_15.z = (clipPos_5.z + clamp ((unity_LightShadowBias.x / clipPos_5.w), 0.0, 1.0));
					  clipPos_15.z = mix (clipPos_15.z, max (clipPos_15.z, -(clipPos_5.w)), unity_LightShadowBias.y);
					  gl_Position = clipPos_15;
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_3;
					  xlv_COLOR0 = tmpvar_1;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec2 spriteUV_1;
					  highp float tmpvar_2;
					  tmpvar_2 = fract((_Time.y * _Speed));
					  highp float tmpvar_3;
					  tmpvar_3 = float(_XFrames);
					  highp float tmpvar_4;
					  tmpvar_4 = float(_YFrames);
					  spriteUV_1.x = ((xlv_TEXCOORD1.x + floor(
					    ((tmpvar_2 * tmpvar_3) * tmpvar_4)
					  )) * (1.0/(tmpvar_3)));
					  spriteUV_1.y = ((xlv_TEXCOORD1.y - floor(
					    (tmpvar_2 * tmpvar_3)
					  )) * (1.0/(tmpvar_4)));
					  lowp float x_5;
					  x_5 = ((texture2D (_MainTex, spriteUV_1) * xlv_COLOR0).w - _Cutoff);
					  if ((x_5 < 0.0)) {
					    discard;
					  };
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
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform highp vec4 unity_LightShadowBias;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = _glesColor;
					  highp vec2 tmpvar_2;
					  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  highp vec3 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp vec3 vertex_4;
					  vertex_4 = _glesVertex.xyz;
					  highp vec4 clipPos_5;
					  if ((unity_LightShadowBias.z != 0.0)) {
					    highp vec4 tmpvar_6;
					    tmpvar_6.w = 1.0;
					    tmpvar_6.xyz = vertex_4;
					    highp vec3 tmpvar_7;
					    tmpvar_7 = (unity_ObjectToWorld * tmpvar_6).xyz;
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
					    highp vec3 tmpvar_11;
					    tmpvar_11 = normalize(((
					      (v_8.xyz * _glesNormal.x)
					     + 
					      (v_9.xyz * _glesNormal.y)
					    ) + (v_10.xyz * _glesNormal.z)));
					    highp float tmpvar_12;
					    tmpvar_12 = dot (tmpvar_11, normalize((_WorldSpaceLightPos0.xyz - 
					      (tmpvar_7 * _WorldSpaceLightPos0.w)
					    )));
					    highp vec4 tmpvar_13;
					    tmpvar_13.w = 1.0;
					    tmpvar_13.xyz = (tmpvar_7 - (tmpvar_11 * (unity_LightShadowBias.z * 
					      sqrt((1.0 - (tmpvar_12 * tmpvar_12)))
					    )));
					    clipPos_5 = (unity_MatrixVP * tmpvar_13);
					  } else {
					    highp vec4 tmpvar_14;
					    tmpvar_14.w = 1.0;
					    tmpvar_14.xyz = vertex_4;
					    clipPos_5 = (glstate_matrix_mvp * tmpvar_14);
					  };
					  highp vec4 clipPos_15;
					  clipPos_15.xyw = clipPos_5.xyw;
					  clipPos_15.z = (clipPos_5.z + clamp ((unity_LightShadowBias.x / clipPos_5.w), 0.0, 1.0));
					  clipPos_15.z = mix (clipPos_15.z, max (clipPos_15.z, -(clipPos_5.w)), unity_LightShadowBias.y);
					  gl_Position = clipPos_15;
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_3;
					  xlv_COLOR0 = tmpvar_1;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec2 spriteUV_1;
					  highp float tmpvar_2;
					  tmpvar_2 = fract((_Time.y * _Speed));
					  highp float tmpvar_3;
					  tmpvar_3 = float(_XFrames);
					  highp float tmpvar_4;
					  tmpvar_4 = float(_YFrames);
					  spriteUV_1.x = ((xlv_TEXCOORD1.x + floor(
					    ((tmpvar_2 * tmpvar_3) * tmpvar_4)
					  )) * (1.0/(tmpvar_3)));
					  spriteUV_1.y = ((xlv_TEXCOORD1.y - floor(
					    (tmpvar_2 * tmpvar_3)
					  )) * (1.0/(tmpvar_4)));
					  lowp float x_5;
					  x_5 = ((texture2D (_MainTex, spriteUV_1) * xlv_COLOR0).w - _Cutoff);
					  if ((x_5 < 0.0)) {
					    discard;
					  };
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
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
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
					    u_xlat2.xyz = u_xlat1.xyz + hlslcc_mtx4unity_ObjectToWorld[3].xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
					    u_xlat9 = sqrt(u_xlat9);
					    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat2.xyz;
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
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp float u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD1.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD1.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy).w;
					    u_xlat10_2 = u_xlat10_0 * vs_COLOR0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
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
					    u_xlat2.xyz = u_xlat1.xyz + hlslcc_mtx4unity_ObjectToWorld[3].xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
					    u_xlat9 = sqrt(u_xlat9);
					    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat2.xyz;
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
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp float u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD1.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD1.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy).w;
					    u_xlat10_2 = u_xlat10_0 * vs_COLOR0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
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
					    u_xlat2.xyz = u_xlat1.xyz + hlslcc_mtx4unity_ObjectToWorld[3].xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat2.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
					    u_xlat9 = sqrt(u_xlat9);
					    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat2.xyz;
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
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp float u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD1.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD1.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy).w;
					    u_xlat10_2 = u_xlat10_0 * vs_COLOR0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _LightPositionRange;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp vec4 _MainTex_ST;
					varying highp vec3 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.w = 1.0;
					  tmpvar_1.xyz = _glesVertex.xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD0 = (tmpvar_2.xyz - _LightPositionRange.xyz);
					  gl_Position = (glstate_matrix_mvp * tmpvar_1);
					  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD2 = tmpvar_2.xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec4 _LightPositionRange;
					uniform highp vec4 unity_LightShadowBias;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec3 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  highp vec2 spriteUV_2;
					  highp float tmpvar_3;
					  tmpvar_3 = fract((_Time.y * _Speed));
					  highp float tmpvar_4;
					  tmpvar_4 = float(_XFrames);
					  highp float tmpvar_5;
					  tmpvar_5 = float(_YFrames);
					  spriteUV_2.x = ((xlv_TEXCOORD1.x + floor(
					    ((tmpvar_3 * tmpvar_4) * tmpvar_5)
					  )) * (1.0/(tmpvar_4)));
					  spriteUV_2.y = ((xlv_TEXCOORD1.y - floor(
					    (tmpvar_3 * tmpvar_4)
					  )) * (1.0/(tmpvar_5)));
					  lowp float x_6;
					  x_6 = ((texture2D (_MainTex, spriteUV_2) * xlv_COLOR0).w - _Cutoff);
					  if ((x_6 < 0.0)) {
					    discard;
					  };
					  highp vec4 enc_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
					    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
					  , 0.999)));
					  enc_7 = (tmpvar_8 - (tmpvar_8.yzww * 0.003921569));
					  tmpvar_1 = enc_7;
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
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _LightPositionRange;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp vec4 _MainTex_ST;
					varying highp vec3 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.w = 1.0;
					  tmpvar_1.xyz = _glesVertex.xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD0 = (tmpvar_2.xyz - _LightPositionRange.xyz);
					  gl_Position = (glstate_matrix_mvp * tmpvar_1);
					  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD2 = tmpvar_2.xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec4 _LightPositionRange;
					uniform highp vec4 unity_LightShadowBias;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec3 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  highp vec2 spriteUV_2;
					  highp float tmpvar_3;
					  tmpvar_3 = fract((_Time.y * _Speed));
					  highp float tmpvar_4;
					  tmpvar_4 = float(_XFrames);
					  highp float tmpvar_5;
					  tmpvar_5 = float(_YFrames);
					  spriteUV_2.x = ((xlv_TEXCOORD1.x + floor(
					    ((tmpvar_3 * tmpvar_4) * tmpvar_5)
					  )) * (1.0/(tmpvar_4)));
					  spriteUV_2.y = ((xlv_TEXCOORD1.y - floor(
					    (tmpvar_3 * tmpvar_4)
					  )) * (1.0/(tmpvar_5)));
					  lowp float x_6;
					  x_6 = ((texture2D (_MainTex, spriteUV_2) * xlv_COLOR0).w - _Cutoff);
					  if ((x_6 < 0.0)) {
					    discard;
					  };
					  highp vec4 enc_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
					    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
					  , 0.999)));
					  enc_7 = (tmpvar_8 - (tmpvar_8.yzww * 0.003921569));
					  tmpvar_1 = enc_7;
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
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _LightPositionRange;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp vec4 _MainTex_ST;
					varying highp vec3 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.w = 1.0;
					  tmpvar_1.xyz = _glesVertex.xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD0 = (tmpvar_2.xyz - _LightPositionRange.xyz);
					  gl_Position = (glstate_matrix_mvp * tmpvar_1);
					  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD2 = tmpvar_2.xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec4 _LightPositionRange;
					uniform highp vec4 unity_LightShadowBias;
					uniform sampler2D _MainTex;
					uniform highp int _XFrames;
					uniform highp int _YFrames;
					uniform highp float _Speed;
					uniform lowp float _Cutoff;
					varying highp vec3 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  highp vec2 spriteUV_2;
					  highp float tmpvar_3;
					  tmpvar_3 = fract((_Time.y * _Speed));
					  highp float tmpvar_4;
					  tmpvar_4 = float(_XFrames);
					  highp float tmpvar_5;
					  tmpvar_5 = float(_YFrames);
					  spriteUV_2.x = ((xlv_TEXCOORD1.x + floor(
					    ((tmpvar_3 * tmpvar_4) * tmpvar_5)
					  )) * (1.0/(tmpvar_4)));
					  spriteUV_2.y = ((xlv_TEXCOORD1.y - floor(
					    (tmpvar_3 * tmpvar_4)
					  )) * (1.0/(tmpvar_5)));
					  lowp float x_6;
					  x_6 = ((texture2D (_MainTex, spriteUV_2) * xlv_COLOR0).w - _Cutoff);
					  if ((x_6 < 0.0)) {
					    discard;
					  };
					  highp vec4 enc_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
					    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
					  , 0.999)));
					  enc_7 = (tmpvar_8 - (tmpvar_8.yzww * 0.003921569));
					  tmpvar_1 = enc_7;
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
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz + (-_LightPositionRange.xyz);
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec4 _LightPositionRange;
					uniform 	vec4 unity_LightShadowBias;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec3 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp float u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD1.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD1.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy).w;
					    u_xlat10_2 = u_xlat10_0 * vs_COLOR0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz + (-_LightPositionRange.xyz);
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec4 _LightPositionRange;
					uniform 	vec4 unity_LightShadowBias;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec3 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp float u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD1.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD1.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy).w;
					    u_xlat10_2 = u_xlat10_0 * vs_COLOR0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out highp vec3 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out lowp vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz + (-_LightPositionRange.xyz);
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec4 _LightPositionRange;
					uniform 	vec4 unity_LightShadowBias;
					uniform 	int _XFrames;
					uniform 	int _YFrames;
					uniform 	float _Speed;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec3 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in lowp vec4 vs_COLOR0;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp float u_xlat10_0;
					bool u_xlatb0;
					vec2 u_xlat1;
					lowp float u_xlat10_2;
					vec2 u_xlat3;
					void main()
					{
					    u_xlat0.x = _Time.y * _Speed;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat3.xy = vec2(ivec2(_XFrames, _YFrames));
					    u_xlat0.x = u_xlat3.x * u_xlat0.x;
					    u_xlat0.w = u_xlat3.y * u_xlat0.x;
					    u_xlat0.xw = floor(u_xlat0.xw);
					    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD1.y;
					    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
					    u_xlat0.w = u_xlat0.w + vs_TEXCOORD1.x;
					    u_xlat1.xy = u_xlat3.xy * u_xlat0.wx;
					    u_xlat10_0 = texture(_MainTex, u_xlat1.xy).w;
					    u_xlat10_2 = u_xlat10_0 * vs_COLOR0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat10_2<0.0);
					#else
					    u_xlatb0 = u_xlat10_2<0.0;
					#endif
					    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
}