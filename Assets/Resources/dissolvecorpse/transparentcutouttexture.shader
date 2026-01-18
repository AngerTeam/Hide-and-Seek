Shader "TransparentCutoutTexture" {
Properties {
 _Color ("Main Color", Color) = (1.000000,1.000000,1.000000,1.000000)
 _MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
 _CutTex ("Cutout (A)", 2D) = "white" { }
 _Cutoff ("Alpha cutoff", Range(0.000000,1.000000)) = 0.500000
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
  GpuProgramID 61944
Program "vp" {
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
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
					uniform highp vec4 _CutTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  highp vec4 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _CutTex_ST.xy) + _CutTex_ST.zw);
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
					  tmpvar_3 = worldNormal_1;
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
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), res_11);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _CutTex;
					uniform lowp vec4 _Color;
					uniform highp float _Cutoff;
					varying highp vec4 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp float tmpvar_2;
					  highp float ca_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color);
					  lowp float tmpvar_5;
					  tmpvar_5 = texture2D (_CutTex, xlv_TEXCOORD0.zw).w;
					  ca_3 = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = max (sign((ca_3 - _Cutoff)), 0.0);
					  tmpvar_2 = (tmpvar_4.w * tmpvar_6);
					  lowp vec4 c_7;
					  lowp vec4 c_8;
					  c_8.xyz = vec3(0.0, 0.0, 0.0);
					  c_8.w = tmpvar_2;
					  c_7.w = c_8.w;
					  c_7.xyz = c_8.xyz;
					  c_1.w = c_7.w;
					  c_1.xyz = tmpvar_4.xyz;
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
					uniform highp vec4 _CutTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  highp vec4 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _CutTex_ST.xy) + _CutTex_ST.zw);
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
					  tmpvar_3 = worldNormal_1;
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
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), res_11);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _CutTex;
					uniform lowp vec4 _Color;
					uniform highp float _Cutoff;
					varying highp vec4 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp float tmpvar_2;
					  highp float ca_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color);
					  lowp float tmpvar_5;
					  tmpvar_5 = texture2D (_CutTex, xlv_TEXCOORD0.zw).w;
					  ca_3 = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = max (sign((ca_3 - _Cutoff)), 0.0);
					  tmpvar_2 = (tmpvar_4.w * tmpvar_6);
					  lowp vec4 c_7;
					  lowp vec4 c_8;
					  c_8.xyz = vec3(0.0, 0.0, 0.0);
					  c_8.w = tmpvar_2;
					  c_7.w = c_8.w;
					  c_7.xyz = c_8.xyz;
					  c_1.w = c_7.w;
					  c_1.xyz = tmpvar_4.xyz;
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
					uniform highp vec4 _CutTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  highp vec4 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _CutTex_ST.xy) + _CutTex_ST.zw);
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
					  tmpvar_3 = worldNormal_1;
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
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), res_11);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _CutTex;
					uniform lowp vec4 _Color;
					uniform highp float _Cutoff;
					varying highp vec4 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp float tmpvar_2;
					  highp float ca_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color);
					  lowp float tmpvar_5;
					  tmpvar_5 = texture2D (_CutTex, xlv_TEXCOORD0.zw).w;
					  ca_3 = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = max (sign((ca_3 - _Cutoff)), 0.0);
					  tmpvar_2 = (tmpvar_4.w * tmpvar_6);
					  lowp vec4 c_7;
					  lowp vec4 c_8;
					  c_8.xyz = vec3(0.0, 0.0, 0.0);
					  c_8.w = tmpvar_2;
					  c_7.w = c_8.w;
					  c_7.xyz = c_8.xyz;
					  c_1.w = c_7.w;
					  c_1.xyz = tmpvar_4.xyz;
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
					uniform 	vec4 _CutTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _CutTex_ST.xy + _CutTex_ST.zw;
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
					uniform 	lowp vec4 _Color;
					uniform 	float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _CutTex;
					in highp vec4 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					float u_xlat0;
					lowp float u_xlat10_0;
					int u_xlati0;
					vec4 u_xlat1;
					lowp vec4 u_xlat10_1;
					int u_xlati2;
					void main()
					{
					    u_xlat10_0 = texture(_CutTex, vs_TEXCOORD0.zw).w;
					    u_xlat0 = u_xlat10_0 + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = 0.0<u_xlat0; u_xlati2 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati2 = int((0.0<u_xlat0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = u_xlat0<0.0; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati0 = int((u_xlat0<0.0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					    u_xlati0 = (-u_xlati2) + u_xlati0;
					    u_xlat0 = float(u_xlati0);
					    u_xlat0 = max(u_xlat0, 0.0);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = u_xlat10_1 * _Color;
					    u_xlat1.w = u_xlat0 * u_xlat1.w;
					    SV_Target0 = u_xlat1;
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
					uniform 	vec4 _CutTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _CutTex_ST.xy + _CutTex_ST.zw;
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
					uniform 	lowp vec4 _Color;
					uniform 	float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _CutTex;
					in highp vec4 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					float u_xlat0;
					lowp float u_xlat10_0;
					int u_xlati0;
					vec4 u_xlat1;
					lowp vec4 u_xlat10_1;
					int u_xlati2;
					void main()
					{
					    u_xlat10_0 = texture(_CutTex, vs_TEXCOORD0.zw).w;
					    u_xlat0 = u_xlat10_0 + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = 0.0<u_xlat0; u_xlati2 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati2 = int((0.0<u_xlat0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = u_xlat0<0.0; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati0 = int((u_xlat0<0.0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					    u_xlati0 = (-u_xlati2) + u_xlati0;
					    u_xlat0 = float(u_xlati0);
					    u_xlat0 = max(u_xlat0, 0.0);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = u_xlat10_1 * _Color;
					    u_xlat1.w = u_xlat0 * u_xlat1.w;
					    SV_Target0 = u_xlat1;
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
					uniform 	vec4 _CutTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _CutTex_ST.xy + _CutTex_ST.zw;
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
					uniform 	lowp vec4 _Color;
					uniform 	float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _CutTex;
					in highp vec4 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					float u_xlat0;
					lowp float u_xlat10_0;
					int u_xlati0;
					vec4 u_xlat1;
					lowp vec4 u_xlat10_1;
					int u_xlati2;
					void main()
					{
					    u_xlat10_0 = texture(_CutTex, vs_TEXCOORD0.zw).w;
					    u_xlat0 = u_xlat10_0 + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = 0.0<u_xlat0; u_xlati2 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati2 = int((0.0<u_xlat0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = u_xlat0<0.0; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati0 = int((u_xlat0<0.0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					    u_xlati0 = (-u_xlati2) + u_xlati0;
					    u_xlat0 = float(u_xlati0);
					    u_xlat0 = max(u_xlat0, 0.0);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = u_xlat10_1 * _Color;
					    u_xlat1.w = u_xlat0 * u_xlat1.w;
					    SV_Target0 = u_xlat1;
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
					uniform highp vec4 _CutTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  highp vec4 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  mediump vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _CutTex_ST.xy) + _CutTex_ST.zw);
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].x;
					  v_7.y = unity_WorldToObject[1].x;
					  v_7.z = unity_WorldToObject[2].x;
					  v_7.w = unity_WorldToObject[3].x;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].y;
					  v_8.y = unity_WorldToObject[1].y;
					  v_8.z = unity_WorldToObject[2].y;
					  v_8.w = unity_WorldToObject[3].y;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].z;
					  v_9.y = unity_WorldToObject[1].z;
					  v_9.z = unity_WorldToObject[2].z;
					  v_9.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize(((
					    (v_7.xyz * _glesNormal.x)
					   + 
					    (v_8.xyz * _glesNormal.y)
					  ) + (v_9.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_10;
					  tmpvar_3 = worldNormal_1;
					  highp vec3 lightColor0_11;
					  lightColor0_11 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_12;
					  lightColor1_12 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_13;
					  lightColor2_13 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_14;
					  lightColor3_14 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_15;
					  lightAttenSq_15 = unity_4LightAtten0;
					  highp vec3 normal_16;
					  normal_16 = worldNormal_1;
					  highp vec3 col_17;
					  highp vec4 ndotl_18;
					  highp vec4 lengthSq_19;
					  highp vec4 tmpvar_20;
					  tmpvar_20 = (unity_4LightPosX0 - tmpvar_6.x);
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (unity_4LightPosY0 - tmpvar_6.y);
					  highp vec4 tmpvar_22;
					  tmpvar_22 = (unity_4LightPosZ0 - tmpvar_6.z);
					  lengthSq_19 = (tmpvar_20 * tmpvar_20);
					  lengthSq_19 = (lengthSq_19 + (tmpvar_21 * tmpvar_21));
					  lengthSq_19 = (lengthSq_19 + (tmpvar_22 * tmpvar_22));
					  ndotl_18 = (tmpvar_20 * normal_16.x);
					  ndotl_18 = (ndotl_18 + (tmpvar_21 * normal_16.y));
					  ndotl_18 = (ndotl_18 + (tmpvar_22 * normal_16.z));
					  highp vec4 tmpvar_23;
					  tmpvar_23 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_18 * inversesqrt(lengthSq_19)));
					  ndotl_18 = tmpvar_23;
					  highp vec4 tmpvar_24;
					  tmpvar_24 = (tmpvar_23 * (1.0/((1.0 + 
					    (lengthSq_19 * lightAttenSq_15)
					  ))));
					  col_17 = (lightColor0_11 * tmpvar_24.x);
					  col_17 = (col_17 + (lightColor1_12 * tmpvar_24.y));
					  col_17 = (col_17 + (lightColor2_13 * tmpvar_24.z));
					  col_17 = (col_17 + (lightColor3_14 * tmpvar_24.w));
					  tmpvar_4 = col_17;
					  mediump vec3 normal_25;
					  normal_25 = worldNormal_1;
					  mediump vec3 ambient_26;
					  mediump vec4 tmpvar_27;
					  tmpvar_27.w = 1.0;
					  tmpvar_27.xyz = normal_25;
					  mediump vec3 res_28;
					  mediump vec3 x_29;
					  x_29.x = dot (unity_SHAr, tmpvar_27);
					  x_29.y = dot (unity_SHAg, tmpvar_27);
					  x_29.z = dot (unity_SHAb, tmpvar_27);
					  mediump vec3 x1_30;
					  mediump vec4 tmpvar_31;
					  tmpvar_31 = (normal_25.xyzz * normal_25.yzzx);
					  x1_30.x = dot (unity_SHBr, tmpvar_31);
					  x1_30.y = dot (unity_SHBg, tmpvar_31);
					  x1_30.z = dot (unity_SHBb, tmpvar_31);
					  res_28 = (x_29 + (x1_30 + (unity_SHC.xyz * 
					    ((normal_25.x * normal_25.x) - (normal_25.y * normal_25.y))
					  )));
					  res_28 = max (((1.055 * 
					    pow (max (res_28, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  ambient_26 = (tmpvar_4 + max (vec3(0.0, 0.0, 0.0), res_28));
					  tmpvar_4 = ambient_26;
					  gl_Position = (glstate_matrix_mvp * tmpvar_5);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_6;
					  xlv_TEXCOORD3 = ambient_26;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _CutTex;
					uniform lowp vec4 _Color;
					uniform highp float _Cutoff;
					varying highp vec4 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp float tmpvar_2;
					  highp float ca_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color);
					  lowp float tmpvar_5;
					  tmpvar_5 = texture2D (_CutTex, xlv_TEXCOORD0.zw).w;
					  ca_3 = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = max (sign((ca_3 - _Cutoff)), 0.0);
					  tmpvar_2 = (tmpvar_4.w * tmpvar_6);
					  lowp vec4 c_7;
					  lowp vec4 c_8;
					  c_8.xyz = vec3(0.0, 0.0, 0.0);
					  c_8.w = tmpvar_2;
					  c_7.w = c_8.w;
					  c_7.xyz = c_8.xyz;
					  c_1.w = c_7.w;
					  c_1.xyz = tmpvar_4.xyz;
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
					uniform highp vec4 _CutTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  highp vec4 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  mediump vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _CutTex_ST.xy) + _CutTex_ST.zw);
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].x;
					  v_7.y = unity_WorldToObject[1].x;
					  v_7.z = unity_WorldToObject[2].x;
					  v_7.w = unity_WorldToObject[3].x;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].y;
					  v_8.y = unity_WorldToObject[1].y;
					  v_8.z = unity_WorldToObject[2].y;
					  v_8.w = unity_WorldToObject[3].y;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].z;
					  v_9.y = unity_WorldToObject[1].z;
					  v_9.z = unity_WorldToObject[2].z;
					  v_9.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize(((
					    (v_7.xyz * _glesNormal.x)
					   + 
					    (v_8.xyz * _glesNormal.y)
					  ) + (v_9.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_10;
					  tmpvar_3 = worldNormal_1;
					  highp vec3 lightColor0_11;
					  lightColor0_11 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_12;
					  lightColor1_12 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_13;
					  lightColor2_13 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_14;
					  lightColor3_14 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_15;
					  lightAttenSq_15 = unity_4LightAtten0;
					  highp vec3 normal_16;
					  normal_16 = worldNormal_1;
					  highp vec3 col_17;
					  highp vec4 ndotl_18;
					  highp vec4 lengthSq_19;
					  highp vec4 tmpvar_20;
					  tmpvar_20 = (unity_4LightPosX0 - tmpvar_6.x);
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (unity_4LightPosY0 - tmpvar_6.y);
					  highp vec4 tmpvar_22;
					  tmpvar_22 = (unity_4LightPosZ0 - tmpvar_6.z);
					  lengthSq_19 = (tmpvar_20 * tmpvar_20);
					  lengthSq_19 = (lengthSq_19 + (tmpvar_21 * tmpvar_21));
					  lengthSq_19 = (lengthSq_19 + (tmpvar_22 * tmpvar_22));
					  ndotl_18 = (tmpvar_20 * normal_16.x);
					  ndotl_18 = (ndotl_18 + (tmpvar_21 * normal_16.y));
					  ndotl_18 = (ndotl_18 + (tmpvar_22 * normal_16.z));
					  highp vec4 tmpvar_23;
					  tmpvar_23 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_18 * inversesqrt(lengthSq_19)));
					  ndotl_18 = tmpvar_23;
					  highp vec4 tmpvar_24;
					  tmpvar_24 = (tmpvar_23 * (1.0/((1.0 + 
					    (lengthSq_19 * lightAttenSq_15)
					  ))));
					  col_17 = (lightColor0_11 * tmpvar_24.x);
					  col_17 = (col_17 + (lightColor1_12 * tmpvar_24.y));
					  col_17 = (col_17 + (lightColor2_13 * tmpvar_24.z));
					  col_17 = (col_17 + (lightColor3_14 * tmpvar_24.w));
					  tmpvar_4 = col_17;
					  mediump vec3 normal_25;
					  normal_25 = worldNormal_1;
					  mediump vec3 ambient_26;
					  mediump vec4 tmpvar_27;
					  tmpvar_27.w = 1.0;
					  tmpvar_27.xyz = normal_25;
					  mediump vec3 res_28;
					  mediump vec3 x_29;
					  x_29.x = dot (unity_SHAr, tmpvar_27);
					  x_29.y = dot (unity_SHAg, tmpvar_27);
					  x_29.z = dot (unity_SHAb, tmpvar_27);
					  mediump vec3 x1_30;
					  mediump vec4 tmpvar_31;
					  tmpvar_31 = (normal_25.xyzz * normal_25.yzzx);
					  x1_30.x = dot (unity_SHBr, tmpvar_31);
					  x1_30.y = dot (unity_SHBg, tmpvar_31);
					  x1_30.z = dot (unity_SHBb, tmpvar_31);
					  res_28 = (x_29 + (x1_30 + (unity_SHC.xyz * 
					    ((normal_25.x * normal_25.x) - (normal_25.y * normal_25.y))
					  )));
					  res_28 = max (((1.055 * 
					    pow (max (res_28, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  ambient_26 = (tmpvar_4 + max (vec3(0.0, 0.0, 0.0), res_28));
					  tmpvar_4 = ambient_26;
					  gl_Position = (glstate_matrix_mvp * tmpvar_5);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_6;
					  xlv_TEXCOORD3 = ambient_26;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _CutTex;
					uniform lowp vec4 _Color;
					uniform highp float _Cutoff;
					varying highp vec4 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp float tmpvar_2;
					  highp float ca_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color);
					  lowp float tmpvar_5;
					  tmpvar_5 = texture2D (_CutTex, xlv_TEXCOORD0.zw).w;
					  ca_3 = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = max (sign((ca_3 - _Cutoff)), 0.0);
					  tmpvar_2 = (tmpvar_4.w * tmpvar_6);
					  lowp vec4 c_7;
					  lowp vec4 c_8;
					  c_8.xyz = vec3(0.0, 0.0, 0.0);
					  c_8.w = tmpvar_2;
					  c_7.w = c_8.w;
					  c_7.xyz = c_8.xyz;
					  c_1.w = c_7.w;
					  c_1.xyz = tmpvar_4.xyz;
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
					uniform highp vec4 _CutTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying mediump vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  highp vec4 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  mediump vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _CutTex_ST.xy) + _CutTex_ST.zw);
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].x;
					  v_7.y = unity_WorldToObject[1].x;
					  v_7.z = unity_WorldToObject[2].x;
					  v_7.w = unity_WorldToObject[3].x;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].y;
					  v_8.y = unity_WorldToObject[1].y;
					  v_8.z = unity_WorldToObject[2].y;
					  v_8.w = unity_WorldToObject[3].y;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].z;
					  v_9.y = unity_WorldToObject[1].z;
					  v_9.z = unity_WorldToObject[2].z;
					  v_9.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize(((
					    (v_7.xyz * _glesNormal.x)
					   + 
					    (v_8.xyz * _glesNormal.y)
					  ) + (v_9.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_10;
					  tmpvar_3 = worldNormal_1;
					  highp vec3 lightColor0_11;
					  lightColor0_11 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_12;
					  lightColor1_12 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_13;
					  lightColor2_13 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_14;
					  lightColor3_14 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_15;
					  lightAttenSq_15 = unity_4LightAtten0;
					  highp vec3 normal_16;
					  normal_16 = worldNormal_1;
					  highp vec3 col_17;
					  highp vec4 ndotl_18;
					  highp vec4 lengthSq_19;
					  highp vec4 tmpvar_20;
					  tmpvar_20 = (unity_4LightPosX0 - tmpvar_6.x);
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (unity_4LightPosY0 - tmpvar_6.y);
					  highp vec4 tmpvar_22;
					  tmpvar_22 = (unity_4LightPosZ0 - tmpvar_6.z);
					  lengthSq_19 = (tmpvar_20 * tmpvar_20);
					  lengthSq_19 = (lengthSq_19 + (tmpvar_21 * tmpvar_21));
					  lengthSq_19 = (lengthSq_19 + (tmpvar_22 * tmpvar_22));
					  ndotl_18 = (tmpvar_20 * normal_16.x);
					  ndotl_18 = (ndotl_18 + (tmpvar_21 * normal_16.y));
					  ndotl_18 = (ndotl_18 + (tmpvar_22 * normal_16.z));
					  highp vec4 tmpvar_23;
					  tmpvar_23 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_18 * inversesqrt(lengthSq_19)));
					  ndotl_18 = tmpvar_23;
					  highp vec4 tmpvar_24;
					  tmpvar_24 = (tmpvar_23 * (1.0/((1.0 + 
					    (lengthSq_19 * lightAttenSq_15)
					  ))));
					  col_17 = (lightColor0_11 * tmpvar_24.x);
					  col_17 = (col_17 + (lightColor1_12 * tmpvar_24.y));
					  col_17 = (col_17 + (lightColor2_13 * tmpvar_24.z));
					  col_17 = (col_17 + (lightColor3_14 * tmpvar_24.w));
					  tmpvar_4 = col_17;
					  mediump vec3 normal_25;
					  normal_25 = worldNormal_1;
					  mediump vec3 ambient_26;
					  mediump vec4 tmpvar_27;
					  tmpvar_27.w = 1.0;
					  tmpvar_27.xyz = normal_25;
					  mediump vec3 res_28;
					  mediump vec3 x_29;
					  x_29.x = dot (unity_SHAr, tmpvar_27);
					  x_29.y = dot (unity_SHAg, tmpvar_27);
					  x_29.z = dot (unity_SHAb, tmpvar_27);
					  mediump vec3 x1_30;
					  mediump vec4 tmpvar_31;
					  tmpvar_31 = (normal_25.xyzz * normal_25.yzzx);
					  x1_30.x = dot (unity_SHBr, tmpvar_31);
					  x1_30.y = dot (unity_SHBg, tmpvar_31);
					  x1_30.z = dot (unity_SHBb, tmpvar_31);
					  res_28 = (x_29 + (x1_30 + (unity_SHC.xyz * 
					    ((normal_25.x * normal_25.x) - (normal_25.y * normal_25.y))
					  )));
					  res_28 = max (((1.055 * 
					    pow (max (res_28, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  ambient_26 = (tmpvar_4 + max (vec3(0.0, 0.0, 0.0), res_28));
					  tmpvar_4 = ambient_26;
					  gl_Position = (glstate_matrix_mvp * tmpvar_5);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_6;
					  xlv_TEXCOORD3 = ambient_26;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _CutTex;
					uniform lowp vec4 _Color;
					uniform highp float _Cutoff;
					varying highp vec4 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp float tmpvar_2;
					  highp float ca_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color);
					  lowp float tmpvar_5;
					  tmpvar_5 = texture2D (_CutTex, xlv_TEXCOORD0.zw).w;
					  ca_3 = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = max (sign((ca_3 - _Cutoff)), 0.0);
					  tmpvar_2 = (tmpvar_4.w * tmpvar_6);
					  lowp vec4 c_7;
					  lowp vec4 c_8;
					  c_8.xyz = vec3(0.0, 0.0, 0.0);
					  c_8.w = tmpvar_2;
					  c_7.w = c_8.w;
					  c_7.xyz = c_8.xyz;
					  c_1.w = c_7.w;
					  c_1.xyz = tmpvar_4.xyz;
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
					uniform 	vec4 _CutTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _CutTex_ST.xy + _CutTex_ST.zw;
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
					uniform 	lowp vec4 _Color;
					uniform 	float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _CutTex;
					in highp vec4 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					float u_xlat0;
					lowp float u_xlat10_0;
					int u_xlati0;
					vec4 u_xlat1;
					lowp vec4 u_xlat10_1;
					int u_xlati2;
					void main()
					{
					    u_xlat10_0 = texture(_CutTex, vs_TEXCOORD0.zw).w;
					    u_xlat0 = u_xlat10_0 + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = 0.0<u_xlat0; u_xlati2 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati2 = int((0.0<u_xlat0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = u_xlat0<0.0; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati0 = int((u_xlat0<0.0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					    u_xlati0 = (-u_xlati2) + u_xlati0;
					    u_xlat0 = float(u_xlati0);
					    u_xlat0 = max(u_xlat0, 0.0);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = u_xlat10_1 * _Color;
					    u_xlat1.w = u_xlat0 * u_xlat1.w;
					    SV_Target0 = u_xlat1;
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
					uniform 	vec4 _CutTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _CutTex_ST.xy + _CutTex_ST.zw;
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
					uniform 	lowp vec4 _Color;
					uniform 	float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _CutTex;
					in highp vec4 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					float u_xlat0;
					lowp float u_xlat10_0;
					int u_xlati0;
					vec4 u_xlat1;
					lowp vec4 u_xlat10_1;
					int u_xlati2;
					void main()
					{
					    u_xlat10_0 = texture(_CutTex, vs_TEXCOORD0.zw).w;
					    u_xlat0 = u_xlat10_0 + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = 0.0<u_xlat0; u_xlati2 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati2 = int((0.0<u_xlat0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = u_xlat0<0.0; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati0 = int((u_xlat0<0.0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					    u_xlati0 = (-u_xlati2) + u_xlati0;
					    u_xlat0 = float(u_xlati0);
					    u_xlat0 = max(u_xlat0, 0.0);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = u_xlat10_1 * _Color;
					    u_xlat1.w = u_xlat0 * u_xlat1.w;
					    SV_Target0 = u_xlat1;
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
					uniform 	vec4 _CutTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _CutTex_ST.xy + _CutTex_ST.zw;
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
					uniform 	lowp vec4 _Color;
					uniform 	float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _CutTex;
					in highp vec4 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					float u_xlat0;
					lowp float u_xlat10_0;
					int u_xlati0;
					vec4 u_xlat1;
					lowp vec4 u_xlat10_1;
					int u_xlati2;
					void main()
					{
					    u_xlat10_0 = texture(_CutTex, vs_TEXCOORD0.zw).w;
					    u_xlat0 = u_xlat10_0 + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = 0.0<u_xlat0; u_xlati2 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati2 = int((0.0<u_xlat0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = u_xlat0<0.0; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati0 = int((u_xlat0<0.0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					    u_xlati0 = (-u_xlati2) + u_xlati0;
					    u_xlat0 = float(u_xlati0);
					    u_xlat0 = max(u_xlat0, 0.0);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = u_xlat10_1 * _Color;
					    u_xlat1.w = u_xlat0 * u_xlat1.w;
					    SV_Target0 = u_xlat1;
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
  GpuProgramID 95100
Program "vp" {
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _CutTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  highp vec4 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _CutTex_ST.xy) + _CutTex_ST.zw);
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
					  tmpvar_3 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_4);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _CutTex;
					uniform lowp vec4 _Color;
					uniform highp float _Cutoff;
					varying highp vec4 xlv_TEXCOORD0;
					void main ()
					{
					  lowp float tmpvar_1;
					  highp float ca_2;
					  lowp float tmpvar_3;
					  tmpvar_3 = texture2D (_CutTex, xlv_TEXCOORD0.zw).w;
					  ca_2 = tmpvar_3;
					  highp float tmpvar_4;
					  tmpvar_4 = max (sign((ca_2 - _Cutoff)), 0.0);
					  tmpvar_1 = ((texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).w * tmpvar_4);
					  lowp vec4 c_5;
					  lowp vec4 c_6;
					  c_6.xyz = vec3(0.0, 0.0, 0.0);
					  c_6.w = tmpvar_1;
					  c_5.w = c_6.w;
					  c_5.xyz = c_6.xyz;
					  gl_FragData[0] = c_5;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _CutTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  highp vec4 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _CutTex_ST.xy) + _CutTex_ST.zw);
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
					  tmpvar_3 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_4);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _CutTex;
					uniform lowp vec4 _Color;
					uniform highp float _Cutoff;
					varying highp vec4 xlv_TEXCOORD0;
					void main ()
					{
					  lowp float tmpvar_1;
					  highp float ca_2;
					  lowp float tmpvar_3;
					  tmpvar_3 = texture2D (_CutTex, xlv_TEXCOORD0.zw).w;
					  ca_2 = tmpvar_3;
					  highp float tmpvar_4;
					  tmpvar_4 = max (sign((ca_2 - _Cutoff)), 0.0);
					  tmpvar_1 = ((texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).w * tmpvar_4);
					  lowp vec4 c_5;
					  lowp vec4 c_6;
					  c_6.xyz = vec3(0.0, 0.0, 0.0);
					  c_6.w = tmpvar_1;
					  c_5.w = c_6.w;
					  c_5.xyz = c_6.xyz;
					  gl_FragData[0] = c_5;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {
Keywords { "POINT" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _CutTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  highp vec4 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _CutTex_ST.xy) + _CutTex_ST.zw);
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
					  tmpvar_3 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_4);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _CutTex;
					uniform lowp vec4 _Color;
					uniform highp float _Cutoff;
					varying highp vec4 xlv_TEXCOORD0;
					void main ()
					{
					  lowp float tmpvar_1;
					  highp float ca_2;
					  lowp float tmpvar_3;
					  tmpvar_3 = texture2D (_CutTex, xlv_TEXCOORD0.zw).w;
					  ca_2 = tmpvar_3;
					  highp float tmpvar_4;
					  tmpvar_4 = max (sign((ca_2 - _Cutoff)), 0.0);
					  tmpvar_1 = ((texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).w * tmpvar_4);
					  lowp vec4 c_5;
					  lowp vec4 c_6;
					  c_6.xyz = vec3(0.0, 0.0, 0.0);
					  c_6.w = tmpvar_1;
					  c_5.w = c_6.w;
					  c_5.xyz = c_6.xyz;
					  gl_FragData[0] = c_5;
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
					uniform 	vec4 _CutTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _CutTex_ST.xy + _CutTex_ST.zw;
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
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _Color;
					uniform 	float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _CutTex;
					in highp vec4 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					float u_xlat0;
					lowp float u_xlat10_0;
					int u_xlati0;
					mediump float u_xlat16_1;
					lowp float u_xlat10_1;
					int u_xlati1;
					void main()
					{
					    u_xlat10_0 = texture(_CutTex, vs_TEXCOORD0.zw).w;
					    u_xlat0 = u_xlat10_0 + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = 0.0<u_xlat0; u_xlati1 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati1 = int((0.0<u_xlat0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = u_xlat0<0.0; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati0 = int((u_xlat0<0.0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					    u_xlati0 = (-u_xlati1) + u_xlati0;
					    u_xlat0 = float(u_xlati0);
					    u_xlat0 = max(u_xlat0, 0.0);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_1 = u_xlat10_1 * _Color.w;
					    u_xlat0 = u_xlat0 * u_xlat16_1;
					    SV_Target0.w = u_xlat0;
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
					uniform 	vec4 _CutTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _CutTex_ST.xy + _CutTex_ST.zw;
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
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _Color;
					uniform 	float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _CutTex;
					in highp vec4 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					float u_xlat0;
					lowp float u_xlat10_0;
					int u_xlati0;
					mediump float u_xlat16_1;
					lowp float u_xlat10_1;
					int u_xlati1;
					void main()
					{
					    u_xlat10_0 = texture(_CutTex, vs_TEXCOORD0.zw).w;
					    u_xlat0 = u_xlat10_0 + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = 0.0<u_xlat0; u_xlati1 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati1 = int((0.0<u_xlat0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = u_xlat0<0.0; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati0 = int((u_xlat0<0.0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					    u_xlati0 = (-u_xlati1) + u_xlati0;
					    u_xlat0 = float(u_xlati0);
					    u_xlat0 = max(u_xlat0, 0.0);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_1 = u_xlat10_1 * _Color.w;
					    u_xlat0 = u_xlat0 * u_xlat16_1;
					    SV_Target0.w = u_xlat0;
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
					uniform 	vec4 _CutTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _CutTex_ST.xy + _CutTex_ST.zw;
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
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _Color;
					uniform 	float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _CutTex;
					in highp vec4 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					float u_xlat0;
					lowp float u_xlat10_0;
					int u_xlati0;
					mediump float u_xlat16_1;
					lowp float u_xlat10_1;
					int u_xlati1;
					void main()
					{
					    u_xlat10_0 = texture(_CutTex, vs_TEXCOORD0.zw).w;
					    u_xlat0 = u_xlat10_0 + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = 0.0<u_xlat0; u_xlati1 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati1 = int((0.0<u_xlat0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = u_xlat0<0.0; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati0 = int((u_xlat0<0.0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					    u_xlati0 = (-u_xlati1) + u_xlati0;
					    u_xlat0 = float(u_xlati0);
					    u_xlat0 = max(u_xlat0, 0.0);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_1 = u_xlat10_1 * _Color.w;
					    u_xlat0 = u_xlat0 * u_xlat16_1;
					    SV_Target0.w = u_xlat0;
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
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _CutTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  highp vec4 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _CutTex_ST.xy) + _CutTex_ST.zw);
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
					  tmpvar_3 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_4);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _CutTex;
					uniform lowp vec4 _Color;
					uniform highp float _Cutoff;
					varying highp vec4 xlv_TEXCOORD0;
					void main ()
					{
					  lowp float tmpvar_1;
					  highp float ca_2;
					  lowp float tmpvar_3;
					  tmpvar_3 = texture2D (_CutTex, xlv_TEXCOORD0.zw).w;
					  ca_2 = tmpvar_3;
					  highp float tmpvar_4;
					  tmpvar_4 = max (sign((ca_2 - _Cutoff)), 0.0);
					  tmpvar_1 = ((texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).w * tmpvar_4);
					  lowp vec4 c_5;
					  lowp vec4 c_6;
					  c_6.xyz = vec3(0.0, 0.0, 0.0);
					  c_6.w = tmpvar_1;
					  c_5.w = c_6.w;
					  c_5.xyz = c_6.xyz;
					  gl_FragData[0] = c_5;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _CutTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  highp vec4 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _CutTex_ST.xy) + _CutTex_ST.zw);
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
					  tmpvar_3 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_4);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _CutTex;
					uniform lowp vec4 _Color;
					uniform highp float _Cutoff;
					varying highp vec4 xlv_TEXCOORD0;
					void main ()
					{
					  lowp float tmpvar_1;
					  highp float ca_2;
					  lowp float tmpvar_3;
					  tmpvar_3 = texture2D (_CutTex, xlv_TEXCOORD0.zw).w;
					  ca_2 = tmpvar_3;
					  highp float tmpvar_4;
					  tmpvar_4 = max (sign((ca_2 - _Cutoff)), 0.0);
					  tmpvar_1 = ((texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).w * tmpvar_4);
					  lowp vec4 c_5;
					  lowp vec4 c_6;
					  c_6.xyz = vec3(0.0, 0.0, 0.0);
					  c_6.w = tmpvar_1;
					  c_5.w = c_6.w;
					  c_5.xyz = c_6.xyz;
					  gl_FragData[0] = c_5;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _CutTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  highp vec4 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _CutTex_ST.xy) + _CutTex_ST.zw);
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
					  tmpvar_3 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_4);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _CutTex;
					uniform lowp vec4 _Color;
					uniform highp float _Cutoff;
					varying highp vec4 xlv_TEXCOORD0;
					void main ()
					{
					  lowp float tmpvar_1;
					  highp float ca_2;
					  lowp float tmpvar_3;
					  tmpvar_3 = texture2D (_CutTex, xlv_TEXCOORD0.zw).w;
					  ca_2 = tmpvar_3;
					  highp float tmpvar_4;
					  tmpvar_4 = max (sign((ca_2 - _Cutoff)), 0.0);
					  tmpvar_1 = ((texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).w * tmpvar_4);
					  lowp vec4 c_5;
					  lowp vec4 c_6;
					  c_6.xyz = vec3(0.0, 0.0, 0.0);
					  c_6.w = tmpvar_1;
					  c_5.w = c_6.w;
					  c_5.xyz = c_6.xyz;
					  gl_FragData[0] = c_5;
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
					uniform 	vec4 _CutTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _CutTex_ST.xy + _CutTex_ST.zw;
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
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _Color;
					uniform 	float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _CutTex;
					in highp vec4 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					float u_xlat0;
					lowp float u_xlat10_0;
					int u_xlati0;
					mediump float u_xlat16_1;
					lowp float u_xlat10_1;
					int u_xlati1;
					void main()
					{
					    u_xlat10_0 = texture(_CutTex, vs_TEXCOORD0.zw).w;
					    u_xlat0 = u_xlat10_0 + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = 0.0<u_xlat0; u_xlati1 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati1 = int((0.0<u_xlat0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = u_xlat0<0.0; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati0 = int((u_xlat0<0.0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					    u_xlati0 = (-u_xlati1) + u_xlati0;
					    u_xlat0 = float(u_xlati0);
					    u_xlat0 = max(u_xlat0, 0.0);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_1 = u_xlat10_1 * _Color.w;
					    u_xlat0 = u_xlat0 * u_xlat16_1;
					    SV_Target0.w = u_xlat0;
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
					uniform 	vec4 _CutTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _CutTex_ST.xy + _CutTex_ST.zw;
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
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _Color;
					uniform 	float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _CutTex;
					in highp vec4 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					float u_xlat0;
					lowp float u_xlat10_0;
					int u_xlati0;
					mediump float u_xlat16_1;
					lowp float u_xlat10_1;
					int u_xlati1;
					void main()
					{
					    u_xlat10_0 = texture(_CutTex, vs_TEXCOORD0.zw).w;
					    u_xlat0 = u_xlat10_0 + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = 0.0<u_xlat0; u_xlati1 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati1 = int((0.0<u_xlat0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = u_xlat0<0.0; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati0 = int((u_xlat0<0.0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					    u_xlati0 = (-u_xlati1) + u_xlati0;
					    u_xlat0 = float(u_xlati0);
					    u_xlat0 = max(u_xlat0, 0.0);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_1 = u_xlat10_1 * _Color.w;
					    u_xlat0 = u_xlat0 * u_xlat16_1;
					    SV_Target0.w = u_xlat0;
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
					uniform 	vec4 _CutTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _CutTex_ST.xy + _CutTex_ST.zw;
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
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _Color;
					uniform 	float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _CutTex;
					in highp vec4 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					float u_xlat0;
					lowp float u_xlat10_0;
					int u_xlati0;
					mediump float u_xlat16_1;
					lowp float u_xlat10_1;
					int u_xlati1;
					void main()
					{
					    u_xlat10_0 = texture(_CutTex, vs_TEXCOORD0.zw).w;
					    u_xlat0 = u_xlat10_0 + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = 0.0<u_xlat0; u_xlati1 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati1 = int((0.0<u_xlat0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = u_xlat0<0.0; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati0 = int((u_xlat0<0.0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					    u_xlati0 = (-u_xlati1) + u_xlati0;
					    u_xlat0 = float(u_xlati0);
					    u_xlat0 = max(u_xlat0, 0.0);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_1 = u_xlat10_1 * _Color.w;
					    u_xlat0 = u_xlat0 * u_xlat16_1;
					    SV_Target0.w = u_xlat0;
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
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _CutTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  highp vec4 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _CutTex_ST.xy) + _CutTex_ST.zw);
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
					  tmpvar_3 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_4);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _CutTex;
					uniform lowp vec4 _Color;
					uniform highp float _Cutoff;
					varying highp vec4 xlv_TEXCOORD0;
					void main ()
					{
					  lowp float tmpvar_1;
					  highp float ca_2;
					  lowp float tmpvar_3;
					  tmpvar_3 = texture2D (_CutTex, xlv_TEXCOORD0.zw).w;
					  ca_2 = tmpvar_3;
					  highp float tmpvar_4;
					  tmpvar_4 = max (sign((ca_2 - _Cutoff)), 0.0);
					  tmpvar_1 = ((texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).w * tmpvar_4);
					  lowp vec4 c_5;
					  lowp vec4 c_6;
					  c_6.xyz = vec3(0.0, 0.0, 0.0);
					  c_6.w = tmpvar_1;
					  c_5.w = c_6.w;
					  c_5.xyz = c_6.xyz;
					  gl_FragData[0] = c_5;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _CutTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  highp vec4 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _CutTex_ST.xy) + _CutTex_ST.zw);
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
					  tmpvar_3 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_4);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _CutTex;
					uniform lowp vec4 _Color;
					uniform highp float _Cutoff;
					varying highp vec4 xlv_TEXCOORD0;
					void main ()
					{
					  lowp float tmpvar_1;
					  highp float ca_2;
					  lowp float tmpvar_3;
					  tmpvar_3 = texture2D (_CutTex, xlv_TEXCOORD0.zw).w;
					  ca_2 = tmpvar_3;
					  highp float tmpvar_4;
					  tmpvar_4 = max (sign((ca_2 - _Cutoff)), 0.0);
					  tmpvar_1 = ((texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).w * tmpvar_4);
					  lowp vec4 c_5;
					  lowp vec4 c_6;
					  c_6.xyz = vec3(0.0, 0.0, 0.0);
					  c_6.w = tmpvar_1;
					  c_5.w = c_6.w;
					  c_5.xyz = c_6.xyz;
					  gl_FragData[0] = c_5;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {
Keywords { "SPOT" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _CutTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  highp vec4 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _CutTex_ST.xy) + _CutTex_ST.zw);
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
					  tmpvar_3 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_4);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _CutTex;
					uniform lowp vec4 _Color;
					uniform highp float _Cutoff;
					varying highp vec4 xlv_TEXCOORD0;
					void main ()
					{
					  lowp float tmpvar_1;
					  highp float ca_2;
					  lowp float tmpvar_3;
					  tmpvar_3 = texture2D (_CutTex, xlv_TEXCOORD0.zw).w;
					  ca_2 = tmpvar_3;
					  highp float tmpvar_4;
					  tmpvar_4 = max (sign((ca_2 - _Cutoff)), 0.0);
					  tmpvar_1 = ((texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).w * tmpvar_4);
					  lowp vec4 c_5;
					  lowp vec4 c_6;
					  c_6.xyz = vec3(0.0, 0.0, 0.0);
					  c_6.w = tmpvar_1;
					  c_5.w = c_6.w;
					  c_5.xyz = c_6.xyz;
					  gl_FragData[0] = c_5;
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
					uniform 	vec4 _CutTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _CutTex_ST.xy + _CutTex_ST.zw;
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
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _Color;
					uniform 	float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _CutTex;
					in highp vec4 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					float u_xlat0;
					lowp float u_xlat10_0;
					int u_xlati0;
					mediump float u_xlat16_1;
					lowp float u_xlat10_1;
					int u_xlati1;
					void main()
					{
					    u_xlat10_0 = texture(_CutTex, vs_TEXCOORD0.zw).w;
					    u_xlat0 = u_xlat10_0 + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = 0.0<u_xlat0; u_xlati1 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati1 = int((0.0<u_xlat0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = u_xlat0<0.0; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati0 = int((u_xlat0<0.0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					    u_xlati0 = (-u_xlati1) + u_xlati0;
					    u_xlat0 = float(u_xlati0);
					    u_xlat0 = max(u_xlat0, 0.0);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_1 = u_xlat10_1 * _Color.w;
					    u_xlat0 = u_xlat0 * u_xlat16_1;
					    SV_Target0.w = u_xlat0;
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
					uniform 	vec4 _CutTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _CutTex_ST.xy + _CutTex_ST.zw;
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
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _Color;
					uniform 	float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _CutTex;
					in highp vec4 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					float u_xlat0;
					lowp float u_xlat10_0;
					int u_xlati0;
					mediump float u_xlat16_1;
					lowp float u_xlat10_1;
					int u_xlati1;
					void main()
					{
					    u_xlat10_0 = texture(_CutTex, vs_TEXCOORD0.zw).w;
					    u_xlat0 = u_xlat10_0 + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = 0.0<u_xlat0; u_xlati1 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati1 = int((0.0<u_xlat0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = u_xlat0<0.0; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati0 = int((u_xlat0<0.0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					    u_xlati0 = (-u_xlati1) + u_xlati0;
					    u_xlat0 = float(u_xlati0);
					    u_xlat0 = max(u_xlat0, 0.0);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_1 = u_xlat10_1 * _Color.w;
					    u_xlat0 = u_xlat0 * u_xlat16_1;
					    SV_Target0.w = u_xlat0;
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
					uniform 	vec4 _CutTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _CutTex_ST.xy + _CutTex_ST.zw;
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
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _Color;
					uniform 	float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _CutTex;
					in highp vec4 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					float u_xlat0;
					lowp float u_xlat10_0;
					int u_xlati0;
					mediump float u_xlat16_1;
					lowp float u_xlat10_1;
					int u_xlati1;
					void main()
					{
					    u_xlat10_0 = texture(_CutTex, vs_TEXCOORD0.zw).w;
					    u_xlat0 = u_xlat10_0 + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = 0.0<u_xlat0; u_xlati1 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati1 = int((0.0<u_xlat0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = u_xlat0<0.0; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati0 = int((u_xlat0<0.0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					    u_xlati0 = (-u_xlati1) + u_xlati0;
					    u_xlat0 = float(u_xlati0);
					    u_xlat0 = max(u_xlat0, 0.0);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_1 = u_xlat10_1 * _Color.w;
					    u_xlat0 = u_xlat0 * u_xlat16_1;
					    SV_Target0.w = u_xlat0;
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
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _CutTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  highp vec4 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _CutTex_ST.xy) + _CutTex_ST.zw);
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
					  tmpvar_3 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_4);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _CutTex;
					uniform lowp vec4 _Color;
					uniform highp float _Cutoff;
					varying highp vec4 xlv_TEXCOORD0;
					void main ()
					{
					  lowp float tmpvar_1;
					  highp float ca_2;
					  lowp float tmpvar_3;
					  tmpvar_3 = texture2D (_CutTex, xlv_TEXCOORD0.zw).w;
					  ca_2 = tmpvar_3;
					  highp float tmpvar_4;
					  tmpvar_4 = max (sign((ca_2 - _Cutoff)), 0.0);
					  tmpvar_1 = ((texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).w * tmpvar_4);
					  lowp vec4 c_5;
					  lowp vec4 c_6;
					  c_6.xyz = vec3(0.0, 0.0, 0.0);
					  c_6.w = tmpvar_1;
					  c_5.w = c_6.w;
					  c_5.xyz = c_6.xyz;
					  gl_FragData[0] = c_5;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _CutTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  highp vec4 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _CutTex_ST.xy) + _CutTex_ST.zw);
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
					  tmpvar_3 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_4);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _CutTex;
					uniform lowp vec4 _Color;
					uniform highp float _Cutoff;
					varying highp vec4 xlv_TEXCOORD0;
					void main ()
					{
					  lowp float tmpvar_1;
					  highp float ca_2;
					  lowp float tmpvar_3;
					  tmpvar_3 = texture2D (_CutTex, xlv_TEXCOORD0.zw).w;
					  ca_2 = tmpvar_3;
					  highp float tmpvar_4;
					  tmpvar_4 = max (sign((ca_2 - _Cutoff)), 0.0);
					  tmpvar_1 = ((texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).w * tmpvar_4);
					  lowp vec4 c_5;
					  lowp vec4 c_6;
					  c_6.xyz = vec3(0.0, 0.0, 0.0);
					  c_6.w = tmpvar_1;
					  c_5.w = c_6.w;
					  c_5.xyz = c_6.xyz;
					  gl_FragData[0] = c_5;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {
Keywords { "POINT_COOKIE" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _CutTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  highp vec4 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _CutTex_ST.xy) + _CutTex_ST.zw);
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
					  tmpvar_3 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_4);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _CutTex;
					uniform lowp vec4 _Color;
					uniform highp float _Cutoff;
					varying highp vec4 xlv_TEXCOORD0;
					void main ()
					{
					  lowp float tmpvar_1;
					  highp float ca_2;
					  lowp float tmpvar_3;
					  tmpvar_3 = texture2D (_CutTex, xlv_TEXCOORD0.zw).w;
					  ca_2 = tmpvar_3;
					  highp float tmpvar_4;
					  tmpvar_4 = max (sign((ca_2 - _Cutoff)), 0.0);
					  tmpvar_1 = ((texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).w * tmpvar_4);
					  lowp vec4 c_5;
					  lowp vec4 c_6;
					  c_6.xyz = vec3(0.0, 0.0, 0.0);
					  c_6.w = tmpvar_1;
					  c_5.w = c_6.w;
					  c_5.xyz = c_6.xyz;
					  gl_FragData[0] = c_5;
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
					uniform 	vec4 _CutTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _CutTex_ST.xy + _CutTex_ST.zw;
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
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _Color;
					uniform 	float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _CutTex;
					in highp vec4 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					float u_xlat0;
					lowp float u_xlat10_0;
					int u_xlati0;
					mediump float u_xlat16_1;
					lowp float u_xlat10_1;
					int u_xlati1;
					void main()
					{
					    u_xlat10_0 = texture(_CutTex, vs_TEXCOORD0.zw).w;
					    u_xlat0 = u_xlat10_0 + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = 0.0<u_xlat0; u_xlati1 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati1 = int((0.0<u_xlat0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = u_xlat0<0.0; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati0 = int((u_xlat0<0.0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					    u_xlati0 = (-u_xlati1) + u_xlati0;
					    u_xlat0 = float(u_xlati0);
					    u_xlat0 = max(u_xlat0, 0.0);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_1 = u_xlat10_1 * _Color.w;
					    u_xlat0 = u_xlat0 * u_xlat16_1;
					    SV_Target0.w = u_xlat0;
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
					uniform 	vec4 _CutTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _CutTex_ST.xy + _CutTex_ST.zw;
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
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _Color;
					uniform 	float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _CutTex;
					in highp vec4 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					float u_xlat0;
					lowp float u_xlat10_0;
					int u_xlati0;
					mediump float u_xlat16_1;
					lowp float u_xlat10_1;
					int u_xlati1;
					void main()
					{
					    u_xlat10_0 = texture(_CutTex, vs_TEXCOORD0.zw).w;
					    u_xlat0 = u_xlat10_0 + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = 0.0<u_xlat0; u_xlati1 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati1 = int((0.0<u_xlat0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = u_xlat0<0.0; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati0 = int((u_xlat0<0.0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					    u_xlati0 = (-u_xlati1) + u_xlati0;
					    u_xlat0 = float(u_xlati0);
					    u_xlat0 = max(u_xlat0, 0.0);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_1 = u_xlat10_1 * _Color.w;
					    u_xlat0 = u_xlat0 * u_xlat16_1;
					    SV_Target0.w = u_xlat0;
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
					uniform 	vec4 _CutTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _CutTex_ST.xy + _CutTex_ST.zw;
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
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _Color;
					uniform 	float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _CutTex;
					in highp vec4 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					float u_xlat0;
					lowp float u_xlat10_0;
					int u_xlati0;
					mediump float u_xlat16_1;
					lowp float u_xlat10_1;
					int u_xlati1;
					void main()
					{
					    u_xlat10_0 = texture(_CutTex, vs_TEXCOORD0.zw).w;
					    u_xlat0 = u_xlat10_0 + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = 0.0<u_xlat0; u_xlati1 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati1 = int((0.0<u_xlat0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = u_xlat0<0.0; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati0 = int((u_xlat0<0.0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					    u_xlati0 = (-u_xlati1) + u_xlati0;
					    u_xlat0 = float(u_xlati0);
					    u_xlat0 = max(u_xlat0, 0.0);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_1 = u_xlat10_1 * _Color.w;
					    u_xlat0 = u_xlat0 * u_xlat16_1;
					    SV_Target0.w = u_xlat0;
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
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _CutTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  highp vec4 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _CutTex_ST.xy) + _CutTex_ST.zw);
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
					  tmpvar_3 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_4);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _CutTex;
					uniform lowp vec4 _Color;
					uniform highp float _Cutoff;
					varying highp vec4 xlv_TEXCOORD0;
					void main ()
					{
					  lowp float tmpvar_1;
					  highp float ca_2;
					  lowp float tmpvar_3;
					  tmpvar_3 = texture2D (_CutTex, xlv_TEXCOORD0.zw).w;
					  ca_2 = tmpvar_3;
					  highp float tmpvar_4;
					  tmpvar_4 = max (sign((ca_2 - _Cutoff)), 0.0);
					  tmpvar_1 = ((texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).w * tmpvar_4);
					  lowp vec4 c_5;
					  lowp vec4 c_6;
					  c_6.xyz = vec3(0.0, 0.0, 0.0);
					  c_6.w = tmpvar_1;
					  c_5.w = c_6.w;
					  c_5.xyz = c_6.xyz;
					  gl_FragData[0] = c_5;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _CutTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  highp vec4 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _CutTex_ST.xy) + _CutTex_ST.zw);
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
					  tmpvar_3 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_4);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _CutTex;
					uniform lowp vec4 _Color;
					uniform highp float _Cutoff;
					varying highp vec4 xlv_TEXCOORD0;
					void main ()
					{
					  lowp float tmpvar_1;
					  highp float ca_2;
					  lowp float tmpvar_3;
					  tmpvar_3 = texture2D (_CutTex, xlv_TEXCOORD0.zw).w;
					  ca_2 = tmpvar_3;
					  highp float tmpvar_4;
					  tmpvar_4 = max (sign((ca_2 - _Cutoff)), 0.0);
					  tmpvar_1 = ((texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).w * tmpvar_4);
					  lowp vec4 c_5;
					  lowp vec4 c_6;
					  c_6.xyz = vec3(0.0, 0.0, 0.0);
					  c_6.w = tmpvar_1;
					  c_5.w = c_6.w;
					  c_5.xyz = c_6.xyz;
					  gl_FragData[0] = c_5;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL_COOKIE" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _CutTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  highp vec4 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _CutTex_ST.xy) + _CutTex_ST.zw);
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
					  tmpvar_3 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_4);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _CutTex;
					uniform lowp vec4 _Color;
					uniform highp float _Cutoff;
					varying highp vec4 xlv_TEXCOORD0;
					void main ()
					{
					  lowp float tmpvar_1;
					  highp float ca_2;
					  lowp float tmpvar_3;
					  tmpvar_3 = texture2D (_CutTex, xlv_TEXCOORD0.zw).w;
					  ca_2 = tmpvar_3;
					  highp float tmpvar_4;
					  tmpvar_4 = max (sign((ca_2 - _Cutoff)), 0.0);
					  tmpvar_1 = ((texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).w * tmpvar_4);
					  lowp vec4 c_5;
					  lowp vec4 c_6;
					  c_6.xyz = vec3(0.0, 0.0, 0.0);
					  c_6.w = tmpvar_1;
					  c_5.w = c_6.w;
					  c_5.xyz = c_6.xyz;
					  gl_FragData[0] = c_5;
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
					uniform 	vec4 _CutTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _CutTex_ST.xy + _CutTex_ST.zw;
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
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _Color;
					uniform 	float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _CutTex;
					in highp vec4 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					float u_xlat0;
					lowp float u_xlat10_0;
					int u_xlati0;
					mediump float u_xlat16_1;
					lowp float u_xlat10_1;
					int u_xlati1;
					void main()
					{
					    u_xlat10_0 = texture(_CutTex, vs_TEXCOORD0.zw).w;
					    u_xlat0 = u_xlat10_0 + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = 0.0<u_xlat0; u_xlati1 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati1 = int((0.0<u_xlat0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = u_xlat0<0.0; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati0 = int((u_xlat0<0.0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					    u_xlati0 = (-u_xlati1) + u_xlati0;
					    u_xlat0 = float(u_xlati0);
					    u_xlat0 = max(u_xlat0, 0.0);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_1 = u_xlat10_1 * _Color.w;
					    u_xlat0 = u_xlat0 * u_xlat16_1;
					    SV_Target0.w = u_xlat0;
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
					uniform 	vec4 _CutTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _CutTex_ST.xy + _CutTex_ST.zw;
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
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _Color;
					uniform 	float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _CutTex;
					in highp vec4 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					float u_xlat0;
					lowp float u_xlat10_0;
					int u_xlati0;
					mediump float u_xlat16_1;
					lowp float u_xlat10_1;
					int u_xlati1;
					void main()
					{
					    u_xlat10_0 = texture(_CutTex, vs_TEXCOORD0.zw).w;
					    u_xlat0 = u_xlat10_0 + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = 0.0<u_xlat0; u_xlati1 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati1 = int((0.0<u_xlat0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = u_xlat0<0.0; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati0 = int((u_xlat0<0.0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					    u_xlati0 = (-u_xlati1) + u_xlati0;
					    u_xlat0 = float(u_xlati0);
					    u_xlat0 = max(u_xlat0, 0.0);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_1 = u_xlat10_1 * _Color.w;
					    u_xlat0 = u_xlat0 * u_xlat16_1;
					    SV_Target0.w = u_xlat0;
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
					uniform 	vec4 _CutTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _CutTex_ST.xy + _CutTex_ST.zw;
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
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _Color;
					uniform 	float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _CutTex;
					in highp vec4 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					float u_xlat0;
					lowp float u_xlat10_0;
					int u_xlati0;
					mediump float u_xlat16_1;
					lowp float u_xlat10_1;
					int u_xlati1;
					void main()
					{
					    u_xlat10_0 = texture(_CutTex, vs_TEXCOORD0.zw).w;
					    u_xlat0 = u_xlat10_0 + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = 0.0<u_xlat0; u_xlati1 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati1 = int((0.0<u_xlat0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = u_xlat0<0.0; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati0 = int((u_xlat0<0.0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					    u_xlati0 = (-u_xlati1) + u_xlati0;
					    u_xlat0 = float(u_xlati0);
					    u_xlat0 = max(u_xlat0, 0.0);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_1 = u_xlat10_1 * _Color.w;
					    u_xlat0 = u_xlat0 * u_xlat16_1;
					    SV_Target0.w = u_xlat0;
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
}
Fallback "Transparent/VertexLit"
}