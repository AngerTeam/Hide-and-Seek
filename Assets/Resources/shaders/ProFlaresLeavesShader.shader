Shader "ProFlares/Demo/LeavesShader" {
Properties {
 _Color ("Main Color", Color) = (1.000000,1.000000,1.000000,1.000000)
 _Shininess ("Shininess", Range(0.010000,1.000000)) = 0.078125
 _MainTex ("Base (RGB) Alpha (A)", 2D) = "white" { }
 _BumpMap ("Normalmap", 2D) = "bump" { }
 _GlossMap ("Gloss (A)", 2D) = "black" { }
 _TranslucencyMap ("Translucency (A)", 2D) = "white" { }
 _ShadowOffset ("Shadow Offset (A)", 2D) = "black" { }
 _Cutoff ("Alpha cutoff", Range(0.000000,1.000000)) = 0.300000
 _Scale ("Scale", Vector) = (1.000000,1.000000,1.000000,1.000000)
 _Amount ("Amount", Float) = 1.000000
 _Wind ("Wind params", Vector) = (1.000000,1.000000,1.000000,1.000000)
 _WindEdgeFlutter ("Wind edge fultter factor", Float) = 0.500000
 _WindEdgeFlutterFreqScale ("Wind edge fultter freq scale", Float) = 0.500000
}
SubShader { 
 LOD 200
 Tags { "IGNOREPROJECTOR"="true" "RenderType"="TreeLeaf" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "IGNOREPROJECTOR"="true" "SHADOWSUPPORT"="true" "RenderType"="TreeLeaf" }
  Cull Off
  ColorMask RGB
  GpuProgramID 60150
Program "vp" {
// Platform gles3 had shader errors
//   Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
//   Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
//   Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
//   Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
//   Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
//   Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
//   Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
//   Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
//   Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
//   Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
//   Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
//   Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
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
					uniform highp vec4 _Time;
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
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = _glesColor;
					  highp vec3 shlight_3;
					  lowp float tangentSign_4;
					  lowp vec3 worldTangent_5;
					  lowp vec3 worldNormal_6;
					  lowp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = tmpvar_1.w;
					  highp float bendingFact_9;
					  highp vec4 wind_10;
					  lowp float tmpvar_11;
					  tmpvar_11 = tmpvar_2.w;
					  bendingFact_9 = tmpvar_11;
					  highp mat3 tmpvar_12;
					  tmpvar_12[0] = unity_WorldToObject[0].xyz;
					  tmpvar_12[1] = unity_WorldToObject[1].xyz;
					  tmpvar_12[2] = unity_WorldToObject[2].xyz;
					  wind_10.xyz = (tmpvar_12 * _Wind.xyz);
					  wind_10.w = (_Wind.w * bendingFact_9);
					  highp vec2 tmpvar_13;
					  tmpvar_13.y = 1.0;
					  tmpvar_13.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_14;
					  pos_14.w = tmpvar_1.w;
					  highp vec3 bend_15;
					  highp vec4 v_16;
					  v_16.x = unity_ObjectToWorld[0].w;
					  v_16.y = unity_ObjectToWorld[1].w;
					  v_16.z = unity_ObjectToWorld[2].w;
					  v_16.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_17;
					  tmpvar_17 = dot (v_16.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_18;
					  tmpvar_18.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_17)));
					  tmpvar_18.y = tmpvar_17;
					  highp vec4 tmpvar_19;
					  tmpvar_19 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_13).xx + tmpvar_18).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_20;
					  tmpvar_20 = ((tmpvar_19 * tmpvar_19) * (3.0 - (2.0 * tmpvar_19)));
					  highp vec2 tmpvar_21;
					  tmpvar_21 = (tmpvar_20.xz + tmpvar_20.yw);
					  bend_15.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_15.y = (bendingFact_9 * 0.3);
					  pos_14.xyz = (_glesVertex.xyz + ((
					    (tmpvar_21.xyx * bend_15)
					   + 
					    ((wind_10.xyz * tmpvar_21.y) * bendingFact_9)
					  ) * wind_10.w));
					  pos_14.xyz = (pos_14.xyz + (bendingFact_9 * wind_10.xyz));
					  tmpvar_8.xyz = pos_14.xyz;
					  highp vec4 tmpvar_22;
					  tmpvar_22.w = 1.0;
					  tmpvar_22.xyz = tmpvar_8.xyz;
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (unity_ObjectToWorld * tmpvar_8).xyz;
					  highp vec4 v_24;
					  v_24.x = unity_WorldToObject[0].x;
					  v_24.y = unity_WorldToObject[1].x;
					  v_24.z = unity_WorldToObject[2].x;
					  v_24.w = unity_WorldToObject[3].x;
					  highp vec4 v_25;
					  v_25.x = unity_WorldToObject[0].y;
					  v_25.y = unity_WorldToObject[1].y;
					  v_25.z = unity_WorldToObject[2].y;
					  v_25.w = unity_WorldToObject[3].y;
					  highp vec4 v_26;
					  v_26.x = unity_WorldToObject[0].z;
					  v_26.y = unity_WorldToObject[1].z;
					  v_26.z = unity_WorldToObject[2].z;
					  v_26.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_27;
					  tmpvar_27 = normalize(((
					    (v_24.xyz * _glesNormal.x)
					   + 
					    (v_25.xyz * _glesNormal.y)
					  ) + (v_26.xyz * _glesNormal.z)));
					  worldNormal_6 = tmpvar_27;
					  highp mat3 tmpvar_28;
					  tmpvar_28[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_28[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_28[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = normalize((tmpvar_28 * _glesTANGENT.xyz));
					  worldTangent_5 = tmpvar_29;
					  highp float tmpvar_30;
					  tmpvar_30 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_4 = tmpvar_30;
					  lowp vec3 tmpvar_31;
					  tmpvar_31 = (((worldNormal_6.yzx * worldTangent_5.zxy) - (worldNormal_6.zxy * worldTangent_5.yzx)) * tangentSign_4);
					  highp vec4 tmpvar_32;
					  tmpvar_32.x = worldTangent_5.x;
					  tmpvar_32.y = tmpvar_31.x;
					  tmpvar_32.z = worldNormal_6.x;
					  tmpvar_32.w = tmpvar_23.x;
					  highp vec4 tmpvar_33;
					  tmpvar_33.x = worldTangent_5.y;
					  tmpvar_33.y = tmpvar_31.y;
					  tmpvar_33.z = worldNormal_6.y;
					  tmpvar_33.w = tmpvar_23.y;
					  highp vec4 tmpvar_34;
					  tmpvar_34.x = worldTangent_5.z;
					  tmpvar_34.y = tmpvar_31.z;
					  tmpvar_34.z = worldNormal_6.z;
					  tmpvar_34.w = tmpvar_23.z;
					  lowp vec4 tmpvar_35;
					  tmpvar_35.w = 1.0;
					  tmpvar_35.xyz = worldNormal_6;
					  mediump vec4 normal_36;
					  normal_36 = tmpvar_35;
					  mediump vec3 res_37;
					  mediump vec3 x_38;
					  x_38.x = dot (unity_SHAr, normal_36);
					  x_38.y = dot (unity_SHAg, normal_36);
					  x_38.z = dot (unity_SHAb, normal_36);
					  mediump vec3 x1_39;
					  mediump vec4 tmpvar_40;
					  tmpvar_40 = (normal_36.xyzz * normal_36.yzzx);
					  x1_39.x = dot (unity_SHBr, tmpvar_40);
					  x1_39.y = dot (unity_SHBg, tmpvar_40);
					  x1_39.z = dot (unity_SHBb, tmpvar_40);
					  res_37 = (x_38 + (x1_39 + (unity_SHC.xyz * 
					    ((normal_36.x * normal_36.x) - (normal_36.y * normal_36.y))
					  )));
					  res_37 = max (((1.055 * 
					    pow (max (res_37, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_3 = res_37;
					  tmpvar_7 = shlight_3;
					  gl_Position = (glstate_matrix_mvp * tmpvar_22);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_32;
					  xlv_TEXCOORD2 = tmpvar_33;
					  xlv_TEXCOORD3 = tmpvar_34;
					  xlv_COLOR0 = tmpvar_2;
					  xlv_TEXCOORD4 = tmpvar_7;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					uniform sampler2D _GlossMap;
					uniform sampler2D _TranslucencyMap;
					uniform mediump float _Shininess;
					uniform lowp vec4 _Color;
					uniform lowp vec3 _TranslucencyColor;
					uniform lowp float _TranslucencyViewDependency;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
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
					  lowp float tmpvar_10;
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpvar_8 = ((tmpvar_11.xyz * _Color.xyz) * xlv_COLOR0.xyz);
					  tmpvar_10 = _Shininess;
					  lowp vec4 tmpvar_12;
					  tmpvar_12 = texture2D (_GlossMap, xlv_TEXCOORD0);
					  tmpvar_9 = tmpvar_12.w;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
					  lowp float x_14;
					  x_14 = (tmpvar_11.w - _Cutoff);
					  if ((x_14 < 0.0)) {
					    discard;
					  };
					  c_2.w = 0.0;
					  highp float tmpvar_15;
					  tmpvar_15 = dot (xlv_TEXCOORD1.xyz, tmpvar_13);
					  worldN_1.x = tmpvar_15;
					  highp float tmpvar_16;
					  tmpvar_16 = dot (xlv_TEXCOORD2.xyz, tmpvar_13);
					  worldN_1.y = tmpvar_16;
					  highp float tmpvar_17;
					  tmpvar_17 = dot (xlv_TEXCOORD3.xyz, tmpvar_13);
					  worldN_1.z = tmpvar_17;
					  c_2.xyz = (tmpvar_8 * xlv_TEXCOORD4);
					  mediump vec4 tmpvar_18;
					  mediump vec3 lightDir_19;
					  lightDir_19 = lightDir_4;
					  mediump vec3 viewDir_20;
					  viewDir_20 = worldViewDir_3;
					  lowp vec4 c_21;
					  mediump float tmpvar_22;
					  tmpvar_22 = dot (worldN_1, lightDir_19);
					  mediump float tmpvar_23;
					  tmpvar_23 = (pow (max (0.0, 
					    dot (worldN_1, normalize((lightDir_19 + viewDir_20)))
					  ), (tmpvar_9 * 128.0)) * tmpvar_10);
					  lowp float tmpvar_24;
					  mediump float tmpvar_25;
					  tmpvar_25 = clamp (dot (viewDir_20, -(lightDir_19)), 0.0, 1.0);
					  tmpvar_24 = tmpvar_25;
					  mediump float tmpvar_26;
					  tmpvar_26 = clamp (-(tmpvar_22), 0.0, 1.0);
					  mediump float tmpvar_27;
					  tmpvar_27 = max (0.0, ((tmpvar_22 * 0.6) + 0.4));
					  c_21.xyz = (tmpvar_8 * ((
					    (mix (tmpvar_26, tmpvar_24, _TranslucencyViewDependency) * texture2D (_TranslucencyMap, xlv_TEXCOORD0).xyz)
					   * 
					    (_TranslucencyColor * 2.0)
					  ) + tmpvar_27));
					  c_21.xyz = ((c_21.xyz * _LightColor0.xyz) + tmpvar_23);
					  c_21.xyz = (c_21.xyz * _LightColor0.xyz);
					  tmpvar_18 = c_21;
					  c_2 = (c_2 + tmpvar_18);
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
					uniform highp vec4 _Time;
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
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = _glesColor;
					  highp vec3 shlight_3;
					  lowp float tangentSign_4;
					  lowp vec3 worldTangent_5;
					  lowp vec3 worldNormal_6;
					  lowp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = tmpvar_1.w;
					  highp float bendingFact_9;
					  highp vec4 wind_10;
					  lowp float tmpvar_11;
					  tmpvar_11 = tmpvar_2.w;
					  bendingFact_9 = tmpvar_11;
					  highp mat3 tmpvar_12;
					  tmpvar_12[0] = unity_WorldToObject[0].xyz;
					  tmpvar_12[1] = unity_WorldToObject[1].xyz;
					  tmpvar_12[2] = unity_WorldToObject[2].xyz;
					  wind_10.xyz = (tmpvar_12 * _Wind.xyz);
					  wind_10.w = (_Wind.w * bendingFact_9);
					  highp vec2 tmpvar_13;
					  tmpvar_13.y = 1.0;
					  tmpvar_13.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_14;
					  pos_14.w = tmpvar_1.w;
					  highp vec3 bend_15;
					  highp vec4 v_16;
					  v_16.x = unity_ObjectToWorld[0].w;
					  v_16.y = unity_ObjectToWorld[1].w;
					  v_16.z = unity_ObjectToWorld[2].w;
					  v_16.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_17;
					  tmpvar_17 = dot (v_16.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_18;
					  tmpvar_18.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_17)));
					  tmpvar_18.y = tmpvar_17;
					  highp vec4 tmpvar_19;
					  tmpvar_19 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_13).xx + tmpvar_18).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_20;
					  tmpvar_20 = ((tmpvar_19 * tmpvar_19) * (3.0 - (2.0 * tmpvar_19)));
					  highp vec2 tmpvar_21;
					  tmpvar_21 = (tmpvar_20.xz + tmpvar_20.yw);
					  bend_15.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_15.y = (bendingFact_9 * 0.3);
					  pos_14.xyz = (_glesVertex.xyz + ((
					    (tmpvar_21.xyx * bend_15)
					   + 
					    ((wind_10.xyz * tmpvar_21.y) * bendingFact_9)
					  ) * wind_10.w));
					  pos_14.xyz = (pos_14.xyz + (bendingFact_9 * wind_10.xyz));
					  tmpvar_8.xyz = pos_14.xyz;
					  highp vec4 tmpvar_22;
					  tmpvar_22.w = 1.0;
					  tmpvar_22.xyz = tmpvar_8.xyz;
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (unity_ObjectToWorld * tmpvar_8).xyz;
					  highp vec4 v_24;
					  v_24.x = unity_WorldToObject[0].x;
					  v_24.y = unity_WorldToObject[1].x;
					  v_24.z = unity_WorldToObject[2].x;
					  v_24.w = unity_WorldToObject[3].x;
					  highp vec4 v_25;
					  v_25.x = unity_WorldToObject[0].y;
					  v_25.y = unity_WorldToObject[1].y;
					  v_25.z = unity_WorldToObject[2].y;
					  v_25.w = unity_WorldToObject[3].y;
					  highp vec4 v_26;
					  v_26.x = unity_WorldToObject[0].z;
					  v_26.y = unity_WorldToObject[1].z;
					  v_26.z = unity_WorldToObject[2].z;
					  v_26.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_27;
					  tmpvar_27 = normalize(((
					    (v_24.xyz * _glesNormal.x)
					   + 
					    (v_25.xyz * _glesNormal.y)
					  ) + (v_26.xyz * _glesNormal.z)));
					  worldNormal_6 = tmpvar_27;
					  highp mat3 tmpvar_28;
					  tmpvar_28[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_28[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_28[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = normalize((tmpvar_28 * _glesTANGENT.xyz));
					  worldTangent_5 = tmpvar_29;
					  highp float tmpvar_30;
					  tmpvar_30 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_4 = tmpvar_30;
					  lowp vec3 tmpvar_31;
					  tmpvar_31 = (((worldNormal_6.yzx * worldTangent_5.zxy) - (worldNormal_6.zxy * worldTangent_5.yzx)) * tangentSign_4);
					  highp vec4 tmpvar_32;
					  tmpvar_32.x = worldTangent_5.x;
					  tmpvar_32.y = tmpvar_31.x;
					  tmpvar_32.z = worldNormal_6.x;
					  tmpvar_32.w = tmpvar_23.x;
					  highp vec4 tmpvar_33;
					  tmpvar_33.x = worldTangent_5.y;
					  tmpvar_33.y = tmpvar_31.y;
					  tmpvar_33.z = worldNormal_6.y;
					  tmpvar_33.w = tmpvar_23.y;
					  highp vec4 tmpvar_34;
					  tmpvar_34.x = worldTangent_5.z;
					  tmpvar_34.y = tmpvar_31.z;
					  tmpvar_34.z = worldNormal_6.z;
					  tmpvar_34.w = tmpvar_23.z;
					  lowp vec4 tmpvar_35;
					  tmpvar_35.w = 1.0;
					  tmpvar_35.xyz = worldNormal_6;
					  mediump vec4 normal_36;
					  normal_36 = tmpvar_35;
					  mediump vec3 res_37;
					  mediump vec3 x_38;
					  x_38.x = dot (unity_SHAr, normal_36);
					  x_38.y = dot (unity_SHAg, normal_36);
					  x_38.z = dot (unity_SHAb, normal_36);
					  mediump vec3 x1_39;
					  mediump vec4 tmpvar_40;
					  tmpvar_40 = (normal_36.xyzz * normal_36.yzzx);
					  x1_39.x = dot (unity_SHBr, tmpvar_40);
					  x1_39.y = dot (unity_SHBg, tmpvar_40);
					  x1_39.z = dot (unity_SHBb, tmpvar_40);
					  res_37 = (x_38 + (x1_39 + (unity_SHC.xyz * 
					    ((normal_36.x * normal_36.x) - (normal_36.y * normal_36.y))
					  )));
					  res_37 = max (((1.055 * 
					    pow (max (res_37, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_3 = res_37;
					  tmpvar_7 = shlight_3;
					  gl_Position = (glstate_matrix_mvp * tmpvar_22);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_32;
					  xlv_TEXCOORD2 = tmpvar_33;
					  xlv_TEXCOORD3 = tmpvar_34;
					  xlv_COLOR0 = tmpvar_2;
					  xlv_TEXCOORD4 = tmpvar_7;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					uniform sampler2D _GlossMap;
					uniform sampler2D _TranslucencyMap;
					uniform mediump float _Shininess;
					uniform lowp vec4 _Color;
					uniform lowp vec3 _TranslucencyColor;
					uniform lowp float _TranslucencyViewDependency;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
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
					  lowp float tmpvar_10;
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpvar_8 = ((tmpvar_11.xyz * _Color.xyz) * xlv_COLOR0.xyz);
					  tmpvar_10 = _Shininess;
					  lowp vec4 tmpvar_12;
					  tmpvar_12 = texture2D (_GlossMap, xlv_TEXCOORD0);
					  tmpvar_9 = tmpvar_12.w;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
					  lowp float x_14;
					  x_14 = (tmpvar_11.w - _Cutoff);
					  if ((x_14 < 0.0)) {
					    discard;
					  };
					  c_2.w = 0.0;
					  highp float tmpvar_15;
					  tmpvar_15 = dot (xlv_TEXCOORD1.xyz, tmpvar_13);
					  worldN_1.x = tmpvar_15;
					  highp float tmpvar_16;
					  tmpvar_16 = dot (xlv_TEXCOORD2.xyz, tmpvar_13);
					  worldN_1.y = tmpvar_16;
					  highp float tmpvar_17;
					  tmpvar_17 = dot (xlv_TEXCOORD3.xyz, tmpvar_13);
					  worldN_1.z = tmpvar_17;
					  c_2.xyz = (tmpvar_8 * xlv_TEXCOORD4);
					  mediump vec4 tmpvar_18;
					  mediump vec3 lightDir_19;
					  lightDir_19 = lightDir_4;
					  mediump vec3 viewDir_20;
					  viewDir_20 = worldViewDir_3;
					  lowp vec4 c_21;
					  mediump float tmpvar_22;
					  tmpvar_22 = dot (worldN_1, lightDir_19);
					  mediump float tmpvar_23;
					  tmpvar_23 = (pow (max (0.0, 
					    dot (worldN_1, normalize((lightDir_19 + viewDir_20)))
					  ), (tmpvar_9 * 128.0)) * tmpvar_10);
					  lowp float tmpvar_24;
					  mediump float tmpvar_25;
					  tmpvar_25 = clamp (dot (viewDir_20, -(lightDir_19)), 0.0, 1.0);
					  tmpvar_24 = tmpvar_25;
					  mediump float tmpvar_26;
					  tmpvar_26 = clamp (-(tmpvar_22), 0.0, 1.0);
					  mediump float tmpvar_27;
					  tmpvar_27 = max (0.0, ((tmpvar_22 * 0.6) + 0.4));
					  c_21.xyz = (tmpvar_8 * ((
					    (mix (tmpvar_26, tmpvar_24, _TranslucencyViewDependency) * texture2D (_TranslucencyMap, xlv_TEXCOORD0).xyz)
					   * 
					    (_TranslucencyColor * 2.0)
					  ) + tmpvar_27));
					  c_21.xyz = ((c_21.xyz * _LightColor0.xyz) + tmpvar_23);
					  c_21.xyz = (c_21.xyz * _LightColor0.xyz);
					  tmpvar_18 = c_21;
					  c_2 = (c_2 + tmpvar_18);
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
					uniform highp vec4 _Time;
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
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = _glesColor;
					  highp vec3 shlight_3;
					  lowp float tangentSign_4;
					  lowp vec3 worldTangent_5;
					  lowp vec3 worldNormal_6;
					  lowp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = tmpvar_1.w;
					  highp float bendingFact_9;
					  highp vec4 wind_10;
					  lowp float tmpvar_11;
					  tmpvar_11 = tmpvar_2.w;
					  bendingFact_9 = tmpvar_11;
					  highp mat3 tmpvar_12;
					  tmpvar_12[0] = unity_WorldToObject[0].xyz;
					  tmpvar_12[1] = unity_WorldToObject[1].xyz;
					  tmpvar_12[2] = unity_WorldToObject[2].xyz;
					  wind_10.xyz = (tmpvar_12 * _Wind.xyz);
					  wind_10.w = (_Wind.w * bendingFact_9);
					  highp vec2 tmpvar_13;
					  tmpvar_13.y = 1.0;
					  tmpvar_13.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_14;
					  pos_14.w = tmpvar_1.w;
					  highp vec3 bend_15;
					  highp vec4 v_16;
					  v_16.x = unity_ObjectToWorld[0].w;
					  v_16.y = unity_ObjectToWorld[1].w;
					  v_16.z = unity_ObjectToWorld[2].w;
					  v_16.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_17;
					  tmpvar_17 = dot (v_16.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_18;
					  tmpvar_18.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_17)));
					  tmpvar_18.y = tmpvar_17;
					  highp vec4 tmpvar_19;
					  tmpvar_19 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_13).xx + tmpvar_18).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_20;
					  tmpvar_20 = ((tmpvar_19 * tmpvar_19) * (3.0 - (2.0 * tmpvar_19)));
					  highp vec2 tmpvar_21;
					  tmpvar_21 = (tmpvar_20.xz + tmpvar_20.yw);
					  bend_15.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_15.y = (bendingFact_9 * 0.3);
					  pos_14.xyz = (_glesVertex.xyz + ((
					    (tmpvar_21.xyx * bend_15)
					   + 
					    ((wind_10.xyz * tmpvar_21.y) * bendingFact_9)
					  ) * wind_10.w));
					  pos_14.xyz = (pos_14.xyz + (bendingFact_9 * wind_10.xyz));
					  tmpvar_8.xyz = pos_14.xyz;
					  highp vec4 tmpvar_22;
					  tmpvar_22.w = 1.0;
					  tmpvar_22.xyz = tmpvar_8.xyz;
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (unity_ObjectToWorld * tmpvar_8).xyz;
					  highp vec4 v_24;
					  v_24.x = unity_WorldToObject[0].x;
					  v_24.y = unity_WorldToObject[1].x;
					  v_24.z = unity_WorldToObject[2].x;
					  v_24.w = unity_WorldToObject[3].x;
					  highp vec4 v_25;
					  v_25.x = unity_WorldToObject[0].y;
					  v_25.y = unity_WorldToObject[1].y;
					  v_25.z = unity_WorldToObject[2].y;
					  v_25.w = unity_WorldToObject[3].y;
					  highp vec4 v_26;
					  v_26.x = unity_WorldToObject[0].z;
					  v_26.y = unity_WorldToObject[1].z;
					  v_26.z = unity_WorldToObject[2].z;
					  v_26.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_27;
					  tmpvar_27 = normalize(((
					    (v_24.xyz * _glesNormal.x)
					   + 
					    (v_25.xyz * _glesNormal.y)
					  ) + (v_26.xyz * _glesNormal.z)));
					  worldNormal_6 = tmpvar_27;
					  highp mat3 tmpvar_28;
					  tmpvar_28[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_28[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_28[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = normalize((tmpvar_28 * _glesTANGENT.xyz));
					  worldTangent_5 = tmpvar_29;
					  highp float tmpvar_30;
					  tmpvar_30 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_4 = tmpvar_30;
					  lowp vec3 tmpvar_31;
					  tmpvar_31 = (((worldNormal_6.yzx * worldTangent_5.zxy) - (worldNormal_6.zxy * worldTangent_5.yzx)) * tangentSign_4);
					  highp vec4 tmpvar_32;
					  tmpvar_32.x = worldTangent_5.x;
					  tmpvar_32.y = tmpvar_31.x;
					  tmpvar_32.z = worldNormal_6.x;
					  tmpvar_32.w = tmpvar_23.x;
					  highp vec4 tmpvar_33;
					  tmpvar_33.x = worldTangent_5.y;
					  tmpvar_33.y = tmpvar_31.y;
					  tmpvar_33.z = worldNormal_6.y;
					  tmpvar_33.w = tmpvar_23.y;
					  highp vec4 tmpvar_34;
					  tmpvar_34.x = worldTangent_5.z;
					  tmpvar_34.y = tmpvar_31.z;
					  tmpvar_34.z = worldNormal_6.z;
					  tmpvar_34.w = tmpvar_23.z;
					  lowp vec4 tmpvar_35;
					  tmpvar_35.w = 1.0;
					  tmpvar_35.xyz = worldNormal_6;
					  mediump vec4 normal_36;
					  normal_36 = tmpvar_35;
					  mediump vec3 res_37;
					  mediump vec3 x_38;
					  x_38.x = dot (unity_SHAr, normal_36);
					  x_38.y = dot (unity_SHAg, normal_36);
					  x_38.z = dot (unity_SHAb, normal_36);
					  mediump vec3 x1_39;
					  mediump vec4 tmpvar_40;
					  tmpvar_40 = (normal_36.xyzz * normal_36.yzzx);
					  x1_39.x = dot (unity_SHBr, tmpvar_40);
					  x1_39.y = dot (unity_SHBg, tmpvar_40);
					  x1_39.z = dot (unity_SHBb, tmpvar_40);
					  res_37 = (x_38 + (x1_39 + (unity_SHC.xyz * 
					    ((normal_36.x * normal_36.x) - (normal_36.y * normal_36.y))
					  )));
					  res_37 = max (((1.055 * 
					    pow (max (res_37, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_3 = res_37;
					  tmpvar_7 = shlight_3;
					  gl_Position = (glstate_matrix_mvp * tmpvar_22);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_32;
					  xlv_TEXCOORD2 = tmpvar_33;
					  xlv_TEXCOORD3 = tmpvar_34;
					  xlv_COLOR0 = tmpvar_2;
					  xlv_TEXCOORD4 = tmpvar_7;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					uniform sampler2D _GlossMap;
					uniform sampler2D _TranslucencyMap;
					uniform mediump float _Shininess;
					uniform lowp vec4 _Color;
					uniform lowp vec3 _TranslucencyColor;
					uniform lowp float _TranslucencyViewDependency;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
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
					  lowp float tmpvar_10;
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpvar_8 = ((tmpvar_11.xyz * _Color.xyz) * xlv_COLOR0.xyz);
					  tmpvar_10 = _Shininess;
					  lowp vec4 tmpvar_12;
					  tmpvar_12 = texture2D (_GlossMap, xlv_TEXCOORD0);
					  tmpvar_9 = tmpvar_12.w;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
					  lowp float x_14;
					  x_14 = (tmpvar_11.w - _Cutoff);
					  if ((x_14 < 0.0)) {
					    discard;
					  };
					  c_2.w = 0.0;
					  highp float tmpvar_15;
					  tmpvar_15 = dot (xlv_TEXCOORD1.xyz, tmpvar_13);
					  worldN_1.x = tmpvar_15;
					  highp float tmpvar_16;
					  tmpvar_16 = dot (xlv_TEXCOORD2.xyz, tmpvar_13);
					  worldN_1.y = tmpvar_16;
					  highp float tmpvar_17;
					  tmpvar_17 = dot (xlv_TEXCOORD3.xyz, tmpvar_13);
					  worldN_1.z = tmpvar_17;
					  c_2.xyz = (tmpvar_8 * xlv_TEXCOORD4);
					  mediump vec4 tmpvar_18;
					  mediump vec3 lightDir_19;
					  lightDir_19 = lightDir_4;
					  mediump vec3 viewDir_20;
					  viewDir_20 = worldViewDir_3;
					  lowp vec4 c_21;
					  mediump float tmpvar_22;
					  tmpvar_22 = dot (worldN_1, lightDir_19);
					  mediump float tmpvar_23;
					  tmpvar_23 = (pow (max (0.0, 
					    dot (worldN_1, normalize((lightDir_19 + viewDir_20)))
					  ), (tmpvar_9 * 128.0)) * tmpvar_10);
					  lowp float tmpvar_24;
					  mediump float tmpvar_25;
					  tmpvar_25 = clamp (dot (viewDir_20, -(lightDir_19)), 0.0, 1.0);
					  tmpvar_24 = tmpvar_25;
					  mediump float tmpvar_26;
					  tmpvar_26 = clamp (-(tmpvar_22), 0.0, 1.0);
					  mediump float tmpvar_27;
					  tmpvar_27 = max (0.0, ((tmpvar_22 * 0.6) + 0.4));
					  c_21.xyz = (tmpvar_8 * ((
					    (mix (tmpvar_26, tmpvar_24, _TranslucencyViewDependency) * texture2D (_TranslucencyMap, xlv_TEXCOORD0).xyz)
					   * 
					    (_TranslucencyColor * 2.0)
					  ) + tmpvar_27));
					  c_21.xyz = ((c_21.xyz * _LightColor0.xyz) + tmpvar_23);
					  c_21.xyz = (c_21.xyz * _LightColor0.xyz);
					  tmpvar_18 = c_21;
					  c_2 = (c_2 + tmpvar_18);
					  gl_FragData[0] = c_2;
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
					uniform highp vec4 _Time;
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
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = _glesColor;
					  highp vec3 shlight_3;
					  lowp float tangentSign_4;
					  lowp vec3 worldTangent_5;
					  lowp vec3 worldNormal_6;
					  lowp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = tmpvar_1.w;
					  highp float bendingFact_9;
					  highp vec4 wind_10;
					  lowp float tmpvar_11;
					  tmpvar_11 = tmpvar_2.w;
					  bendingFact_9 = tmpvar_11;
					  highp mat3 tmpvar_12;
					  tmpvar_12[0] = unity_WorldToObject[0].xyz;
					  tmpvar_12[1] = unity_WorldToObject[1].xyz;
					  tmpvar_12[2] = unity_WorldToObject[2].xyz;
					  wind_10.xyz = (tmpvar_12 * _Wind.xyz);
					  wind_10.w = (_Wind.w * bendingFact_9);
					  highp vec2 tmpvar_13;
					  tmpvar_13.y = 1.0;
					  tmpvar_13.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_14;
					  pos_14.w = tmpvar_1.w;
					  highp vec3 bend_15;
					  highp vec4 v_16;
					  v_16.x = unity_ObjectToWorld[0].w;
					  v_16.y = unity_ObjectToWorld[1].w;
					  v_16.z = unity_ObjectToWorld[2].w;
					  v_16.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_17;
					  tmpvar_17 = dot (v_16.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_18;
					  tmpvar_18.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_17)));
					  tmpvar_18.y = tmpvar_17;
					  highp vec4 tmpvar_19;
					  tmpvar_19 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_13).xx + tmpvar_18).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_20;
					  tmpvar_20 = ((tmpvar_19 * tmpvar_19) * (3.0 - (2.0 * tmpvar_19)));
					  highp vec2 tmpvar_21;
					  tmpvar_21 = (tmpvar_20.xz + tmpvar_20.yw);
					  bend_15.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_15.y = (bendingFact_9 * 0.3);
					  pos_14.xyz = (_glesVertex.xyz + ((
					    (tmpvar_21.xyx * bend_15)
					   + 
					    ((wind_10.xyz * tmpvar_21.y) * bendingFact_9)
					  ) * wind_10.w));
					  pos_14.xyz = (pos_14.xyz + (bendingFact_9 * wind_10.xyz));
					  tmpvar_8.xyz = pos_14.xyz;
					  highp vec4 tmpvar_22;
					  tmpvar_22.w = 1.0;
					  tmpvar_22.xyz = tmpvar_8.xyz;
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (unity_ObjectToWorld * tmpvar_8).xyz;
					  highp vec4 v_24;
					  v_24.x = unity_WorldToObject[0].x;
					  v_24.y = unity_WorldToObject[1].x;
					  v_24.z = unity_WorldToObject[2].x;
					  v_24.w = unity_WorldToObject[3].x;
					  highp vec4 v_25;
					  v_25.x = unity_WorldToObject[0].y;
					  v_25.y = unity_WorldToObject[1].y;
					  v_25.z = unity_WorldToObject[2].y;
					  v_25.w = unity_WorldToObject[3].y;
					  highp vec4 v_26;
					  v_26.x = unity_WorldToObject[0].z;
					  v_26.y = unity_WorldToObject[1].z;
					  v_26.z = unity_WorldToObject[2].z;
					  v_26.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_27;
					  tmpvar_27 = normalize(((
					    (v_24.xyz * _glesNormal.x)
					   + 
					    (v_25.xyz * _glesNormal.y)
					  ) + (v_26.xyz * _glesNormal.z)));
					  worldNormal_6 = tmpvar_27;
					  highp mat3 tmpvar_28;
					  tmpvar_28[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_28[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_28[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = normalize((tmpvar_28 * _glesTANGENT.xyz));
					  worldTangent_5 = tmpvar_29;
					  highp float tmpvar_30;
					  tmpvar_30 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_4 = tmpvar_30;
					  lowp vec3 tmpvar_31;
					  tmpvar_31 = (((worldNormal_6.yzx * worldTangent_5.zxy) - (worldNormal_6.zxy * worldTangent_5.yzx)) * tangentSign_4);
					  highp vec4 tmpvar_32;
					  tmpvar_32.x = worldTangent_5.x;
					  tmpvar_32.y = tmpvar_31.x;
					  tmpvar_32.z = worldNormal_6.x;
					  tmpvar_32.w = tmpvar_23.x;
					  highp vec4 tmpvar_33;
					  tmpvar_33.x = worldTangent_5.y;
					  tmpvar_33.y = tmpvar_31.y;
					  tmpvar_33.z = worldNormal_6.y;
					  tmpvar_33.w = tmpvar_23.y;
					  highp vec4 tmpvar_34;
					  tmpvar_34.x = worldTangent_5.z;
					  tmpvar_34.y = tmpvar_31.z;
					  tmpvar_34.z = worldNormal_6.z;
					  tmpvar_34.w = tmpvar_23.z;
					  lowp vec4 tmpvar_35;
					  tmpvar_35.w = 1.0;
					  tmpvar_35.xyz = worldNormal_6;
					  mediump vec4 normal_36;
					  normal_36 = tmpvar_35;
					  mediump vec3 res_37;
					  mediump vec3 x_38;
					  x_38.x = dot (unity_SHAr, normal_36);
					  x_38.y = dot (unity_SHAg, normal_36);
					  x_38.z = dot (unity_SHAb, normal_36);
					  mediump vec3 x1_39;
					  mediump vec4 tmpvar_40;
					  tmpvar_40 = (normal_36.xyzz * normal_36.yzzx);
					  x1_39.x = dot (unity_SHBr, tmpvar_40);
					  x1_39.y = dot (unity_SHBg, tmpvar_40);
					  x1_39.z = dot (unity_SHBb, tmpvar_40);
					  res_37 = (x_38 + (x1_39 + (unity_SHC.xyz * 
					    ((normal_36.x * normal_36.x) - (normal_36.y * normal_36.y))
					  )));
					  res_37 = max (((1.055 * 
					    pow (max (res_37, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_3 = res_37;
					  tmpvar_7 = shlight_3;
					  gl_Position = (glstate_matrix_mvp * tmpvar_22);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_32;
					  xlv_TEXCOORD2 = tmpvar_33;
					  xlv_TEXCOORD3 = tmpvar_34;
					  xlv_COLOR0 = tmpvar_2;
					  xlv_TEXCOORD4 = tmpvar_7;
					  xlv_TEXCOORD5 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * tmpvar_8));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					uniform sampler2D _GlossMap;
					uniform sampler2D _TranslucencyMap;
					uniform mediump float _Shininess;
					uniform lowp vec4 _Color;
					uniform lowp vec3 _TranslucencyColor;
					uniform lowp float _TranslucencyViewDependency;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
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
					  lowp float tmpvar_10;
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpvar_8 = ((tmpvar_11.xyz * _Color.xyz) * xlv_COLOR0.xyz);
					  tmpvar_10 = _Shininess;
					  lowp vec4 tmpvar_12;
					  tmpvar_12 = texture2D (_GlossMap, xlv_TEXCOORD0);
					  tmpvar_9 = tmpvar_12.w;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
					  lowp float x_14;
					  x_14 = (tmpvar_11.w - _Cutoff);
					  if ((x_14 < 0.0)) {
					    discard;
					  };
					  c_2.w = 0.0;
					  highp float tmpvar_15;
					  tmpvar_15 = dot (xlv_TEXCOORD1.xyz, tmpvar_13);
					  worldN_1.x = tmpvar_15;
					  highp float tmpvar_16;
					  tmpvar_16 = dot (xlv_TEXCOORD2.xyz, tmpvar_13);
					  worldN_1.y = tmpvar_16;
					  highp float tmpvar_17;
					  tmpvar_17 = dot (xlv_TEXCOORD3.xyz, tmpvar_13);
					  worldN_1.z = tmpvar_17;
					  c_2.xyz = (tmpvar_8 * xlv_TEXCOORD4);
					  mediump vec4 tmpvar_18;
					  mediump vec3 lightDir_19;
					  lightDir_19 = lightDir_4;
					  mediump vec3 viewDir_20;
					  viewDir_20 = worldViewDir_3;
					  lowp vec4 c_21;
					  mediump float tmpvar_22;
					  tmpvar_22 = dot (worldN_1, lightDir_19);
					  mediump float tmpvar_23;
					  tmpvar_23 = (pow (max (0.0, 
					    dot (worldN_1, normalize((lightDir_19 + viewDir_20)))
					  ), (tmpvar_9 * 128.0)) * tmpvar_10);
					  lowp float tmpvar_24;
					  mediump float tmpvar_25;
					  tmpvar_25 = clamp (dot (viewDir_20, -(lightDir_19)), 0.0, 1.0);
					  tmpvar_24 = tmpvar_25;
					  mediump float tmpvar_26;
					  tmpvar_26 = clamp (-(tmpvar_22), 0.0, 1.0);
					  mediump float tmpvar_27;
					  tmpvar_27 = max (0.0, ((tmpvar_22 * 0.6) + 0.4));
					  c_21.xyz = (tmpvar_8 * ((
					    (mix (tmpvar_26, tmpvar_24, _TranslucencyViewDependency) * texture2D (_TranslucencyMap, xlv_TEXCOORD0).xyz)
					   * 
					    (_TranslucencyColor * 2.0)
					  ) + tmpvar_27));
					  c_21.xyz = ((c_21.xyz * _LightColor0.xyz) + tmpvar_23);
					  c_21.xyz = (c_21.xyz * _LightColor0.xyz);
					  tmpvar_18 = c_21;
					  c_2 = (c_2 + tmpvar_18);
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
					uniform highp vec4 _Time;
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
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = _glesColor;
					  highp vec3 shlight_3;
					  lowp float tangentSign_4;
					  lowp vec3 worldTangent_5;
					  lowp vec3 worldNormal_6;
					  lowp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = tmpvar_1.w;
					  highp float bendingFact_9;
					  highp vec4 wind_10;
					  lowp float tmpvar_11;
					  tmpvar_11 = tmpvar_2.w;
					  bendingFact_9 = tmpvar_11;
					  highp mat3 tmpvar_12;
					  tmpvar_12[0] = unity_WorldToObject[0].xyz;
					  tmpvar_12[1] = unity_WorldToObject[1].xyz;
					  tmpvar_12[2] = unity_WorldToObject[2].xyz;
					  wind_10.xyz = (tmpvar_12 * _Wind.xyz);
					  wind_10.w = (_Wind.w * bendingFact_9);
					  highp vec2 tmpvar_13;
					  tmpvar_13.y = 1.0;
					  tmpvar_13.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_14;
					  pos_14.w = tmpvar_1.w;
					  highp vec3 bend_15;
					  highp vec4 v_16;
					  v_16.x = unity_ObjectToWorld[0].w;
					  v_16.y = unity_ObjectToWorld[1].w;
					  v_16.z = unity_ObjectToWorld[2].w;
					  v_16.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_17;
					  tmpvar_17 = dot (v_16.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_18;
					  tmpvar_18.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_17)));
					  tmpvar_18.y = tmpvar_17;
					  highp vec4 tmpvar_19;
					  tmpvar_19 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_13).xx + tmpvar_18).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_20;
					  tmpvar_20 = ((tmpvar_19 * tmpvar_19) * (3.0 - (2.0 * tmpvar_19)));
					  highp vec2 tmpvar_21;
					  tmpvar_21 = (tmpvar_20.xz + tmpvar_20.yw);
					  bend_15.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_15.y = (bendingFact_9 * 0.3);
					  pos_14.xyz = (_glesVertex.xyz + ((
					    (tmpvar_21.xyx * bend_15)
					   + 
					    ((wind_10.xyz * tmpvar_21.y) * bendingFact_9)
					  ) * wind_10.w));
					  pos_14.xyz = (pos_14.xyz + (bendingFact_9 * wind_10.xyz));
					  tmpvar_8.xyz = pos_14.xyz;
					  highp vec4 tmpvar_22;
					  tmpvar_22.w = 1.0;
					  tmpvar_22.xyz = tmpvar_8.xyz;
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (unity_ObjectToWorld * tmpvar_8).xyz;
					  highp vec4 v_24;
					  v_24.x = unity_WorldToObject[0].x;
					  v_24.y = unity_WorldToObject[1].x;
					  v_24.z = unity_WorldToObject[2].x;
					  v_24.w = unity_WorldToObject[3].x;
					  highp vec4 v_25;
					  v_25.x = unity_WorldToObject[0].y;
					  v_25.y = unity_WorldToObject[1].y;
					  v_25.z = unity_WorldToObject[2].y;
					  v_25.w = unity_WorldToObject[3].y;
					  highp vec4 v_26;
					  v_26.x = unity_WorldToObject[0].z;
					  v_26.y = unity_WorldToObject[1].z;
					  v_26.z = unity_WorldToObject[2].z;
					  v_26.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_27;
					  tmpvar_27 = normalize(((
					    (v_24.xyz * _glesNormal.x)
					   + 
					    (v_25.xyz * _glesNormal.y)
					  ) + (v_26.xyz * _glesNormal.z)));
					  worldNormal_6 = tmpvar_27;
					  highp mat3 tmpvar_28;
					  tmpvar_28[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_28[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_28[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = normalize((tmpvar_28 * _glesTANGENT.xyz));
					  worldTangent_5 = tmpvar_29;
					  highp float tmpvar_30;
					  tmpvar_30 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_4 = tmpvar_30;
					  lowp vec3 tmpvar_31;
					  tmpvar_31 = (((worldNormal_6.yzx * worldTangent_5.zxy) - (worldNormal_6.zxy * worldTangent_5.yzx)) * tangentSign_4);
					  highp vec4 tmpvar_32;
					  tmpvar_32.x = worldTangent_5.x;
					  tmpvar_32.y = tmpvar_31.x;
					  tmpvar_32.z = worldNormal_6.x;
					  tmpvar_32.w = tmpvar_23.x;
					  highp vec4 tmpvar_33;
					  tmpvar_33.x = worldTangent_5.y;
					  tmpvar_33.y = tmpvar_31.y;
					  tmpvar_33.z = worldNormal_6.y;
					  tmpvar_33.w = tmpvar_23.y;
					  highp vec4 tmpvar_34;
					  tmpvar_34.x = worldTangent_5.z;
					  tmpvar_34.y = tmpvar_31.z;
					  tmpvar_34.z = worldNormal_6.z;
					  tmpvar_34.w = tmpvar_23.z;
					  lowp vec4 tmpvar_35;
					  tmpvar_35.w = 1.0;
					  tmpvar_35.xyz = worldNormal_6;
					  mediump vec4 normal_36;
					  normal_36 = tmpvar_35;
					  mediump vec3 res_37;
					  mediump vec3 x_38;
					  x_38.x = dot (unity_SHAr, normal_36);
					  x_38.y = dot (unity_SHAg, normal_36);
					  x_38.z = dot (unity_SHAb, normal_36);
					  mediump vec3 x1_39;
					  mediump vec4 tmpvar_40;
					  tmpvar_40 = (normal_36.xyzz * normal_36.yzzx);
					  x1_39.x = dot (unity_SHBr, tmpvar_40);
					  x1_39.y = dot (unity_SHBg, tmpvar_40);
					  x1_39.z = dot (unity_SHBb, tmpvar_40);
					  res_37 = (x_38 + (x1_39 + (unity_SHC.xyz * 
					    ((normal_36.x * normal_36.x) - (normal_36.y * normal_36.y))
					  )));
					  res_37 = max (((1.055 * 
					    pow (max (res_37, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_3 = res_37;
					  tmpvar_7 = shlight_3;
					  gl_Position = (glstate_matrix_mvp * tmpvar_22);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_32;
					  xlv_TEXCOORD2 = tmpvar_33;
					  xlv_TEXCOORD3 = tmpvar_34;
					  xlv_COLOR0 = tmpvar_2;
					  xlv_TEXCOORD4 = tmpvar_7;
					  xlv_TEXCOORD5 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * tmpvar_8));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					uniform sampler2D _GlossMap;
					uniform sampler2D _TranslucencyMap;
					uniform mediump float _Shininess;
					uniform lowp vec4 _Color;
					uniform lowp vec3 _TranslucencyColor;
					uniform lowp float _TranslucencyViewDependency;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
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
					  lowp float tmpvar_10;
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpvar_8 = ((tmpvar_11.xyz * _Color.xyz) * xlv_COLOR0.xyz);
					  tmpvar_10 = _Shininess;
					  lowp vec4 tmpvar_12;
					  tmpvar_12 = texture2D (_GlossMap, xlv_TEXCOORD0);
					  tmpvar_9 = tmpvar_12.w;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
					  lowp float x_14;
					  x_14 = (tmpvar_11.w - _Cutoff);
					  if ((x_14 < 0.0)) {
					    discard;
					  };
					  c_2.w = 0.0;
					  highp float tmpvar_15;
					  tmpvar_15 = dot (xlv_TEXCOORD1.xyz, tmpvar_13);
					  worldN_1.x = tmpvar_15;
					  highp float tmpvar_16;
					  tmpvar_16 = dot (xlv_TEXCOORD2.xyz, tmpvar_13);
					  worldN_1.y = tmpvar_16;
					  highp float tmpvar_17;
					  tmpvar_17 = dot (xlv_TEXCOORD3.xyz, tmpvar_13);
					  worldN_1.z = tmpvar_17;
					  c_2.xyz = (tmpvar_8 * xlv_TEXCOORD4);
					  mediump vec4 tmpvar_18;
					  mediump vec3 lightDir_19;
					  lightDir_19 = lightDir_4;
					  mediump vec3 viewDir_20;
					  viewDir_20 = worldViewDir_3;
					  lowp vec4 c_21;
					  mediump float tmpvar_22;
					  tmpvar_22 = dot (worldN_1, lightDir_19);
					  mediump float tmpvar_23;
					  tmpvar_23 = (pow (max (0.0, 
					    dot (worldN_1, normalize((lightDir_19 + viewDir_20)))
					  ), (tmpvar_9 * 128.0)) * tmpvar_10);
					  lowp float tmpvar_24;
					  mediump float tmpvar_25;
					  tmpvar_25 = clamp (dot (viewDir_20, -(lightDir_19)), 0.0, 1.0);
					  tmpvar_24 = tmpvar_25;
					  mediump float tmpvar_26;
					  tmpvar_26 = clamp (-(tmpvar_22), 0.0, 1.0);
					  mediump float tmpvar_27;
					  tmpvar_27 = max (0.0, ((tmpvar_22 * 0.6) + 0.4));
					  c_21.xyz = (tmpvar_8 * ((
					    (mix (tmpvar_26, tmpvar_24, _TranslucencyViewDependency) * texture2D (_TranslucencyMap, xlv_TEXCOORD0).xyz)
					   * 
					    (_TranslucencyColor * 2.0)
					  ) + tmpvar_27));
					  c_21.xyz = ((c_21.xyz * _LightColor0.xyz) + tmpvar_23);
					  c_21.xyz = (c_21.xyz * _LightColor0.xyz);
					  tmpvar_18 = c_21;
					  c_2 = (c_2 + tmpvar_18);
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
					uniform highp vec4 _Time;
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
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = _glesColor;
					  highp vec3 shlight_3;
					  lowp float tangentSign_4;
					  lowp vec3 worldTangent_5;
					  lowp vec3 worldNormal_6;
					  lowp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = tmpvar_1.w;
					  highp float bendingFact_9;
					  highp vec4 wind_10;
					  lowp float tmpvar_11;
					  tmpvar_11 = tmpvar_2.w;
					  bendingFact_9 = tmpvar_11;
					  highp mat3 tmpvar_12;
					  tmpvar_12[0] = unity_WorldToObject[0].xyz;
					  tmpvar_12[1] = unity_WorldToObject[1].xyz;
					  tmpvar_12[2] = unity_WorldToObject[2].xyz;
					  wind_10.xyz = (tmpvar_12 * _Wind.xyz);
					  wind_10.w = (_Wind.w * bendingFact_9);
					  highp vec2 tmpvar_13;
					  tmpvar_13.y = 1.0;
					  tmpvar_13.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_14;
					  pos_14.w = tmpvar_1.w;
					  highp vec3 bend_15;
					  highp vec4 v_16;
					  v_16.x = unity_ObjectToWorld[0].w;
					  v_16.y = unity_ObjectToWorld[1].w;
					  v_16.z = unity_ObjectToWorld[2].w;
					  v_16.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_17;
					  tmpvar_17 = dot (v_16.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_18;
					  tmpvar_18.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_17)));
					  tmpvar_18.y = tmpvar_17;
					  highp vec4 tmpvar_19;
					  tmpvar_19 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_13).xx + tmpvar_18).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_20;
					  tmpvar_20 = ((tmpvar_19 * tmpvar_19) * (3.0 - (2.0 * tmpvar_19)));
					  highp vec2 tmpvar_21;
					  tmpvar_21 = (tmpvar_20.xz + tmpvar_20.yw);
					  bend_15.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_15.y = (bendingFact_9 * 0.3);
					  pos_14.xyz = (_glesVertex.xyz + ((
					    (tmpvar_21.xyx * bend_15)
					   + 
					    ((wind_10.xyz * tmpvar_21.y) * bendingFact_9)
					  ) * wind_10.w));
					  pos_14.xyz = (pos_14.xyz + (bendingFact_9 * wind_10.xyz));
					  tmpvar_8.xyz = pos_14.xyz;
					  highp vec4 tmpvar_22;
					  tmpvar_22.w = 1.0;
					  tmpvar_22.xyz = tmpvar_8.xyz;
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (unity_ObjectToWorld * tmpvar_8).xyz;
					  highp vec4 v_24;
					  v_24.x = unity_WorldToObject[0].x;
					  v_24.y = unity_WorldToObject[1].x;
					  v_24.z = unity_WorldToObject[2].x;
					  v_24.w = unity_WorldToObject[3].x;
					  highp vec4 v_25;
					  v_25.x = unity_WorldToObject[0].y;
					  v_25.y = unity_WorldToObject[1].y;
					  v_25.z = unity_WorldToObject[2].y;
					  v_25.w = unity_WorldToObject[3].y;
					  highp vec4 v_26;
					  v_26.x = unity_WorldToObject[0].z;
					  v_26.y = unity_WorldToObject[1].z;
					  v_26.z = unity_WorldToObject[2].z;
					  v_26.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_27;
					  tmpvar_27 = normalize(((
					    (v_24.xyz * _glesNormal.x)
					   + 
					    (v_25.xyz * _glesNormal.y)
					  ) + (v_26.xyz * _glesNormal.z)));
					  worldNormal_6 = tmpvar_27;
					  highp mat3 tmpvar_28;
					  tmpvar_28[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_28[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_28[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = normalize((tmpvar_28 * _glesTANGENT.xyz));
					  worldTangent_5 = tmpvar_29;
					  highp float tmpvar_30;
					  tmpvar_30 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_4 = tmpvar_30;
					  lowp vec3 tmpvar_31;
					  tmpvar_31 = (((worldNormal_6.yzx * worldTangent_5.zxy) - (worldNormal_6.zxy * worldTangent_5.yzx)) * tangentSign_4);
					  highp vec4 tmpvar_32;
					  tmpvar_32.x = worldTangent_5.x;
					  tmpvar_32.y = tmpvar_31.x;
					  tmpvar_32.z = worldNormal_6.x;
					  tmpvar_32.w = tmpvar_23.x;
					  highp vec4 tmpvar_33;
					  tmpvar_33.x = worldTangent_5.y;
					  tmpvar_33.y = tmpvar_31.y;
					  tmpvar_33.z = worldNormal_6.y;
					  tmpvar_33.w = tmpvar_23.y;
					  highp vec4 tmpvar_34;
					  tmpvar_34.x = worldTangent_5.z;
					  tmpvar_34.y = tmpvar_31.z;
					  tmpvar_34.z = worldNormal_6.z;
					  tmpvar_34.w = tmpvar_23.z;
					  lowp vec4 tmpvar_35;
					  tmpvar_35.w = 1.0;
					  tmpvar_35.xyz = worldNormal_6;
					  mediump vec4 normal_36;
					  normal_36 = tmpvar_35;
					  mediump vec3 res_37;
					  mediump vec3 x_38;
					  x_38.x = dot (unity_SHAr, normal_36);
					  x_38.y = dot (unity_SHAg, normal_36);
					  x_38.z = dot (unity_SHAb, normal_36);
					  mediump vec3 x1_39;
					  mediump vec4 tmpvar_40;
					  tmpvar_40 = (normal_36.xyzz * normal_36.yzzx);
					  x1_39.x = dot (unity_SHBr, tmpvar_40);
					  x1_39.y = dot (unity_SHBg, tmpvar_40);
					  x1_39.z = dot (unity_SHBb, tmpvar_40);
					  res_37 = (x_38 + (x1_39 + (unity_SHC.xyz * 
					    ((normal_36.x * normal_36.x) - (normal_36.y * normal_36.y))
					  )));
					  res_37 = max (((1.055 * 
					    pow (max (res_37, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_3 = res_37;
					  tmpvar_7 = shlight_3;
					  gl_Position = (glstate_matrix_mvp * tmpvar_22);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_32;
					  xlv_TEXCOORD2 = tmpvar_33;
					  xlv_TEXCOORD3 = tmpvar_34;
					  xlv_COLOR0 = tmpvar_2;
					  xlv_TEXCOORD4 = tmpvar_7;
					  xlv_TEXCOORD5 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * tmpvar_8));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					uniform sampler2D _GlossMap;
					uniform sampler2D _TranslucencyMap;
					uniform mediump float _Shininess;
					uniform lowp vec4 _Color;
					uniform lowp vec3 _TranslucencyColor;
					uniform lowp float _TranslucencyViewDependency;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
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
					  lowp float tmpvar_10;
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpvar_8 = ((tmpvar_11.xyz * _Color.xyz) * xlv_COLOR0.xyz);
					  tmpvar_10 = _Shininess;
					  lowp vec4 tmpvar_12;
					  tmpvar_12 = texture2D (_GlossMap, xlv_TEXCOORD0);
					  tmpvar_9 = tmpvar_12.w;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
					  lowp float x_14;
					  x_14 = (tmpvar_11.w - _Cutoff);
					  if ((x_14 < 0.0)) {
					    discard;
					  };
					  c_2.w = 0.0;
					  highp float tmpvar_15;
					  tmpvar_15 = dot (xlv_TEXCOORD1.xyz, tmpvar_13);
					  worldN_1.x = tmpvar_15;
					  highp float tmpvar_16;
					  tmpvar_16 = dot (xlv_TEXCOORD2.xyz, tmpvar_13);
					  worldN_1.y = tmpvar_16;
					  highp float tmpvar_17;
					  tmpvar_17 = dot (xlv_TEXCOORD3.xyz, tmpvar_13);
					  worldN_1.z = tmpvar_17;
					  c_2.xyz = (tmpvar_8 * xlv_TEXCOORD4);
					  mediump vec4 tmpvar_18;
					  mediump vec3 lightDir_19;
					  lightDir_19 = lightDir_4;
					  mediump vec3 viewDir_20;
					  viewDir_20 = worldViewDir_3;
					  lowp vec4 c_21;
					  mediump float tmpvar_22;
					  tmpvar_22 = dot (worldN_1, lightDir_19);
					  mediump float tmpvar_23;
					  tmpvar_23 = (pow (max (0.0, 
					    dot (worldN_1, normalize((lightDir_19 + viewDir_20)))
					  ), (tmpvar_9 * 128.0)) * tmpvar_10);
					  lowp float tmpvar_24;
					  mediump float tmpvar_25;
					  tmpvar_25 = clamp (dot (viewDir_20, -(lightDir_19)), 0.0, 1.0);
					  tmpvar_24 = tmpvar_25;
					  mediump float tmpvar_26;
					  tmpvar_26 = clamp (-(tmpvar_22), 0.0, 1.0);
					  mediump float tmpvar_27;
					  tmpvar_27 = max (0.0, ((tmpvar_22 * 0.6) + 0.4));
					  c_21.xyz = (tmpvar_8 * ((
					    (mix (tmpvar_26, tmpvar_24, _TranslucencyViewDependency) * texture2D (_TranslucencyMap, xlv_TEXCOORD0).xyz)
					   * 
					    (_TranslucencyColor * 2.0)
					  ) + tmpvar_27));
					  c_21.xyz = ((c_21.xyz * _LightColor0.xyz) + tmpvar_23);
					  c_21.xyz = (c_21.xyz * _LightColor0.xyz);
					  tmpvar_18 = c_21;
					  c_2 = (c_2 + tmpvar_18);
					  gl_FragData[0] = c_2;
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
					uniform highp vec4 _Time;
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
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = _glesColor;
					  highp vec3 shlight_3;
					  lowp float tangentSign_4;
					  lowp vec3 worldTangent_5;
					  lowp vec3 worldNormal_6;
					  lowp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = tmpvar_1.w;
					  highp float bendingFact_9;
					  highp vec4 wind_10;
					  lowp float tmpvar_11;
					  tmpvar_11 = tmpvar_2.w;
					  bendingFact_9 = tmpvar_11;
					  highp mat3 tmpvar_12;
					  tmpvar_12[0] = unity_WorldToObject[0].xyz;
					  tmpvar_12[1] = unity_WorldToObject[1].xyz;
					  tmpvar_12[2] = unity_WorldToObject[2].xyz;
					  wind_10.xyz = (tmpvar_12 * _Wind.xyz);
					  wind_10.w = (_Wind.w * bendingFact_9);
					  highp vec2 tmpvar_13;
					  tmpvar_13.y = 1.0;
					  tmpvar_13.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_14;
					  pos_14.w = tmpvar_1.w;
					  highp vec3 bend_15;
					  highp vec4 v_16;
					  v_16.x = unity_ObjectToWorld[0].w;
					  v_16.y = unity_ObjectToWorld[1].w;
					  v_16.z = unity_ObjectToWorld[2].w;
					  v_16.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_17;
					  tmpvar_17 = dot (v_16.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_18;
					  tmpvar_18.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_17)));
					  tmpvar_18.y = tmpvar_17;
					  highp vec4 tmpvar_19;
					  tmpvar_19 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_13).xx + tmpvar_18).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_20;
					  tmpvar_20 = ((tmpvar_19 * tmpvar_19) * (3.0 - (2.0 * tmpvar_19)));
					  highp vec2 tmpvar_21;
					  tmpvar_21 = (tmpvar_20.xz + tmpvar_20.yw);
					  bend_15.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_15.y = (bendingFact_9 * 0.3);
					  pos_14.xyz = (_glesVertex.xyz + ((
					    (tmpvar_21.xyx * bend_15)
					   + 
					    ((wind_10.xyz * tmpvar_21.y) * bendingFact_9)
					  ) * wind_10.w));
					  pos_14.xyz = (pos_14.xyz + (bendingFact_9 * wind_10.xyz));
					  tmpvar_8.xyz = pos_14.xyz;
					  highp vec4 tmpvar_22;
					  tmpvar_22.w = 1.0;
					  tmpvar_22.xyz = tmpvar_8.xyz;
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (unity_ObjectToWorld * tmpvar_8).xyz;
					  highp vec4 v_24;
					  v_24.x = unity_WorldToObject[0].x;
					  v_24.y = unity_WorldToObject[1].x;
					  v_24.z = unity_WorldToObject[2].x;
					  v_24.w = unity_WorldToObject[3].x;
					  highp vec4 v_25;
					  v_25.x = unity_WorldToObject[0].y;
					  v_25.y = unity_WorldToObject[1].y;
					  v_25.z = unity_WorldToObject[2].y;
					  v_25.w = unity_WorldToObject[3].y;
					  highp vec4 v_26;
					  v_26.x = unity_WorldToObject[0].z;
					  v_26.y = unity_WorldToObject[1].z;
					  v_26.z = unity_WorldToObject[2].z;
					  v_26.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_27;
					  tmpvar_27 = normalize(((
					    (v_24.xyz * _glesNormal.x)
					   + 
					    (v_25.xyz * _glesNormal.y)
					  ) + (v_26.xyz * _glesNormal.z)));
					  worldNormal_6 = tmpvar_27;
					  highp mat3 tmpvar_28;
					  tmpvar_28[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_28[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_28[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = normalize((tmpvar_28 * _glesTANGENT.xyz));
					  worldTangent_5 = tmpvar_29;
					  highp float tmpvar_30;
					  tmpvar_30 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_4 = tmpvar_30;
					  lowp vec3 tmpvar_31;
					  tmpvar_31 = (((worldNormal_6.yzx * worldTangent_5.zxy) - (worldNormal_6.zxy * worldTangent_5.yzx)) * tangentSign_4);
					  highp vec4 tmpvar_32;
					  tmpvar_32.x = worldTangent_5.x;
					  tmpvar_32.y = tmpvar_31.x;
					  tmpvar_32.z = worldNormal_6.x;
					  tmpvar_32.w = tmpvar_23.x;
					  highp vec4 tmpvar_33;
					  tmpvar_33.x = worldTangent_5.y;
					  tmpvar_33.y = tmpvar_31.y;
					  tmpvar_33.z = worldNormal_6.y;
					  tmpvar_33.w = tmpvar_23.y;
					  highp vec4 tmpvar_34;
					  tmpvar_34.x = worldTangent_5.z;
					  tmpvar_34.y = tmpvar_31.z;
					  tmpvar_34.z = worldNormal_6.z;
					  tmpvar_34.w = tmpvar_23.z;
					  lowp vec4 tmpvar_35;
					  tmpvar_35.w = 1.0;
					  tmpvar_35.xyz = worldNormal_6;
					  mediump vec4 normal_36;
					  normal_36 = tmpvar_35;
					  mediump vec3 res_37;
					  mediump vec3 x_38;
					  x_38.x = dot (unity_SHAr, normal_36);
					  x_38.y = dot (unity_SHAg, normal_36);
					  x_38.z = dot (unity_SHAb, normal_36);
					  mediump vec3 x1_39;
					  mediump vec4 tmpvar_40;
					  tmpvar_40 = (normal_36.xyzz * normal_36.yzzx);
					  x1_39.x = dot (unity_SHBr, tmpvar_40);
					  x1_39.y = dot (unity_SHBg, tmpvar_40);
					  x1_39.z = dot (unity_SHBb, tmpvar_40);
					  res_37 = (x_38 + (x1_39 + (unity_SHC.xyz * 
					    ((normal_36.x * normal_36.x) - (normal_36.y * normal_36.y))
					  )));
					  res_37 = max (((1.055 * 
					    pow (max (res_37, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_3 = res_37;
					  tmpvar_7 = shlight_3;
					  highp vec3 lightColor0_41;
					  lightColor0_41 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_42;
					  lightColor1_42 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_43;
					  lightColor2_43 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_44;
					  lightColor3_44 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_45;
					  lightAttenSq_45 = unity_4LightAtten0;
					  highp vec3 normal_46;
					  normal_46 = worldNormal_6;
					  highp vec3 col_47;
					  highp vec4 ndotl_48;
					  highp vec4 lengthSq_49;
					  highp vec4 tmpvar_50;
					  tmpvar_50 = (unity_4LightPosX0 - tmpvar_23.x);
					  highp vec4 tmpvar_51;
					  tmpvar_51 = (unity_4LightPosY0 - tmpvar_23.y);
					  highp vec4 tmpvar_52;
					  tmpvar_52 = (unity_4LightPosZ0 - tmpvar_23.z);
					  lengthSq_49 = (tmpvar_50 * tmpvar_50);
					  lengthSq_49 = (lengthSq_49 + (tmpvar_51 * tmpvar_51));
					  lengthSq_49 = (lengthSq_49 + (tmpvar_52 * tmpvar_52));
					  ndotl_48 = (tmpvar_50 * normal_46.x);
					  ndotl_48 = (ndotl_48 + (tmpvar_51 * normal_46.y));
					  ndotl_48 = (ndotl_48 + (tmpvar_52 * normal_46.z));
					  highp vec4 tmpvar_53;
					  tmpvar_53 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_48 * inversesqrt(lengthSq_49)));
					  ndotl_48 = tmpvar_53;
					  highp vec4 tmpvar_54;
					  tmpvar_54 = (tmpvar_53 * (1.0/((1.0 + 
					    (lengthSq_49 * lightAttenSq_45)
					  ))));
					  col_47 = (lightColor0_41 * tmpvar_54.x);
					  col_47 = (col_47 + (lightColor1_42 * tmpvar_54.y));
					  col_47 = (col_47 + (lightColor2_43 * tmpvar_54.z));
					  col_47 = (col_47 + (lightColor3_44 * tmpvar_54.w));
					  tmpvar_7 = (tmpvar_7 + col_47);
					  gl_Position = (glstate_matrix_mvp * tmpvar_22);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_32;
					  xlv_TEXCOORD2 = tmpvar_33;
					  xlv_TEXCOORD3 = tmpvar_34;
					  xlv_COLOR0 = tmpvar_2;
					  xlv_TEXCOORD4 = tmpvar_7;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					uniform sampler2D _GlossMap;
					uniform sampler2D _TranslucencyMap;
					uniform mediump float _Shininess;
					uniform lowp vec4 _Color;
					uniform lowp vec3 _TranslucencyColor;
					uniform lowp float _TranslucencyViewDependency;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
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
					  lowp float tmpvar_10;
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpvar_8 = ((tmpvar_11.xyz * _Color.xyz) * xlv_COLOR0.xyz);
					  tmpvar_10 = _Shininess;
					  lowp vec4 tmpvar_12;
					  tmpvar_12 = texture2D (_GlossMap, xlv_TEXCOORD0);
					  tmpvar_9 = tmpvar_12.w;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
					  lowp float x_14;
					  x_14 = (tmpvar_11.w - _Cutoff);
					  if ((x_14 < 0.0)) {
					    discard;
					  };
					  c_2.w = 0.0;
					  highp float tmpvar_15;
					  tmpvar_15 = dot (xlv_TEXCOORD1.xyz, tmpvar_13);
					  worldN_1.x = tmpvar_15;
					  highp float tmpvar_16;
					  tmpvar_16 = dot (xlv_TEXCOORD2.xyz, tmpvar_13);
					  worldN_1.y = tmpvar_16;
					  highp float tmpvar_17;
					  tmpvar_17 = dot (xlv_TEXCOORD3.xyz, tmpvar_13);
					  worldN_1.z = tmpvar_17;
					  c_2.xyz = (tmpvar_8 * xlv_TEXCOORD4);
					  mediump vec4 tmpvar_18;
					  mediump vec3 lightDir_19;
					  lightDir_19 = lightDir_4;
					  mediump vec3 viewDir_20;
					  viewDir_20 = worldViewDir_3;
					  lowp vec4 c_21;
					  mediump float tmpvar_22;
					  tmpvar_22 = dot (worldN_1, lightDir_19);
					  mediump float tmpvar_23;
					  tmpvar_23 = (pow (max (0.0, 
					    dot (worldN_1, normalize((lightDir_19 + viewDir_20)))
					  ), (tmpvar_9 * 128.0)) * tmpvar_10);
					  lowp float tmpvar_24;
					  mediump float tmpvar_25;
					  tmpvar_25 = clamp (dot (viewDir_20, -(lightDir_19)), 0.0, 1.0);
					  tmpvar_24 = tmpvar_25;
					  mediump float tmpvar_26;
					  tmpvar_26 = clamp (-(tmpvar_22), 0.0, 1.0);
					  mediump float tmpvar_27;
					  tmpvar_27 = max (0.0, ((tmpvar_22 * 0.6) + 0.4));
					  c_21.xyz = (tmpvar_8 * ((
					    (mix (tmpvar_26, tmpvar_24, _TranslucencyViewDependency) * texture2D (_TranslucencyMap, xlv_TEXCOORD0).xyz)
					   * 
					    (_TranslucencyColor * 2.0)
					  ) + tmpvar_27));
					  c_21.xyz = ((c_21.xyz * _LightColor0.xyz) + tmpvar_23);
					  c_21.xyz = (c_21.xyz * _LightColor0.xyz);
					  tmpvar_18 = c_21;
					  c_2 = (c_2 + tmpvar_18);
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
					uniform highp vec4 _Time;
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
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = _glesColor;
					  highp vec3 shlight_3;
					  lowp float tangentSign_4;
					  lowp vec3 worldTangent_5;
					  lowp vec3 worldNormal_6;
					  lowp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = tmpvar_1.w;
					  highp float bendingFact_9;
					  highp vec4 wind_10;
					  lowp float tmpvar_11;
					  tmpvar_11 = tmpvar_2.w;
					  bendingFact_9 = tmpvar_11;
					  highp mat3 tmpvar_12;
					  tmpvar_12[0] = unity_WorldToObject[0].xyz;
					  tmpvar_12[1] = unity_WorldToObject[1].xyz;
					  tmpvar_12[2] = unity_WorldToObject[2].xyz;
					  wind_10.xyz = (tmpvar_12 * _Wind.xyz);
					  wind_10.w = (_Wind.w * bendingFact_9);
					  highp vec2 tmpvar_13;
					  tmpvar_13.y = 1.0;
					  tmpvar_13.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_14;
					  pos_14.w = tmpvar_1.w;
					  highp vec3 bend_15;
					  highp vec4 v_16;
					  v_16.x = unity_ObjectToWorld[0].w;
					  v_16.y = unity_ObjectToWorld[1].w;
					  v_16.z = unity_ObjectToWorld[2].w;
					  v_16.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_17;
					  tmpvar_17 = dot (v_16.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_18;
					  tmpvar_18.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_17)));
					  tmpvar_18.y = tmpvar_17;
					  highp vec4 tmpvar_19;
					  tmpvar_19 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_13).xx + tmpvar_18).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_20;
					  tmpvar_20 = ((tmpvar_19 * tmpvar_19) * (3.0 - (2.0 * tmpvar_19)));
					  highp vec2 tmpvar_21;
					  tmpvar_21 = (tmpvar_20.xz + tmpvar_20.yw);
					  bend_15.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_15.y = (bendingFact_9 * 0.3);
					  pos_14.xyz = (_glesVertex.xyz + ((
					    (tmpvar_21.xyx * bend_15)
					   + 
					    ((wind_10.xyz * tmpvar_21.y) * bendingFact_9)
					  ) * wind_10.w));
					  pos_14.xyz = (pos_14.xyz + (bendingFact_9 * wind_10.xyz));
					  tmpvar_8.xyz = pos_14.xyz;
					  highp vec4 tmpvar_22;
					  tmpvar_22.w = 1.0;
					  tmpvar_22.xyz = tmpvar_8.xyz;
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (unity_ObjectToWorld * tmpvar_8).xyz;
					  highp vec4 v_24;
					  v_24.x = unity_WorldToObject[0].x;
					  v_24.y = unity_WorldToObject[1].x;
					  v_24.z = unity_WorldToObject[2].x;
					  v_24.w = unity_WorldToObject[3].x;
					  highp vec4 v_25;
					  v_25.x = unity_WorldToObject[0].y;
					  v_25.y = unity_WorldToObject[1].y;
					  v_25.z = unity_WorldToObject[2].y;
					  v_25.w = unity_WorldToObject[3].y;
					  highp vec4 v_26;
					  v_26.x = unity_WorldToObject[0].z;
					  v_26.y = unity_WorldToObject[1].z;
					  v_26.z = unity_WorldToObject[2].z;
					  v_26.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_27;
					  tmpvar_27 = normalize(((
					    (v_24.xyz * _glesNormal.x)
					   + 
					    (v_25.xyz * _glesNormal.y)
					  ) + (v_26.xyz * _glesNormal.z)));
					  worldNormal_6 = tmpvar_27;
					  highp mat3 tmpvar_28;
					  tmpvar_28[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_28[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_28[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = normalize((tmpvar_28 * _glesTANGENT.xyz));
					  worldTangent_5 = tmpvar_29;
					  highp float tmpvar_30;
					  tmpvar_30 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_4 = tmpvar_30;
					  lowp vec3 tmpvar_31;
					  tmpvar_31 = (((worldNormal_6.yzx * worldTangent_5.zxy) - (worldNormal_6.zxy * worldTangent_5.yzx)) * tangentSign_4);
					  highp vec4 tmpvar_32;
					  tmpvar_32.x = worldTangent_5.x;
					  tmpvar_32.y = tmpvar_31.x;
					  tmpvar_32.z = worldNormal_6.x;
					  tmpvar_32.w = tmpvar_23.x;
					  highp vec4 tmpvar_33;
					  tmpvar_33.x = worldTangent_5.y;
					  tmpvar_33.y = tmpvar_31.y;
					  tmpvar_33.z = worldNormal_6.y;
					  tmpvar_33.w = tmpvar_23.y;
					  highp vec4 tmpvar_34;
					  tmpvar_34.x = worldTangent_5.z;
					  tmpvar_34.y = tmpvar_31.z;
					  tmpvar_34.z = worldNormal_6.z;
					  tmpvar_34.w = tmpvar_23.z;
					  lowp vec4 tmpvar_35;
					  tmpvar_35.w = 1.0;
					  tmpvar_35.xyz = worldNormal_6;
					  mediump vec4 normal_36;
					  normal_36 = tmpvar_35;
					  mediump vec3 res_37;
					  mediump vec3 x_38;
					  x_38.x = dot (unity_SHAr, normal_36);
					  x_38.y = dot (unity_SHAg, normal_36);
					  x_38.z = dot (unity_SHAb, normal_36);
					  mediump vec3 x1_39;
					  mediump vec4 tmpvar_40;
					  tmpvar_40 = (normal_36.xyzz * normal_36.yzzx);
					  x1_39.x = dot (unity_SHBr, tmpvar_40);
					  x1_39.y = dot (unity_SHBg, tmpvar_40);
					  x1_39.z = dot (unity_SHBb, tmpvar_40);
					  res_37 = (x_38 + (x1_39 + (unity_SHC.xyz * 
					    ((normal_36.x * normal_36.x) - (normal_36.y * normal_36.y))
					  )));
					  res_37 = max (((1.055 * 
					    pow (max (res_37, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_3 = res_37;
					  tmpvar_7 = shlight_3;
					  highp vec3 lightColor0_41;
					  lightColor0_41 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_42;
					  lightColor1_42 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_43;
					  lightColor2_43 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_44;
					  lightColor3_44 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_45;
					  lightAttenSq_45 = unity_4LightAtten0;
					  highp vec3 normal_46;
					  normal_46 = worldNormal_6;
					  highp vec3 col_47;
					  highp vec4 ndotl_48;
					  highp vec4 lengthSq_49;
					  highp vec4 tmpvar_50;
					  tmpvar_50 = (unity_4LightPosX0 - tmpvar_23.x);
					  highp vec4 tmpvar_51;
					  tmpvar_51 = (unity_4LightPosY0 - tmpvar_23.y);
					  highp vec4 tmpvar_52;
					  tmpvar_52 = (unity_4LightPosZ0 - tmpvar_23.z);
					  lengthSq_49 = (tmpvar_50 * tmpvar_50);
					  lengthSq_49 = (lengthSq_49 + (tmpvar_51 * tmpvar_51));
					  lengthSq_49 = (lengthSq_49 + (tmpvar_52 * tmpvar_52));
					  ndotl_48 = (tmpvar_50 * normal_46.x);
					  ndotl_48 = (ndotl_48 + (tmpvar_51 * normal_46.y));
					  ndotl_48 = (ndotl_48 + (tmpvar_52 * normal_46.z));
					  highp vec4 tmpvar_53;
					  tmpvar_53 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_48 * inversesqrt(lengthSq_49)));
					  ndotl_48 = tmpvar_53;
					  highp vec4 tmpvar_54;
					  tmpvar_54 = (tmpvar_53 * (1.0/((1.0 + 
					    (lengthSq_49 * lightAttenSq_45)
					  ))));
					  col_47 = (lightColor0_41 * tmpvar_54.x);
					  col_47 = (col_47 + (lightColor1_42 * tmpvar_54.y));
					  col_47 = (col_47 + (lightColor2_43 * tmpvar_54.z));
					  col_47 = (col_47 + (lightColor3_44 * tmpvar_54.w));
					  tmpvar_7 = (tmpvar_7 + col_47);
					  gl_Position = (glstate_matrix_mvp * tmpvar_22);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_32;
					  xlv_TEXCOORD2 = tmpvar_33;
					  xlv_TEXCOORD3 = tmpvar_34;
					  xlv_COLOR0 = tmpvar_2;
					  xlv_TEXCOORD4 = tmpvar_7;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					uniform sampler2D _GlossMap;
					uniform sampler2D _TranslucencyMap;
					uniform mediump float _Shininess;
					uniform lowp vec4 _Color;
					uniform lowp vec3 _TranslucencyColor;
					uniform lowp float _TranslucencyViewDependency;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
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
					  lowp float tmpvar_10;
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpvar_8 = ((tmpvar_11.xyz * _Color.xyz) * xlv_COLOR0.xyz);
					  tmpvar_10 = _Shininess;
					  lowp vec4 tmpvar_12;
					  tmpvar_12 = texture2D (_GlossMap, xlv_TEXCOORD0);
					  tmpvar_9 = tmpvar_12.w;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
					  lowp float x_14;
					  x_14 = (tmpvar_11.w - _Cutoff);
					  if ((x_14 < 0.0)) {
					    discard;
					  };
					  c_2.w = 0.0;
					  highp float tmpvar_15;
					  tmpvar_15 = dot (xlv_TEXCOORD1.xyz, tmpvar_13);
					  worldN_1.x = tmpvar_15;
					  highp float tmpvar_16;
					  tmpvar_16 = dot (xlv_TEXCOORD2.xyz, tmpvar_13);
					  worldN_1.y = tmpvar_16;
					  highp float tmpvar_17;
					  tmpvar_17 = dot (xlv_TEXCOORD3.xyz, tmpvar_13);
					  worldN_1.z = tmpvar_17;
					  c_2.xyz = (tmpvar_8 * xlv_TEXCOORD4);
					  mediump vec4 tmpvar_18;
					  mediump vec3 lightDir_19;
					  lightDir_19 = lightDir_4;
					  mediump vec3 viewDir_20;
					  viewDir_20 = worldViewDir_3;
					  lowp vec4 c_21;
					  mediump float tmpvar_22;
					  tmpvar_22 = dot (worldN_1, lightDir_19);
					  mediump float tmpvar_23;
					  tmpvar_23 = (pow (max (0.0, 
					    dot (worldN_1, normalize((lightDir_19 + viewDir_20)))
					  ), (tmpvar_9 * 128.0)) * tmpvar_10);
					  lowp float tmpvar_24;
					  mediump float tmpvar_25;
					  tmpvar_25 = clamp (dot (viewDir_20, -(lightDir_19)), 0.0, 1.0);
					  tmpvar_24 = tmpvar_25;
					  mediump float tmpvar_26;
					  tmpvar_26 = clamp (-(tmpvar_22), 0.0, 1.0);
					  mediump float tmpvar_27;
					  tmpvar_27 = max (0.0, ((tmpvar_22 * 0.6) + 0.4));
					  c_21.xyz = (tmpvar_8 * ((
					    (mix (tmpvar_26, tmpvar_24, _TranslucencyViewDependency) * texture2D (_TranslucencyMap, xlv_TEXCOORD0).xyz)
					   * 
					    (_TranslucencyColor * 2.0)
					  ) + tmpvar_27));
					  c_21.xyz = ((c_21.xyz * _LightColor0.xyz) + tmpvar_23);
					  c_21.xyz = (c_21.xyz * _LightColor0.xyz);
					  tmpvar_18 = c_21;
					  c_2 = (c_2 + tmpvar_18);
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
					uniform highp vec4 _Time;
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
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = _glesColor;
					  highp vec3 shlight_3;
					  lowp float tangentSign_4;
					  lowp vec3 worldTangent_5;
					  lowp vec3 worldNormal_6;
					  lowp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = tmpvar_1.w;
					  highp float bendingFact_9;
					  highp vec4 wind_10;
					  lowp float tmpvar_11;
					  tmpvar_11 = tmpvar_2.w;
					  bendingFact_9 = tmpvar_11;
					  highp mat3 tmpvar_12;
					  tmpvar_12[0] = unity_WorldToObject[0].xyz;
					  tmpvar_12[1] = unity_WorldToObject[1].xyz;
					  tmpvar_12[2] = unity_WorldToObject[2].xyz;
					  wind_10.xyz = (tmpvar_12 * _Wind.xyz);
					  wind_10.w = (_Wind.w * bendingFact_9);
					  highp vec2 tmpvar_13;
					  tmpvar_13.y = 1.0;
					  tmpvar_13.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_14;
					  pos_14.w = tmpvar_1.w;
					  highp vec3 bend_15;
					  highp vec4 v_16;
					  v_16.x = unity_ObjectToWorld[0].w;
					  v_16.y = unity_ObjectToWorld[1].w;
					  v_16.z = unity_ObjectToWorld[2].w;
					  v_16.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_17;
					  tmpvar_17 = dot (v_16.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_18;
					  tmpvar_18.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_17)));
					  tmpvar_18.y = tmpvar_17;
					  highp vec4 tmpvar_19;
					  tmpvar_19 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_13).xx + tmpvar_18).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_20;
					  tmpvar_20 = ((tmpvar_19 * tmpvar_19) * (3.0 - (2.0 * tmpvar_19)));
					  highp vec2 tmpvar_21;
					  tmpvar_21 = (tmpvar_20.xz + tmpvar_20.yw);
					  bend_15.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_15.y = (bendingFact_9 * 0.3);
					  pos_14.xyz = (_glesVertex.xyz + ((
					    (tmpvar_21.xyx * bend_15)
					   + 
					    ((wind_10.xyz * tmpvar_21.y) * bendingFact_9)
					  ) * wind_10.w));
					  pos_14.xyz = (pos_14.xyz + (bendingFact_9 * wind_10.xyz));
					  tmpvar_8.xyz = pos_14.xyz;
					  highp vec4 tmpvar_22;
					  tmpvar_22.w = 1.0;
					  tmpvar_22.xyz = tmpvar_8.xyz;
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (unity_ObjectToWorld * tmpvar_8).xyz;
					  highp vec4 v_24;
					  v_24.x = unity_WorldToObject[0].x;
					  v_24.y = unity_WorldToObject[1].x;
					  v_24.z = unity_WorldToObject[2].x;
					  v_24.w = unity_WorldToObject[3].x;
					  highp vec4 v_25;
					  v_25.x = unity_WorldToObject[0].y;
					  v_25.y = unity_WorldToObject[1].y;
					  v_25.z = unity_WorldToObject[2].y;
					  v_25.w = unity_WorldToObject[3].y;
					  highp vec4 v_26;
					  v_26.x = unity_WorldToObject[0].z;
					  v_26.y = unity_WorldToObject[1].z;
					  v_26.z = unity_WorldToObject[2].z;
					  v_26.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_27;
					  tmpvar_27 = normalize(((
					    (v_24.xyz * _glesNormal.x)
					   + 
					    (v_25.xyz * _glesNormal.y)
					  ) + (v_26.xyz * _glesNormal.z)));
					  worldNormal_6 = tmpvar_27;
					  highp mat3 tmpvar_28;
					  tmpvar_28[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_28[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_28[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = normalize((tmpvar_28 * _glesTANGENT.xyz));
					  worldTangent_5 = tmpvar_29;
					  highp float tmpvar_30;
					  tmpvar_30 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_4 = tmpvar_30;
					  lowp vec3 tmpvar_31;
					  tmpvar_31 = (((worldNormal_6.yzx * worldTangent_5.zxy) - (worldNormal_6.zxy * worldTangent_5.yzx)) * tangentSign_4);
					  highp vec4 tmpvar_32;
					  tmpvar_32.x = worldTangent_5.x;
					  tmpvar_32.y = tmpvar_31.x;
					  tmpvar_32.z = worldNormal_6.x;
					  tmpvar_32.w = tmpvar_23.x;
					  highp vec4 tmpvar_33;
					  tmpvar_33.x = worldTangent_5.y;
					  tmpvar_33.y = tmpvar_31.y;
					  tmpvar_33.z = worldNormal_6.y;
					  tmpvar_33.w = tmpvar_23.y;
					  highp vec4 tmpvar_34;
					  tmpvar_34.x = worldTangent_5.z;
					  tmpvar_34.y = tmpvar_31.z;
					  tmpvar_34.z = worldNormal_6.z;
					  tmpvar_34.w = tmpvar_23.z;
					  lowp vec4 tmpvar_35;
					  tmpvar_35.w = 1.0;
					  tmpvar_35.xyz = worldNormal_6;
					  mediump vec4 normal_36;
					  normal_36 = tmpvar_35;
					  mediump vec3 res_37;
					  mediump vec3 x_38;
					  x_38.x = dot (unity_SHAr, normal_36);
					  x_38.y = dot (unity_SHAg, normal_36);
					  x_38.z = dot (unity_SHAb, normal_36);
					  mediump vec3 x1_39;
					  mediump vec4 tmpvar_40;
					  tmpvar_40 = (normal_36.xyzz * normal_36.yzzx);
					  x1_39.x = dot (unity_SHBr, tmpvar_40);
					  x1_39.y = dot (unity_SHBg, tmpvar_40);
					  x1_39.z = dot (unity_SHBb, tmpvar_40);
					  res_37 = (x_38 + (x1_39 + (unity_SHC.xyz * 
					    ((normal_36.x * normal_36.x) - (normal_36.y * normal_36.y))
					  )));
					  res_37 = max (((1.055 * 
					    pow (max (res_37, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_3 = res_37;
					  tmpvar_7 = shlight_3;
					  highp vec3 lightColor0_41;
					  lightColor0_41 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_42;
					  lightColor1_42 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_43;
					  lightColor2_43 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_44;
					  lightColor3_44 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_45;
					  lightAttenSq_45 = unity_4LightAtten0;
					  highp vec3 normal_46;
					  normal_46 = worldNormal_6;
					  highp vec3 col_47;
					  highp vec4 ndotl_48;
					  highp vec4 lengthSq_49;
					  highp vec4 tmpvar_50;
					  tmpvar_50 = (unity_4LightPosX0 - tmpvar_23.x);
					  highp vec4 tmpvar_51;
					  tmpvar_51 = (unity_4LightPosY0 - tmpvar_23.y);
					  highp vec4 tmpvar_52;
					  tmpvar_52 = (unity_4LightPosZ0 - tmpvar_23.z);
					  lengthSq_49 = (tmpvar_50 * tmpvar_50);
					  lengthSq_49 = (lengthSq_49 + (tmpvar_51 * tmpvar_51));
					  lengthSq_49 = (lengthSq_49 + (tmpvar_52 * tmpvar_52));
					  ndotl_48 = (tmpvar_50 * normal_46.x);
					  ndotl_48 = (ndotl_48 + (tmpvar_51 * normal_46.y));
					  ndotl_48 = (ndotl_48 + (tmpvar_52 * normal_46.z));
					  highp vec4 tmpvar_53;
					  tmpvar_53 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_48 * inversesqrt(lengthSq_49)));
					  ndotl_48 = tmpvar_53;
					  highp vec4 tmpvar_54;
					  tmpvar_54 = (tmpvar_53 * (1.0/((1.0 + 
					    (lengthSq_49 * lightAttenSq_45)
					  ))));
					  col_47 = (lightColor0_41 * tmpvar_54.x);
					  col_47 = (col_47 + (lightColor1_42 * tmpvar_54.y));
					  col_47 = (col_47 + (lightColor2_43 * tmpvar_54.z));
					  col_47 = (col_47 + (lightColor3_44 * tmpvar_54.w));
					  tmpvar_7 = (tmpvar_7 + col_47);
					  gl_Position = (glstate_matrix_mvp * tmpvar_22);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_32;
					  xlv_TEXCOORD2 = tmpvar_33;
					  xlv_TEXCOORD3 = tmpvar_34;
					  xlv_COLOR0 = tmpvar_2;
					  xlv_TEXCOORD4 = tmpvar_7;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					uniform sampler2D _GlossMap;
					uniform sampler2D _TranslucencyMap;
					uniform mediump float _Shininess;
					uniform lowp vec4 _Color;
					uniform lowp vec3 _TranslucencyColor;
					uniform lowp float _TranslucencyViewDependency;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
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
					  lowp float tmpvar_10;
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpvar_8 = ((tmpvar_11.xyz * _Color.xyz) * xlv_COLOR0.xyz);
					  tmpvar_10 = _Shininess;
					  lowp vec4 tmpvar_12;
					  tmpvar_12 = texture2D (_GlossMap, xlv_TEXCOORD0);
					  tmpvar_9 = tmpvar_12.w;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
					  lowp float x_14;
					  x_14 = (tmpvar_11.w - _Cutoff);
					  if ((x_14 < 0.0)) {
					    discard;
					  };
					  c_2.w = 0.0;
					  highp float tmpvar_15;
					  tmpvar_15 = dot (xlv_TEXCOORD1.xyz, tmpvar_13);
					  worldN_1.x = tmpvar_15;
					  highp float tmpvar_16;
					  tmpvar_16 = dot (xlv_TEXCOORD2.xyz, tmpvar_13);
					  worldN_1.y = tmpvar_16;
					  highp float tmpvar_17;
					  tmpvar_17 = dot (xlv_TEXCOORD3.xyz, tmpvar_13);
					  worldN_1.z = tmpvar_17;
					  c_2.xyz = (tmpvar_8 * xlv_TEXCOORD4);
					  mediump vec4 tmpvar_18;
					  mediump vec3 lightDir_19;
					  lightDir_19 = lightDir_4;
					  mediump vec3 viewDir_20;
					  viewDir_20 = worldViewDir_3;
					  lowp vec4 c_21;
					  mediump float tmpvar_22;
					  tmpvar_22 = dot (worldN_1, lightDir_19);
					  mediump float tmpvar_23;
					  tmpvar_23 = (pow (max (0.0, 
					    dot (worldN_1, normalize((lightDir_19 + viewDir_20)))
					  ), (tmpvar_9 * 128.0)) * tmpvar_10);
					  lowp float tmpvar_24;
					  mediump float tmpvar_25;
					  tmpvar_25 = clamp (dot (viewDir_20, -(lightDir_19)), 0.0, 1.0);
					  tmpvar_24 = tmpvar_25;
					  mediump float tmpvar_26;
					  tmpvar_26 = clamp (-(tmpvar_22), 0.0, 1.0);
					  mediump float tmpvar_27;
					  tmpvar_27 = max (0.0, ((tmpvar_22 * 0.6) + 0.4));
					  c_21.xyz = (tmpvar_8 * ((
					    (mix (tmpvar_26, tmpvar_24, _TranslucencyViewDependency) * texture2D (_TranslucencyMap, xlv_TEXCOORD0).xyz)
					   * 
					    (_TranslucencyColor * 2.0)
					  ) + tmpvar_27));
					  c_21.xyz = ((c_21.xyz * _LightColor0.xyz) + tmpvar_23);
					  c_21.xyz = (c_21.xyz * _LightColor0.xyz);
					  tmpvar_18 = c_21;
					  c_2 = (c_2 + tmpvar_18);
					  gl_FragData[0] = c_2;
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
					uniform highp vec4 _Time;
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
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = _glesColor;
					  highp vec3 shlight_3;
					  lowp float tangentSign_4;
					  lowp vec3 worldTangent_5;
					  lowp vec3 worldNormal_6;
					  lowp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = tmpvar_1.w;
					  highp float bendingFact_9;
					  highp vec4 wind_10;
					  lowp float tmpvar_11;
					  tmpvar_11 = tmpvar_2.w;
					  bendingFact_9 = tmpvar_11;
					  highp mat3 tmpvar_12;
					  tmpvar_12[0] = unity_WorldToObject[0].xyz;
					  tmpvar_12[1] = unity_WorldToObject[1].xyz;
					  tmpvar_12[2] = unity_WorldToObject[2].xyz;
					  wind_10.xyz = (tmpvar_12 * _Wind.xyz);
					  wind_10.w = (_Wind.w * bendingFact_9);
					  highp vec2 tmpvar_13;
					  tmpvar_13.y = 1.0;
					  tmpvar_13.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_14;
					  pos_14.w = tmpvar_1.w;
					  highp vec3 bend_15;
					  highp vec4 v_16;
					  v_16.x = unity_ObjectToWorld[0].w;
					  v_16.y = unity_ObjectToWorld[1].w;
					  v_16.z = unity_ObjectToWorld[2].w;
					  v_16.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_17;
					  tmpvar_17 = dot (v_16.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_18;
					  tmpvar_18.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_17)));
					  tmpvar_18.y = tmpvar_17;
					  highp vec4 tmpvar_19;
					  tmpvar_19 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_13).xx + tmpvar_18).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_20;
					  tmpvar_20 = ((tmpvar_19 * tmpvar_19) * (3.0 - (2.0 * tmpvar_19)));
					  highp vec2 tmpvar_21;
					  tmpvar_21 = (tmpvar_20.xz + tmpvar_20.yw);
					  bend_15.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_15.y = (bendingFact_9 * 0.3);
					  pos_14.xyz = (_glesVertex.xyz + ((
					    (tmpvar_21.xyx * bend_15)
					   + 
					    ((wind_10.xyz * tmpvar_21.y) * bendingFact_9)
					  ) * wind_10.w));
					  pos_14.xyz = (pos_14.xyz + (bendingFact_9 * wind_10.xyz));
					  tmpvar_8.xyz = pos_14.xyz;
					  highp vec4 tmpvar_22;
					  tmpvar_22.w = 1.0;
					  tmpvar_22.xyz = tmpvar_8.xyz;
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (unity_ObjectToWorld * tmpvar_8).xyz;
					  highp vec4 v_24;
					  v_24.x = unity_WorldToObject[0].x;
					  v_24.y = unity_WorldToObject[1].x;
					  v_24.z = unity_WorldToObject[2].x;
					  v_24.w = unity_WorldToObject[3].x;
					  highp vec4 v_25;
					  v_25.x = unity_WorldToObject[0].y;
					  v_25.y = unity_WorldToObject[1].y;
					  v_25.z = unity_WorldToObject[2].y;
					  v_25.w = unity_WorldToObject[3].y;
					  highp vec4 v_26;
					  v_26.x = unity_WorldToObject[0].z;
					  v_26.y = unity_WorldToObject[1].z;
					  v_26.z = unity_WorldToObject[2].z;
					  v_26.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_27;
					  tmpvar_27 = normalize(((
					    (v_24.xyz * _glesNormal.x)
					   + 
					    (v_25.xyz * _glesNormal.y)
					  ) + (v_26.xyz * _glesNormal.z)));
					  worldNormal_6 = tmpvar_27;
					  highp mat3 tmpvar_28;
					  tmpvar_28[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_28[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_28[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = normalize((tmpvar_28 * _glesTANGENT.xyz));
					  worldTangent_5 = tmpvar_29;
					  highp float tmpvar_30;
					  tmpvar_30 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_4 = tmpvar_30;
					  lowp vec3 tmpvar_31;
					  tmpvar_31 = (((worldNormal_6.yzx * worldTangent_5.zxy) - (worldNormal_6.zxy * worldTangent_5.yzx)) * tangentSign_4);
					  highp vec4 tmpvar_32;
					  tmpvar_32.x = worldTangent_5.x;
					  tmpvar_32.y = tmpvar_31.x;
					  tmpvar_32.z = worldNormal_6.x;
					  tmpvar_32.w = tmpvar_23.x;
					  highp vec4 tmpvar_33;
					  tmpvar_33.x = worldTangent_5.y;
					  tmpvar_33.y = tmpvar_31.y;
					  tmpvar_33.z = worldNormal_6.y;
					  tmpvar_33.w = tmpvar_23.y;
					  highp vec4 tmpvar_34;
					  tmpvar_34.x = worldTangent_5.z;
					  tmpvar_34.y = tmpvar_31.z;
					  tmpvar_34.z = worldNormal_6.z;
					  tmpvar_34.w = tmpvar_23.z;
					  lowp vec4 tmpvar_35;
					  tmpvar_35.w = 1.0;
					  tmpvar_35.xyz = worldNormal_6;
					  mediump vec4 normal_36;
					  normal_36 = tmpvar_35;
					  mediump vec3 res_37;
					  mediump vec3 x_38;
					  x_38.x = dot (unity_SHAr, normal_36);
					  x_38.y = dot (unity_SHAg, normal_36);
					  x_38.z = dot (unity_SHAb, normal_36);
					  mediump vec3 x1_39;
					  mediump vec4 tmpvar_40;
					  tmpvar_40 = (normal_36.xyzz * normal_36.yzzx);
					  x1_39.x = dot (unity_SHBr, tmpvar_40);
					  x1_39.y = dot (unity_SHBg, tmpvar_40);
					  x1_39.z = dot (unity_SHBb, tmpvar_40);
					  res_37 = (x_38 + (x1_39 + (unity_SHC.xyz * 
					    ((normal_36.x * normal_36.x) - (normal_36.y * normal_36.y))
					  )));
					  res_37 = max (((1.055 * 
					    pow (max (res_37, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_3 = res_37;
					  tmpvar_7 = shlight_3;
					  highp vec3 lightColor0_41;
					  lightColor0_41 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_42;
					  lightColor1_42 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_43;
					  lightColor2_43 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_44;
					  lightColor3_44 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_45;
					  lightAttenSq_45 = unity_4LightAtten0;
					  highp vec3 normal_46;
					  normal_46 = worldNormal_6;
					  highp vec3 col_47;
					  highp vec4 ndotl_48;
					  highp vec4 lengthSq_49;
					  highp vec4 tmpvar_50;
					  tmpvar_50 = (unity_4LightPosX0 - tmpvar_23.x);
					  highp vec4 tmpvar_51;
					  tmpvar_51 = (unity_4LightPosY0 - tmpvar_23.y);
					  highp vec4 tmpvar_52;
					  tmpvar_52 = (unity_4LightPosZ0 - tmpvar_23.z);
					  lengthSq_49 = (tmpvar_50 * tmpvar_50);
					  lengthSq_49 = (lengthSq_49 + (tmpvar_51 * tmpvar_51));
					  lengthSq_49 = (lengthSq_49 + (tmpvar_52 * tmpvar_52));
					  ndotl_48 = (tmpvar_50 * normal_46.x);
					  ndotl_48 = (ndotl_48 + (tmpvar_51 * normal_46.y));
					  ndotl_48 = (ndotl_48 + (tmpvar_52 * normal_46.z));
					  highp vec4 tmpvar_53;
					  tmpvar_53 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_48 * inversesqrt(lengthSq_49)));
					  ndotl_48 = tmpvar_53;
					  highp vec4 tmpvar_54;
					  tmpvar_54 = (tmpvar_53 * (1.0/((1.0 + 
					    (lengthSq_49 * lightAttenSq_45)
					  ))));
					  col_47 = (lightColor0_41 * tmpvar_54.x);
					  col_47 = (col_47 + (lightColor1_42 * tmpvar_54.y));
					  col_47 = (col_47 + (lightColor2_43 * tmpvar_54.z));
					  col_47 = (col_47 + (lightColor3_44 * tmpvar_54.w));
					  tmpvar_7 = (tmpvar_7 + col_47);
					  gl_Position = (glstate_matrix_mvp * tmpvar_22);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_32;
					  xlv_TEXCOORD2 = tmpvar_33;
					  xlv_TEXCOORD3 = tmpvar_34;
					  xlv_COLOR0 = tmpvar_2;
					  xlv_TEXCOORD4 = tmpvar_7;
					  xlv_TEXCOORD5 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * tmpvar_8));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					uniform sampler2D _GlossMap;
					uniform sampler2D _TranslucencyMap;
					uniform mediump float _Shininess;
					uniform lowp vec4 _Color;
					uniform lowp vec3 _TranslucencyColor;
					uniform lowp float _TranslucencyViewDependency;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
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
					  lowp float tmpvar_10;
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpvar_8 = ((tmpvar_11.xyz * _Color.xyz) * xlv_COLOR0.xyz);
					  tmpvar_10 = _Shininess;
					  lowp vec4 tmpvar_12;
					  tmpvar_12 = texture2D (_GlossMap, xlv_TEXCOORD0);
					  tmpvar_9 = tmpvar_12.w;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
					  lowp float x_14;
					  x_14 = (tmpvar_11.w - _Cutoff);
					  if ((x_14 < 0.0)) {
					    discard;
					  };
					  c_2.w = 0.0;
					  highp float tmpvar_15;
					  tmpvar_15 = dot (xlv_TEXCOORD1.xyz, tmpvar_13);
					  worldN_1.x = tmpvar_15;
					  highp float tmpvar_16;
					  tmpvar_16 = dot (xlv_TEXCOORD2.xyz, tmpvar_13);
					  worldN_1.y = tmpvar_16;
					  highp float tmpvar_17;
					  tmpvar_17 = dot (xlv_TEXCOORD3.xyz, tmpvar_13);
					  worldN_1.z = tmpvar_17;
					  c_2.xyz = (tmpvar_8 * xlv_TEXCOORD4);
					  mediump vec4 tmpvar_18;
					  mediump vec3 lightDir_19;
					  lightDir_19 = lightDir_4;
					  mediump vec3 viewDir_20;
					  viewDir_20 = worldViewDir_3;
					  lowp vec4 c_21;
					  mediump float tmpvar_22;
					  tmpvar_22 = dot (worldN_1, lightDir_19);
					  mediump float tmpvar_23;
					  tmpvar_23 = (pow (max (0.0, 
					    dot (worldN_1, normalize((lightDir_19 + viewDir_20)))
					  ), (tmpvar_9 * 128.0)) * tmpvar_10);
					  lowp float tmpvar_24;
					  mediump float tmpvar_25;
					  tmpvar_25 = clamp (dot (viewDir_20, -(lightDir_19)), 0.0, 1.0);
					  tmpvar_24 = tmpvar_25;
					  mediump float tmpvar_26;
					  tmpvar_26 = clamp (-(tmpvar_22), 0.0, 1.0);
					  mediump float tmpvar_27;
					  tmpvar_27 = max (0.0, ((tmpvar_22 * 0.6) + 0.4));
					  c_21.xyz = (tmpvar_8 * ((
					    (mix (tmpvar_26, tmpvar_24, _TranslucencyViewDependency) * texture2D (_TranslucencyMap, xlv_TEXCOORD0).xyz)
					   * 
					    (_TranslucencyColor * 2.0)
					  ) + tmpvar_27));
					  c_21.xyz = ((c_21.xyz * _LightColor0.xyz) + tmpvar_23);
					  c_21.xyz = (c_21.xyz * _LightColor0.xyz);
					  tmpvar_18 = c_21;
					  c_2 = (c_2 + tmpvar_18);
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
					uniform highp vec4 _Time;
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
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = _glesColor;
					  highp vec3 shlight_3;
					  lowp float tangentSign_4;
					  lowp vec3 worldTangent_5;
					  lowp vec3 worldNormal_6;
					  lowp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = tmpvar_1.w;
					  highp float bendingFact_9;
					  highp vec4 wind_10;
					  lowp float tmpvar_11;
					  tmpvar_11 = tmpvar_2.w;
					  bendingFact_9 = tmpvar_11;
					  highp mat3 tmpvar_12;
					  tmpvar_12[0] = unity_WorldToObject[0].xyz;
					  tmpvar_12[1] = unity_WorldToObject[1].xyz;
					  tmpvar_12[2] = unity_WorldToObject[2].xyz;
					  wind_10.xyz = (tmpvar_12 * _Wind.xyz);
					  wind_10.w = (_Wind.w * bendingFact_9);
					  highp vec2 tmpvar_13;
					  tmpvar_13.y = 1.0;
					  tmpvar_13.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_14;
					  pos_14.w = tmpvar_1.w;
					  highp vec3 bend_15;
					  highp vec4 v_16;
					  v_16.x = unity_ObjectToWorld[0].w;
					  v_16.y = unity_ObjectToWorld[1].w;
					  v_16.z = unity_ObjectToWorld[2].w;
					  v_16.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_17;
					  tmpvar_17 = dot (v_16.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_18;
					  tmpvar_18.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_17)));
					  tmpvar_18.y = tmpvar_17;
					  highp vec4 tmpvar_19;
					  tmpvar_19 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_13).xx + tmpvar_18).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_20;
					  tmpvar_20 = ((tmpvar_19 * tmpvar_19) * (3.0 - (2.0 * tmpvar_19)));
					  highp vec2 tmpvar_21;
					  tmpvar_21 = (tmpvar_20.xz + tmpvar_20.yw);
					  bend_15.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_15.y = (bendingFact_9 * 0.3);
					  pos_14.xyz = (_glesVertex.xyz + ((
					    (tmpvar_21.xyx * bend_15)
					   + 
					    ((wind_10.xyz * tmpvar_21.y) * bendingFact_9)
					  ) * wind_10.w));
					  pos_14.xyz = (pos_14.xyz + (bendingFact_9 * wind_10.xyz));
					  tmpvar_8.xyz = pos_14.xyz;
					  highp vec4 tmpvar_22;
					  tmpvar_22.w = 1.0;
					  tmpvar_22.xyz = tmpvar_8.xyz;
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (unity_ObjectToWorld * tmpvar_8).xyz;
					  highp vec4 v_24;
					  v_24.x = unity_WorldToObject[0].x;
					  v_24.y = unity_WorldToObject[1].x;
					  v_24.z = unity_WorldToObject[2].x;
					  v_24.w = unity_WorldToObject[3].x;
					  highp vec4 v_25;
					  v_25.x = unity_WorldToObject[0].y;
					  v_25.y = unity_WorldToObject[1].y;
					  v_25.z = unity_WorldToObject[2].y;
					  v_25.w = unity_WorldToObject[3].y;
					  highp vec4 v_26;
					  v_26.x = unity_WorldToObject[0].z;
					  v_26.y = unity_WorldToObject[1].z;
					  v_26.z = unity_WorldToObject[2].z;
					  v_26.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_27;
					  tmpvar_27 = normalize(((
					    (v_24.xyz * _glesNormal.x)
					   + 
					    (v_25.xyz * _glesNormal.y)
					  ) + (v_26.xyz * _glesNormal.z)));
					  worldNormal_6 = tmpvar_27;
					  highp mat3 tmpvar_28;
					  tmpvar_28[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_28[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_28[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = normalize((tmpvar_28 * _glesTANGENT.xyz));
					  worldTangent_5 = tmpvar_29;
					  highp float tmpvar_30;
					  tmpvar_30 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_4 = tmpvar_30;
					  lowp vec3 tmpvar_31;
					  tmpvar_31 = (((worldNormal_6.yzx * worldTangent_5.zxy) - (worldNormal_6.zxy * worldTangent_5.yzx)) * tangentSign_4);
					  highp vec4 tmpvar_32;
					  tmpvar_32.x = worldTangent_5.x;
					  tmpvar_32.y = tmpvar_31.x;
					  tmpvar_32.z = worldNormal_6.x;
					  tmpvar_32.w = tmpvar_23.x;
					  highp vec4 tmpvar_33;
					  tmpvar_33.x = worldTangent_5.y;
					  tmpvar_33.y = tmpvar_31.y;
					  tmpvar_33.z = worldNormal_6.y;
					  tmpvar_33.w = tmpvar_23.y;
					  highp vec4 tmpvar_34;
					  tmpvar_34.x = worldTangent_5.z;
					  tmpvar_34.y = tmpvar_31.z;
					  tmpvar_34.z = worldNormal_6.z;
					  tmpvar_34.w = tmpvar_23.z;
					  lowp vec4 tmpvar_35;
					  tmpvar_35.w = 1.0;
					  tmpvar_35.xyz = worldNormal_6;
					  mediump vec4 normal_36;
					  normal_36 = tmpvar_35;
					  mediump vec3 res_37;
					  mediump vec3 x_38;
					  x_38.x = dot (unity_SHAr, normal_36);
					  x_38.y = dot (unity_SHAg, normal_36);
					  x_38.z = dot (unity_SHAb, normal_36);
					  mediump vec3 x1_39;
					  mediump vec4 tmpvar_40;
					  tmpvar_40 = (normal_36.xyzz * normal_36.yzzx);
					  x1_39.x = dot (unity_SHBr, tmpvar_40);
					  x1_39.y = dot (unity_SHBg, tmpvar_40);
					  x1_39.z = dot (unity_SHBb, tmpvar_40);
					  res_37 = (x_38 + (x1_39 + (unity_SHC.xyz * 
					    ((normal_36.x * normal_36.x) - (normal_36.y * normal_36.y))
					  )));
					  res_37 = max (((1.055 * 
					    pow (max (res_37, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_3 = res_37;
					  tmpvar_7 = shlight_3;
					  highp vec3 lightColor0_41;
					  lightColor0_41 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_42;
					  lightColor1_42 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_43;
					  lightColor2_43 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_44;
					  lightColor3_44 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_45;
					  lightAttenSq_45 = unity_4LightAtten0;
					  highp vec3 normal_46;
					  normal_46 = worldNormal_6;
					  highp vec3 col_47;
					  highp vec4 ndotl_48;
					  highp vec4 lengthSq_49;
					  highp vec4 tmpvar_50;
					  tmpvar_50 = (unity_4LightPosX0 - tmpvar_23.x);
					  highp vec4 tmpvar_51;
					  tmpvar_51 = (unity_4LightPosY0 - tmpvar_23.y);
					  highp vec4 tmpvar_52;
					  tmpvar_52 = (unity_4LightPosZ0 - tmpvar_23.z);
					  lengthSq_49 = (tmpvar_50 * tmpvar_50);
					  lengthSq_49 = (lengthSq_49 + (tmpvar_51 * tmpvar_51));
					  lengthSq_49 = (lengthSq_49 + (tmpvar_52 * tmpvar_52));
					  ndotl_48 = (tmpvar_50 * normal_46.x);
					  ndotl_48 = (ndotl_48 + (tmpvar_51 * normal_46.y));
					  ndotl_48 = (ndotl_48 + (tmpvar_52 * normal_46.z));
					  highp vec4 tmpvar_53;
					  tmpvar_53 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_48 * inversesqrt(lengthSq_49)));
					  ndotl_48 = tmpvar_53;
					  highp vec4 tmpvar_54;
					  tmpvar_54 = (tmpvar_53 * (1.0/((1.0 + 
					    (lengthSq_49 * lightAttenSq_45)
					  ))));
					  col_47 = (lightColor0_41 * tmpvar_54.x);
					  col_47 = (col_47 + (lightColor1_42 * tmpvar_54.y));
					  col_47 = (col_47 + (lightColor2_43 * tmpvar_54.z));
					  col_47 = (col_47 + (lightColor3_44 * tmpvar_54.w));
					  tmpvar_7 = (tmpvar_7 + col_47);
					  gl_Position = (glstate_matrix_mvp * tmpvar_22);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_32;
					  xlv_TEXCOORD2 = tmpvar_33;
					  xlv_TEXCOORD3 = tmpvar_34;
					  xlv_COLOR0 = tmpvar_2;
					  xlv_TEXCOORD4 = tmpvar_7;
					  xlv_TEXCOORD5 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * tmpvar_8));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					uniform sampler2D _GlossMap;
					uniform sampler2D _TranslucencyMap;
					uniform mediump float _Shininess;
					uniform lowp vec4 _Color;
					uniform lowp vec3 _TranslucencyColor;
					uniform lowp float _TranslucencyViewDependency;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
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
					  lowp float tmpvar_10;
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpvar_8 = ((tmpvar_11.xyz * _Color.xyz) * xlv_COLOR0.xyz);
					  tmpvar_10 = _Shininess;
					  lowp vec4 tmpvar_12;
					  tmpvar_12 = texture2D (_GlossMap, xlv_TEXCOORD0);
					  tmpvar_9 = tmpvar_12.w;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
					  lowp float x_14;
					  x_14 = (tmpvar_11.w - _Cutoff);
					  if ((x_14 < 0.0)) {
					    discard;
					  };
					  c_2.w = 0.0;
					  highp float tmpvar_15;
					  tmpvar_15 = dot (xlv_TEXCOORD1.xyz, tmpvar_13);
					  worldN_1.x = tmpvar_15;
					  highp float tmpvar_16;
					  tmpvar_16 = dot (xlv_TEXCOORD2.xyz, tmpvar_13);
					  worldN_1.y = tmpvar_16;
					  highp float tmpvar_17;
					  tmpvar_17 = dot (xlv_TEXCOORD3.xyz, tmpvar_13);
					  worldN_1.z = tmpvar_17;
					  c_2.xyz = (tmpvar_8 * xlv_TEXCOORD4);
					  mediump vec4 tmpvar_18;
					  mediump vec3 lightDir_19;
					  lightDir_19 = lightDir_4;
					  mediump vec3 viewDir_20;
					  viewDir_20 = worldViewDir_3;
					  lowp vec4 c_21;
					  mediump float tmpvar_22;
					  tmpvar_22 = dot (worldN_1, lightDir_19);
					  mediump float tmpvar_23;
					  tmpvar_23 = (pow (max (0.0, 
					    dot (worldN_1, normalize((lightDir_19 + viewDir_20)))
					  ), (tmpvar_9 * 128.0)) * tmpvar_10);
					  lowp float tmpvar_24;
					  mediump float tmpvar_25;
					  tmpvar_25 = clamp (dot (viewDir_20, -(lightDir_19)), 0.0, 1.0);
					  tmpvar_24 = tmpvar_25;
					  mediump float tmpvar_26;
					  tmpvar_26 = clamp (-(tmpvar_22), 0.0, 1.0);
					  mediump float tmpvar_27;
					  tmpvar_27 = max (0.0, ((tmpvar_22 * 0.6) + 0.4));
					  c_21.xyz = (tmpvar_8 * ((
					    (mix (tmpvar_26, tmpvar_24, _TranslucencyViewDependency) * texture2D (_TranslucencyMap, xlv_TEXCOORD0).xyz)
					   * 
					    (_TranslucencyColor * 2.0)
					  ) + tmpvar_27));
					  c_21.xyz = ((c_21.xyz * _LightColor0.xyz) + tmpvar_23);
					  c_21.xyz = (c_21.xyz * _LightColor0.xyz);
					  tmpvar_18 = c_21;
					  c_2 = (c_2 + tmpvar_18);
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
					uniform highp vec4 _Time;
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
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying lowp vec3 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = _glesColor;
					  highp vec3 shlight_3;
					  lowp float tangentSign_4;
					  lowp vec3 worldTangent_5;
					  lowp vec3 worldNormal_6;
					  lowp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = tmpvar_1.w;
					  highp float bendingFact_9;
					  highp vec4 wind_10;
					  lowp float tmpvar_11;
					  tmpvar_11 = tmpvar_2.w;
					  bendingFact_9 = tmpvar_11;
					  highp mat3 tmpvar_12;
					  tmpvar_12[0] = unity_WorldToObject[0].xyz;
					  tmpvar_12[1] = unity_WorldToObject[1].xyz;
					  tmpvar_12[2] = unity_WorldToObject[2].xyz;
					  wind_10.xyz = (tmpvar_12 * _Wind.xyz);
					  wind_10.w = (_Wind.w * bendingFact_9);
					  highp vec2 tmpvar_13;
					  tmpvar_13.y = 1.0;
					  tmpvar_13.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_14;
					  pos_14.w = tmpvar_1.w;
					  highp vec3 bend_15;
					  highp vec4 v_16;
					  v_16.x = unity_ObjectToWorld[0].w;
					  v_16.y = unity_ObjectToWorld[1].w;
					  v_16.z = unity_ObjectToWorld[2].w;
					  v_16.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_17;
					  tmpvar_17 = dot (v_16.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_18;
					  tmpvar_18.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_17)));
					  tmpvar_18.y = tmpvar_17;
					  highp vec4 tmpvar_19;
					  tmpvar_19 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_13).xx + tmpvar_18).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_20;
					  tmpvar_20 = ((tmpvar_19 * tmpvar_19) * (3.0 - (2.0 * tmpvar_19)));
					  highp vec2 tmpvar_21;
					  tmpvar_21 = (tmpvar_20.xz + tmpvar_20.yw);
					  bend_15.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_15.y = (bendingFact_9 * 0.3);
					  pos_14.xyz = (_glesVertex.xyz + ((
					    (tmpvar_21.xyx * bend_15)
					   + 
					    ((wind_10.xyz * tmpvar_21.y) * bendingFact_9)
					  ) * wind_10.w));
					  pos_14.xyz = (pos_14.xyz + (bendingFact_9 * wind_10.xyz));
					  tmpvar_8.xyz = pos_14.xyz;
					  highp vec4 tmpvar_22;
					  tmpvar_22.w = 1.0;
					  tmpvar_22.xyz = tmpvar_8.xyz;
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (unity_ObjectToWorld * tmpvar_8).xyz;
					  highp vec4 v_24;
					  v_24.x = unity_WorldToObject[0].x;
					  v_24.y = unity_WorldToObject[1].x;
					  v_24.z = unity_WorldToObject[2].x;
					  v_24.w = unity_WorldToObject[3].x;
					  highp vec4 v_25;
					  v_25.x = unity_WorldToObject[0].y;
					  v_25.y = unity_WorldToObject[1].y;
					  v_25.z = unity_WorldToObject[2].y;
					  v_25.w = unity_WorldToObject[3].y;
					  highp vec4 v_26;
					  v_26.x = unity_WorldToObject[0].z;
					  v_26.y = unity_WorldToObject[1].z;
					  v_26.z = unity_WorldToObject[2].z;
					  v_26.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_27;
					  tmpvar_27 = normalize(((
					    (v_24.xyz * _glesNormal.x)
					   + 
					    (v_25.xyz * _glesNormal.y)
					  ) + (v_26.xyz * _glesNormal.z)));
					  worldNormal_6 = tmpvar_27;
					  highp mat3 tmpvar_28;
					  tmpvar_28[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_28[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_28[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = normalize((tmpvar_28 * _glesTANGENT.xyz));
					  worldTangent_5 = tmpvar_29;
					  highp float tmpvar_30;
					  tmpvar_30 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_4 = tmpvar_30;
					  lowp vec3 tmpvar_31;
					  tmpvar_31 = (((worldNormal_6.yzx * worldTangent_5.zxy) - (worldNormal_6.zxy * worldTangent_5.yzx)) * tangentSign_4);
					  highp vec4 tmpvar_32;
					  tmpvar_32.x = worldTangent_5.x;
					  tmpvar_32.y = tmpvar_31.x;
					  tmpvar_32.z = worldNormal_6.x;
					  tmpvar_32.w = tmpvar_23.x;
					  highp vec4 tmpvar_33;
					  tmpvar_33.x = worldTangent_5.y;
					  tmpvar_33.y = tmpvar_31.y;
					  tmpvar_33.z = worldNormal_6.y;
					  tmpvar_33.w = tmpvar_23.y;
					  highp vec4 tmpvar_34;
					  tmpvar_34.x = worldTangent_5.z;
					  tmpvar_34.y = tmpvar_31.z;
					  tmpvar_34.z = worldNormal_6.z;
					  tmpvar_34.w = tmpvar_23.z;
					  lowp vec4 tmpvar_35;
					  tmpvar_35.w = 1.0;
					  tmpvar_35.xyz = worldNormal_6;
					  mediump vec4 normal_36;
					  normal_36 = tmpvar_35;
					  mediump vec3 res_37;
					  mediump vec3 x_38;
					  x_38.x = dot (unity_SHAr, normal_36);
					  x_38.y = dot (unity_SHAg, normal_36);
					  x_38.z = dot (unity_SHAb, normal_36);
					  mediump vec3 x1_39;
					  mediump vec4 tmpvar_40;
					  tmpvar_40 = (normal_36.xyzz * normal_36.yzzx);
					  x1_39.x = dot (unity_SHBr, tmpvar_40);
					  x1_39.y = dot (unity_SHBg, tmpvar_40);
					  x1_39.z = dot (unity_SHBb, tmpvar_40);
					  res_37 = (x_38 + (x1_39 + (unity_SHC.xyz * 
					    ((normal_36.x * normal_36.x) - (normal_36.y * normal_36.y))
					  )));
					  res_37 = max (((1.055 * 
					    pow (max (res_37, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_3 = res_37;
					  tmpvar_7 = shlight_3;
					  highp vec3 lightColor0_41;
					  lightColor0_41 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_42;
					  lightColor1_42 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_43;
					  lightColor2_43 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_44;
					  lightColor3_44 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_45;
					  lightAttenSq_45 = unity_4LightAtten0;
					  highp vec3 normal_46;
					  normal_46 = worldNormal_6;
					  highp vec3 col_47;
					  highp vec4 ndotl_48;
					  highp vec4 lengthSq_49;
					  highp vec4 tmpvar_50;
					  tmpvar_50 = (unity_4LightPosX0 - tmpvar_23.x);
					  highp vec4 tmpvar_51;
					  tmpvar_51 = (unity_4LightPosY0 - tmpvar_23.y);
					  highp vec4 tmpvar_52;
					  tmpvar_52 = (unity_4LightPosZ0 - tmpvar_23.z);
					  lengthSq_49 = (tmpvar_50 * tmpvar_50);
					  lengthSq_49 = (lengthSq_49 + (tmpvar_51 * tmpvar_51));
					  lengthSq_49 = (lengthSq_49 + (tmpvar_52 * tmpvar_52));
					  ndotl_48 = (tmpvar_50 * normal_46.x);
					  ndotl_48 = (ndotl_48 + (tmpvar_51 * normal_46.y));
					  ndotl_48 = (ndotl_48 + (tmpvar_52 * normal_46.z));
					  highp vec4 tmpvar_53;
					  tmpvar_53 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_48 * inversesqrt(lengthSq_49)));
					  ndotl_48 = tmpvar_53;
					  highp vec4 tmpvar_54;
					  tmpvar_54 = (tmpvar_53 * (1.0/((1.0 + 
					    (lengthSq_49 * lightAttenSq_45)
					  ))));
					  col_47 = (lightColor0_41 * tmpvar_54.x);
					  col_47 = (col_47 + (lightColor1_42 * tmpvar_54.y));
					  col_47 = (col_47 + (lightColor2_43 * tmpvar_54.z));
					  col_47 = (col_47 + (lightColor3_44 * tmpvar_54.w));
					  tmpvar_7 = (tmpvar_7 + col_47);
					  gl_Position = (glstate_matrix_mvp * tmpvar_22);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_32;
					  xlv_TEXCOORD2 = tmpvar_33;
					  xlv_TEXCOORD3 = tmpvar_34;
					  xlv_COLOR0 = tmpvar_2;
					  xlv_TEXCOORD4 = tmpvar_7;
					  xlv_TEXCOORD5 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * tmpvar_8));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					uniform sampler2D _GlossMap;
					uniform sampler2D _TranslucencyMap;
					uniform mediump float _Shininess;
					uniform lowp vec4 _Color;
					uniform lowp vec3 _TranslucencyColor;
					uniform lowp float _TranslucencyViewDependency;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
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
					  lowp float tmpvar_10;
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpvar_8 = ((tmpvar_11.xyz * _Color.xyz) * xlv_COLOR0.xyz);
					  tmpvar_10 = _Shininess;
					  lowp vec4 tmpvar_12;
					  tmpvar_12 = texture2D (_GlossMap, xlv_TEXCOORD0);
					  tmpvar_9 = tmpvar_12.w;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
					  lowp float x_14;
					  x_14 = (tmpvar_11.w - _Cutoff);
					  if ((x_14 < 0.0)) {
					    discard;
					  };
					  c_2.w = 0.0;
					  highp float tmpvar_15;
					  tmpvar_15 = dot (xlv_TEXCOORD1.xyz, tmpvar_13);
					  worldN_1.x = tmpvar_15;
					  highp float tmpvar_16;
					  tmpvar_16 = dot (xlv_TEXCOORD2.xyz, tmpvar_13);
					  worldN_1.y = tmpvar_16;
					  highp float tmpvar_17;
					  tmpvar_17 = dot (xlv_TEXCOORD3.xyz, tmpvar_13);
					  worldN_1.z = tmpvar_17;
					  c_2.xyz = (tmpvar_8 * xlv_TEXCOORD4);
					  mediump vec4 tmpvar_18;
					  mediump vec3 lightDir_19;
					  lightDir_19 = lightDir_4;
					  mediump vec3 viewDir_20;
					  viewDir_20 = worldViewDir_3;
					  lowp vec4 c_21;
					  mediump float tmpvar_22;
					  tmpvar_22 = dot (worldN_1, lightDir_19);
					  mediump float tmpvar_23;
					  tmpvar_23 = (pow (max (0.0, 
					    dot (worldN_1, normalize((lightDir_19 + viewDir_20)))
					  ), (tmpvar_9 * 128.0)) * tmpvar_10);
					  lowp float tmpvar_24;
					  mediump float tmpvar_25;
					  tmpvar_25 = clamp (dot (viewDir_20, -(lightDir_19)), 0.0, 1.0);
					  tmpvar_24 = tmpvar_25;
					  mediump float tmpvar_26;
					  tmpvar_26 = clamp (-(tmpvar_22), 0.0, 1.0);
					  mediump float tmpvar_27;
					  tmpvar_27 = max (0.0, ((tmpvar_22 * 0.6) + 0.4));
					  c_21.xyz = (tmpvar_8 * ((
					    (mix (tmpvar_26, tmpvar_24, _TranslucencyViewDependency) * texture2D (_TranslucencyMap, xlv_TEXCOORD0).xyz)
					   * 
					    (_TranslucencyColor * 2.0)
					  ) + tmpvar_27));
					  c_21.xyz = ((c_21.xyz * _LightColor0.xyz) + tmpvar_23);
					  c_21.xyz = (c_21.xyz * _LightColor0.xyz);
					  tmpvar_18 = c_21;
					  c_2 = (c_2 + tmpvar_18);
					  gl_FragData[0] = c_2;
					}
					
					
					#endif
}
}
Program "fp" {
// Platform gles3 skipped due to earlier errors
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
}
SubProgram "gles hw_tier03 " {
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
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "IGNOREPROJECTOR"="true" "RenderType"="TreeLeaf" }
  ZWrite Off
  Cull Off
  Blend One One
  ColorMask RGB
  GpuProgramID 99718
Program "vp" {
// Platform gles3 had shader errors
//   Keywords { "POINT" }
//   Keywords { "POINT" }
//   Keywords { "POINT" }
//   Keywords { "DIRECTIONAL" }
//   Keywords { "DIRECTIONAL" }
//   Keywords { "DIRECTIONAL" }
//   Keywords { "SPOT" }
//   Keywords { "SPOT" }
//   Keywords { "SPOT" }
//   Keywords { "POINT_COOKIE" }
//   Keywords { "POINT_COOKIE" }
//   Keywords { "POINT_COOKIE" }
//   Keywords { "DIRECTIONAL_COOKIE" }
//   Keywords { "DIRECTIONAL_COOKIE" }
//   Keywords { "DIRECTIONAL_COOKIE" }
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
					uniform highp vec4 _Time;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = _glesColor;
					  lowp float tangentSign_3;
					  lowp vec3 worldTangent_4;
					  lowp vec3 worldNormal_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = tmpvar_1.w;
					  highp float bendingFact_7;
					  highp vec4 wind_8;
					  lowp float tmpvar_9;
					  tmpvar_9 = tmpvar_2.w;
					  bendingFact_7 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_WorldToObject[0].xyz;
					  tmpvar_10[1] = unity_WorldToObject[1].xyz;
					  tmpvar_10[2] = unity_WorldToObject[2].xyz;
					  wind_8.xyz = (tmpvar_10 * _Wind.xyz);
					  wind_8.w = (_Wind.w * bendingFact_7);
					  highp vec2 tmpvar_11;
					  tmpvar_11.y = 1.0;
					  tmpvar_11.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_12;
					  pos_12.w = tmpvar_1.w;
					  highp vec3 bend_13;
					  highp vec4 v_14;
					  v_14.x = unity_ObjectToWorld[0].w;
					  v_14.y = unity_ObjectToWorld[1].w;
					  v_14.z = unity_ObjectToWorld[2].w;
					  v_14.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_15;
					  tmpvar_15 = dot (v_14.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_15)));
					  tmpvar_16.y = tmpvar_15;
					  highp vec4 tmpvar_17;
					  tmpvar_17 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_11).xx + tmpvar_16).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_18;
					  tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
					  highp vec2 tmpvar_19;
					  tmpvar_19 = (tmpvar_18.xz + tmpvar_18.yw);
					  bend_13.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_13.y = (bendingFact_7 * 0.3);
					  pos_12.xyz = (_glesVertex.xyz + ((
					    (tmpvar_19.xyx * bend_13)
					   + 
					    ((wind_8.xyz * tmpvar_19.y) * bendingFact_7)
					  ) * wind_8.w));
					  pos_12.xyz = (pos_12.xyz + (bendingFact_7 * wind_8.xyz));
					  tmpvar_6.xyz = pos_12.xyz;
					  highp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = tmpvar_6.xyz;
					  highp vec4 v_21;
					  v_21.x = unity_WorldToObject[0].x;
					  v_21.y = unity_WorldToObject[1].x;
					  v_21.z = unity_WorldToObject[2].x;
					  v_21.w = unity_WorldToObject[3].x;
					  highp vec4 v_22;
					  v_22.x = unity_WorldToObject[0].y;
					  v_22.y = unity_WorldToObject[1].y;
					  v_22.z = unity_WorldToObject[2].y;
					  v_22.w = unity_WorldToObject[3].y;
					  highp vec4 v_23;
					  v_23.x = unity_WorldToObject[0].z;
					  v_23.y = unity_WorldToObject[1].z;
					  v_23.z = unity_WorldToObject[2].z;
					  v_23.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_24;
					  tmpvar_24 = normalize(((
					    (v_21.xyz * _glesNormal.x)
					   + 
					    (v_22.xyz * _glesNormal.y)
					  ) + (v_23.xyz * _glesNormal.z)));
					  worldNormal_5 = tmpvar_24;
					  highp mat3 tmpvar_25;
					  tmpvar_25[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_25[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_25[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_26;
					  tmpvar_26 = normalize((tmpvar_25 * _glesTANGENT.xyz));
					  worldTangent_4 = tmpvar_26;
					  highp float tmpvar_27;
					  tmpvar_27 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_3 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = (((worldNormal_5.yzx * worldTangent_4.zxy) - (worldNormal_5.zxy * worldTangent_4.yzx)) * tangentSign_3);
					  lowp vec3 tmpvar_29;
					  tmpvar_29.x = worldTangent_4.x;
					  tmpvar_29.y = tmpvar_28.x;
					  tmpvar_29.z = worldNormal_5.x;
					  lowp vec3 tmpvar_30;
					  tmpvar_30.x = worldTangent_4.y;
					  tmpvar_30.y = tmpvar_28.y;
					  tmpvar_30.z = worldNormal_5.y;
					  lowp vec3 tmpvar_31;
					  tmpvar_31.x = worldTangent_4.z;
					  tmpvar_31.y = tmpvar_28.z;
					  tmpvar_31.z = worldNormal_5.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_20);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_29;
					  xlv_TEXCOORD2 = tmpvar_30;
					  xlv_TEXCOORD3 = tmpvar_31;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_6).xyz;
					  xlv_COLOR0 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					uniform sampler2D _GlossMap;
					uniform sampler2D _TranslucencyMap;
					uniform mediump float _Shininess;
					uniform lowp vec4 _Color;
					uniform lowp vec3 _TranslucencyColor;
					uniform lowp float _TranslucencyViewDependency;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
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
					  lowp float tmpvar_8;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpvar_8 = _Shininess;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = texture2D (_GlossMap, xlv_TEXCOORD0);
					  tmpvar_7 = tmpvar_10.w;
					  lowp vec3 tmpvar_11;
					  tmpvar_11 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
					  lowp float x_12;
					  x_12 = (tmpvar_9.w - _Cutoff);
					  if ((x_12 < 0.0)) {
					    discard;
					  };
					  worldN_1.x = dot (xlv_TEXCOORD1, tmpvar_11);
					  worldN_1.y = dot (xlv_TEXCOORD2, tmpvar_11);
					  worldN_1.z = dot (xlv_TEXCOORD3, tmpvar_11);
					  mediump vec4 tmpvar_13;
					  mediump vec3 lightDir_14;
					  lightDir_14 = lightDir_4;
					  mediump vec3 viewDir_15;
					  viewDir_15 = worldViewDir_3;
					  lowp vec4 c_16;
					  mediump float tmpvar_17;
					  tmpvar_17 = dot (worldN_1, lightDir_14);
					  mediump float tmpvar_18;
					  tmpvar_18 = (pow (max (0.0, 
					    dot (worldN_1, normalize((lightDir_14 + viewDir_15)))
					  ), (tmpvar_7 * 128.0)) * tmpvar_8);
					  lowp float tmpvar_19;
					  mediump float tmpvar_20;
					  tmpvar_20 = clamp (dot (viewDir_15, -(lightDir_14)), 0.0, 1.0);
					  tmpvar_19 = tmpvar_20;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp (-(tmpvar_17), 0.0, 1.0);
					  mediump float tmpvar_22;
					  tmpvar_22 = max (0.0, ((tmpvar_17 * 0.6) + 0.4));
					  c_16.xyz = (((tmpvar_9.xyz * _Color.xyz) * xlv_COLOR0.xyz) * ((
					    (mix (tmpvar_21, tmpvar_19, _TranslucencyViewDependency) * texture2D (_TranslucencyMap, xlv_TEXCOORD0).xyz)
					   * 
					    (_TranslucencyColor * 2.0)
					  ) + tmpvar_22));
					  c_16.xyz = ((c_16.xyz * _LightColor0.xyz) + tmpvar_18);
					  c_16.xyz = (c_16.xyz * _LightColor0.xyz);
					  tmpvar_13 = c_16;
					  c_2 = tmpvar_13;
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
					uniform highp vec4 _Time;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = _glesColor;
					  lowp float tangentSign_3;
					  lowp vec3 worldTangent_4;
					  lowp vec3 worldNormal_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = tmpvar_1.w;
					  highp float bendingFact_7;
					  highp vec4 wind_8;
					  lowp float tmpvar_9;
					  tmpvar_9 = tmpvar_2.w;
					  bendingFact_7 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_WorldToObject[0].xyz;
					  tmpvar_10[1] = unity_WorldToObject[1].xyz;
					  tmpvar_10[2] = unity_WorldToObject[2].xyz;
					  wind_8.xyz = (tmpvar_10 * _Wind.xyz);
					  wind_8.w = (_Wind.w * bendingFact_7);
					  highp vec2 tmpvar_11;
					  tmpvar_11.y = 1.0;
					  tmpvar_11.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_12;
					  pos_12.w = tmpvar_1.w;
					  highp vec3 bend_13;
					  highp vec4 v_14;
					  v_14.x = unity_ObjectToWorld[0].w;
					  v_14.y = unity_ObjectToWorld[1].w;
					  v_14.z = unity_ObjectToWorld[2].w;
					  v_14.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_15;
					  tmpvar_15 = dot (v_14.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_15)));
					  tmpvar_16.y = tmpvar_15;
					  highp vec4 tmpvar_17;
					  tmpvar_17 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_11).xx + tmpvar_16).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_18;
					  tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
					  highp vec2 tmpvar_19;
					  tmpvar_19 = (tmpvar_18.xz + tmpvar_18.yw);
					  bend_13.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_13.y = (bendingFact_7 * 0.3);
					  pos_12.xyz = (_glesVertex.xyz + ((
					    (tmpvar_19.xyx * bend_13)
					   + 
					    ((wind_8.xyz * tmpvar_19.y) * bendingFact_7)
					  ) * wind_8.w));
					  pos_12.xyz = (pos_12.xyz + (bendingFact_7 * wind_8.xyz));
					  tmpvar_6.xyz = pos_12.xyz;
					  highp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = tmpvar_6.xyz;
					  highp vec4 v_21;
					  v_21.x = unity_WorldToObject[0].x;
					  v_21.y = unity_WorldToObject[1].x;
					  v_21.z = unity_WorldToObject[2].x;
					  v_21.w = unity_WorldToObject[3].x;
					  highp vec4 v_22;
					  v_22.x = unity_WorldToObject[0].y;
					  v_22.y = unity_WorldToObject[1].y;
					  v_22.z = unity_WorldToObject[2].y;
					  v_22.w = unity_WorldToObject[3].y;
					  highp vec4 v_23;
					  v_23.x = unity_WorldToObject[0].z;
					  v_23.y = unity_WorldToObject[1].z;
					  v_23.z = unity_WorldToObject[2].z;
					  v_23.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_24;
					  tmpvar_24 = normalize(((
					    (v_21.xyz * _glesNormal.x)
					   + 
					    (v_22.xyz * _glesNormal.y)
					  ) + (v_23.xyz * _glesNormal.z)));
					  worldNormal_5 = tmpvar_24;
					  highp mat3 tmpvar_25;
					  tmpvar_25[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_25[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_25[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_26;
					  tmpvar_26 = normalize((tmpvar_25 * _glesTANGENT.xyz));
					  worldTangent_4 = tmpvar_26;
					  highp float tmpvar_27;
					  tmpvar_27 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_3 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = (((worldNormal_5.yzx * worldTangent_4.zxy) - (worldNormal_5.zxy * worldTangent_4.yzx)) * tangentSign_3);
					  lowp vec3 tmpvar_29;
					  tmpvar_29.x = worldTangent_4.x;
					  tmpvar_29.y = tmpvar_28.x;
					  tmpvar_29.z = worldNormal_5.x;
					  lowp vec3 tmpvar_30;
					  tmpvar_30.x = worldTangent_4.y;
					  tmpvar_30.y = tmpvar_28.y;
					  tmpvar_30.z = worldNormal_5.y;
					  lowp vec3 tmpvar_31;
					  tmpvar_31.x = worldTangent_4.z;
					  tmpvar_31.y = tmpvar_28.z;
					  tmpvar_31.z = worldNormal_5.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_20);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_29;
					  xlv_TEXCOORD2 = tmpvar_30;
					  xlv_TEXCOORD3 = tmpvar_31;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_6).xyz;
					  xlv_COLOR0 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					uniform sampler2D _GlossMap;
					uniform sampler2D _TranslucencyMap;
					uniform mediump float _Shininess;
					uniform lowp vec4 _Color;
					uniform lowp vec3 _TranslucencyColor;
					uniform lowp float _TranslucencyViewDependency;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
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
					  lowp float tmpvar_8;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpvar_8 = _Shininess;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = texture2D (_GlossMap, xlv_TEXCOORD0);
					  tmpvar_7 = tmpvar_10.w;
					  lowp vec3 tmpvar_11;
					  tmpvar_11 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
					  lowp float x_12;
					  x_12 = (tmpvar_9.w - _Cutoff);
					  if ((x_12 < 0.0)) {
					    discard;
					  };
					  worldN_1.x = dot (xlv_TEXCOORD1, tmpvar_11);
					  worldN_1.y = dot (xlv_TEXCOORD2, tmpvar_11);
					  worldN_1.z = dot (xlv_TEXCOORD3, tmpvar_11);
					  mediump vec4 tmpvar_13;
					  mediump vec3 lightDir_14;
					  lightDir_14 = lightDir_4;
					  mediump vec3 viewDir_15;
					  viewDir_15 = worldViewDir_3;
					  lowp vec4 c_16;
					  mediump float tmpvar_17;
					  tmpvar_17 = dot (worldN_1, lightDir_14);
					  mediump float tmpvar_18;
					  tmpvar_18 = (pow (max (0.0, 
					    dot (worldN_1, normalize((lightDir_14 + viewDir_15)))
					  ), (tmpvar_7 * 128.0)) * tmpvar_8);
					  lowp float tmpvar_19;
					  mediump float tmpvar_20;
					  tmpvar_20 = clamp (dot (viewDir_15, -(lightDir_14)), 0.0, 1.0);
					  tmpvar_19 = tmpvar_20;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp (-(tmpvar_17), 0.0, 1.0);
					  mediump float tmpvar_22;
					  tmpvar_22 = max (0.0, ((tmpvar_17 * 0.6) + 0.4));
					  c_16.xyz = (((tmpvar_9.xyz * _Color.xyz) * xlv_COLOR0.xyz) * ((
					    (mix (tmpvar_21, tmpvar_19, _TranslucencyViewDependency) * texture2D (_TranslucencyMap, xlv_TEXCOORD0).xyz)
					   * 
					    (_TranslucencyColor * 2.0)
					  ) + tmpvar_22));
					  c_16.xyz = ((c_16.xyz * _LightColor0.xyz) + tmpvar_18);
					  c_16.xyz = (c_16.xyz * _LightColor0.xyz);
					  tmpvar_13 = c_16;
					  c_2 = tmpvar_13;
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
					uniform highp vec4 _Time;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = _glesColor;
					  lowp float tangentSign_3;
					  lowp vec3 worldTangent_4;
					  lowp vec3 worldNormal_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = tmpvar_1.w;
					  highp float bendingFact_7;
					  highp vec4 wind_8;
					  lowp float tmpvar_9;
					  tmpvar_9 = tmpvar_2.w;
					  bendingFact_7 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_WorldToObject[0].xyz;
					  tmpvar_10[1] = unity_WorldToObject[1].xyz;
					  tmpvar_10[2] = unity_WorldToObject[2].xyz;
					  wind_8.xyz = (tmpvar_10 * _Wind.xyz);
					  wind_8.w = (_Wind.w * bendingFact_7);
					  highp vec2 tmpvar_11;
					  tmpvar_11.y = 1.0;
					  tmpvar_11.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_12;
					  pos_12.w = tmpvar_1.w;
					  highp vec3 bend_13;
					  highp vec4 v_14;
					  v_14.x = unity_ObjectToWorld[0].w;
					  v_14.y = unity_ObjectToWorld[1].w;
					  v_14.z = unity_ObjectToWorld[2].w;
					  v_14.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_15;
					  tmpvar_15 = dot (v_14.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_15)));
					  tmpvar_16.y = tmpvar_15;
					  highp vec4 tmpvar_17;
					  tmpvar_17 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_11).xx + tmpvar_16).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_18;
					  tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
					  highp vec2 tmpvar_19;
					  tmpvar_19 = (tmpvar_18.xz + tmpvar_18.yw);
					  bend_13.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_13.y = (bendingFact_7 * 0.3);
					  pos_12.xyz = (_glesVertex.xyz + ((
					    (tmpvar_19.xyx * bend_13)
					   + 
					    ((wind_8.xyz * tmpvar_19.y) * bendingFact_7)
					  ) * wind_8.w));
					  pos_12.xyz = (pos_12.xyz + (bendingFact_7 * wind_8.xyz));
					  tmpvar_6.xyz = pos_12.xyz;
					  highp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = tmpvar_6.xyz;
					  highp vec4 v_21;
					  v_21.x = unity_WorldToObject[0].x;
					  v_21.y = unity_WorldToObject[1].x;
					  v_21.z = unity_WorldToObject[2].x;
					  v_21.w = unity_WorldToObject[3].x;
					  highp vec4 v_22;
					  v_22.x = unity_WorldToObject[0].y;
					  v_22.y = unity_WorldToObject[1].y;
					  v_22.z = unity_WorldToObject[2].y;
					  v_22.w = unity_WorldToObject[3].y;
					  highp vec4 v_23;
					  v_23.x = unity_WorldToObject[0].z;
					  v_23.y = unity_WorldToObject[1].z;
					  v_23.z = unity_WorldToObject[2].z;
					  v_23.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_24;
					  tmpvar_24 = normalize(((
					    (v_21.xyz * _glesNormal.x)
					   + 
					    (v_22.xyz * _glesNormal.y)
					  ) + (v_23.xyz * _glesNormal.z)));
					  worldNormal_5 = tmpvar_24;
					  highp mat3 tmpvar_25;
					  tmpvar_25[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_25[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_25[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_26;
					  tmpvar_26 = normalize((tmpvar_25 * _glesTANGENT.xyz));
					  worldTangent_4 = tmpvar_26;
					  highp float tmpvar_27;
					  tmpvar_27 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_3 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = (((worldNormal_5.yzx * worldTangent_4.zxy) - (worldNormal_5.zxy * worldTangent_4.yzx)) * tangentSign_3);
					  lowp vec3 tmpvar_29;
					  tmpvar_29.x = worldTangent_4.x;
					  tmpvar_29.y = tmpvar_28.x;
					  tmpvar_29.z = worldNormal_5.x;
					  lowp vec3 tmpvar_30;
					  tmpvar_30.x = worldTangent_4.y;
					  tmpvar_30.y = tmpvar_28.y;
					  tmpvar_30.z = worldNormal_5.y;
					  lowp vec3 tmpvar_31;
					  tmpvar_31.x = worldTangent_4.z;
					  tmpvar_31.y = tmpvar_28.z;
					  tmpvar_31.z = worldNormal_5.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_20);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_29;
					  xlv_TEXCOORD2 = tmpvar_30;
					  xlv_TEXCOORD3 = tmpvar_31;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_6).xyz;
					  xlv_COLOR0 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					uniform sampler2D _GlossMap;
					uniform sampler2D _TranslucencyMap;
					uniform mediump float _Shininess;
					uniform lowp vec4 _Color;
					uniform lowp vec3 _TranslucencyColor;
					uniform lowp float _TranslucencyViewDependency;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
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
					  lowp float tmpvar_8;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpvar_8 = _Shininess;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = texture2D (_GlossMap, xlv_TEXCOORD0);
					  tmpvar_7 = tmpvar_10.w;
					  lowp vec3 tmpvar_11;
					  tmpvar_11 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
					  lowp float x_12;
					  x_12 = (tmpvar_9.w - _Cutoff);
					  if ((x_12 < 0.0)) {
					    discard;
					  };
					  worldN_1.x = dot (xlv_TEXCOORD1, tmpvar_11);
					  worldN_1.y = dot (xlv_TEXCOORD2, tmpvar_11);
					  worldN_1.z = dot (xlv_TEXCOORD3, tmpvar_11);
					  mediump vec4 tmpvar_13;
					  mediump vec3 lightDir_14;
					  lightDir_14 = lightDir_4;
					  mediump vec3 viewDir_15;
					  viewDir_15 = worldViewDir_3;
					  lowp vec4 c_16;
					  mediump float tmpvar_17;
					  tmpvar_17 = dot (worldN_1, lightDir_14);
					  mediump float tmpvar_18;
					  tmpvar_18 = (pow (max (0.0, 
					    dot (worldN_1, normalize((lightDir_14 + viewDir_15)))
					  ), (tmpvar_7 * 128.0)) * tmpvar_8);
					  lowp float tmpvar_19;
					  mediump float tmpvar_20;
					  tmpvar_20 = clamp (dot (viewDir_15, -(lightDir_14)), 0.0, 1.0);
					  tmpvar_19 = tmpvar_20;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp (-(tmpvar_17), 0.0, 1.0);
					  mediump float tmpvar_22;
					  tmpvar_22 = max (0.0, ((tmpvar_17 * 0.6) + 0.4));
					  c_16.xyz = (((tmpvar_9.xyz * _Color.xyz) * xlv_COLOR0.xyz) * ((
					    (mix (tmpvar_21, tmpvar_19, _TranslucencyViewDependency) * texture2D (_TranslucencyMap, xlv_TEXCOORD0).xyz)
					   * 
					    (_TranslucencyColor * 2.0)
					  ) + tmpvar_22));
					  c_16.xyz = ((c_16.xyz * _LightColor0.xyz) + tmpvar_18);
					  c_16.xyz = (c_16.xyz * _LightColor0.xyz);
					  tmpvar_13 = c_16;
					  c_2 = tmpvar_13;
					  gl_FragData[0] = c_2;
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
					uniform highp vec4 _Time;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = _glesColor;
					  lowp float tangentSign_3;
					  lowp vec3 worldTangent_4;
					  lowp vec3 worldNormal_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = tmpvar_1.w;
					  highp float bendingFact_7;
					  highp vec4 wind_8;
					  lowp float tmpvar_9;
					  tmpvar_9 = tmpvar_2.w;
					  bendingFact_7 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_WorldToObject[0].xyz;
					  tmpvar_10[1] = unity_WorldToObject[1].xyz;
					  tmpvar_10[2] = unity_WorldToObject[2].xyz;
					  wind_8.xyz = (tmpvar_10 * _Wind.xyz);
					  wind_8.w = (_Wind.w * bendingFact_7);
					  highp vec2 tmpvar_11;
					  tmpvar_11.y = 1.0;
					  tmpvar_11.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_12;
					  pos_12.w = tmpvar_1.w;
					  highp vec3 bend_13;
					  highp vec4 v_14;
					  v_14.x = unity_ObjectToWorld[0].w;
					  v_14.y = unity_ObjectToWorld[1].w;
					  v_14.z = unity_ObjectToWorld[2].w;
					  v_14.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_15;
					  tmpvar_15 = dot (v_14.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_15)));
					  tmpvar_16.y = tmpvar_15;
					  highp vec4 tmpvar_17;
					  tmpvar_17 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_11).xx + tmpvar_16).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_18;
					  tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
					  highp vec2 tmpvar_19;
					  tmpvar_19 = (tmpvar_18.xz + tmpvar_18.yw);
					  bend_13.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_13.y = (bendingFact_7 * 0.3);
					  pos_12.xyz = (_glesVertex.xyz + ((
					    (tmpvar_19.xyx * bend_13)
					   + 
					    ((wind_8.xyz * tmpvar_19.y) * bendingFact_7)
					  ) * wind_8.w));
					  pos_12.xyz = (pos_12.xyz + (bendingFact_7 * wind_8.xyz));
					  tmpvar_6.xyz = pos_12.xyz;
					  highp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = tmpvar_6.xyz;
					  highp vec4 v_21;
					  v_21.x = unity_WorldToObject[0].x;
					  v_21.y = unity_WorldToObject[1].x;
					  v_21.z = unity_WorldToObject[2].x;
					  v_21.w = unity_WorldToObject[3].x;
					  highp vec4 v_22;
					  v_22.x = unity_WorldToObject[0].y;
					  v_22.y = unity_WorldToObject[1].y;
					  v_22.z = unity_WorldToObject[2].y;
					  v_22.w = unity_WorldToObject[3].y;
					  highp vec4 v_23;
					  v_23.x = unity_WorldToObject[0].z;
					  v_23.y = unity_WorldToObject[1].z;
					  v_23.z = unity_WorldToObject[2].z;
					  v_23.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_24;
					  tmpvar_24 = normalize(((
					    (v_21.xyz * _glesNormal.x)
					   + 
					    (v_22.xyz * _glesNormal.y)
					  ) + (v_23.xyz * _glesNormal.z)));
					  worldNormal_5 = tmpvar_24;
					  highp mat3 tmpvar_25;
					  tmpvar_25[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_25[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_25[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_26;
					  tmpvar_26 = normalize((tmpvar_25 * _glesTANGENT.xyz));
					  worldTangent_4 = tmpvar_26;
					  highp float tmpvar_27;
					  tmpvar_27 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_3 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = (((worldNormal_5.yzx * worldTangent_4.zxy) - (worldNormal_5.zxy * worldTangent_4.yzx)) * tangentSign_3);
					  lowp vec3 tmpvar_29;
					  tmpvar_29.x = worldTangent_4.x;
					  tmpvar_29.y = tmpvar_28.x;
					  tmpvar_29.z = worldNormal_5.x;
					  lowp vec3 tmpvar_30;
					  tmpvar_30.x = worldTangent_4.y;
					  tmpvar_30.y = tmpvar_28.y;
					  tmpvar_30.z = worldNormal_5.y;
					  lowp vec3 tmpvar_31;
					  tmpvar_31.x = worldTangent_4.z;
					  tmpvar_31.y = tmpvar_28.z;
					  tmpvar_31.z = worldNormal_5.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_20);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_29;
					  xlv_TEXCOORD2 = tmpvar_30;
					  xlv_TEXCOORD3 = tmpvar_31;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_6).xyz;
					  xlv_COLOR0 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					uniform sampler2D _GlossMap;
					uniform sampler2D _TranslucencyMap;
					uniform mediump float _Shininess;
					uniform lowp vec4 _Color;
					uniform lowp vec3 _TranslucencyColor;
					uniform lowp float _TranslucencyViewDependency;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
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
					  lowp float tmpvar_8;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpvar_8 = _Shininess;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = texture2D (_GlossMap, xlv_TEXCOORD0);
					  tmpvar_7 = tmpvar_10.w;
					  lowp vec3 tmpvar_11;
					  tmpvar_11 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
					  lowp float x_12;
					  x_12 = (tmpvar_9.w - _Cutoff);
					  if ((x_12 < 0.0)) {
					    discard;
					  };
					  worldN_1.x = dot (xlv_TEXCOORD1, tmpvar_11);
					  worldN_1.y = dot (xlv_TEXCOORD2, tmpvar_11);
					  worldN_1.z = dot (xlv_TEXCOORD3, tmpvar_11);
					  mediump vec4 tmpvar_13;
					  mediump vec3 lightDir_14;
					  lightDir_14 = lightDir_4;
					  mediump vec3 viewDir_15;
					  viewDir_15 = worldViewDir_3;
					  lowp vec4 c_16;
					  mediump float tmpvar_17;
					  tmpvar_17 = dot (worldN_1, lightDir_14);
					  mediump float tmpvar_18;
					  tmpvar_18 = (pow (max (0.0, 
					    dot (worldN_1, normalize((lightDir_14 + viewDir_15)))
					  ), (tmpvar_7 * 128.0)) * tmpvar_8);
					  lowp float tmpvar_19;
					  mediump float tmpvar_20;
					  tmpvar_20 = clamp (dot (viewDir_15, -(lightDir_14)), 0.0, 1.0);
					  tmpvar_19 = tmpvar_20;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp (-(tmpvar_17), 0.0, 1.0);
					  mediump float tmpvar_22;
					  tmpvar_22 = max (0.0, ((tmpvar_17 * 0.6) + 0.4));
					  c_16.xyz = (((tmpvar_9.xyz * _Color.xyz) * xlv_COLOR0.xyz) * ((
					    (mix (tmpvar_21, tmpvar_19, _TranslucencyViewDependency) * texture2D (_TranslucencyMap, xlv_TEXCOORD0).xyz)
					   * 
					    (_TranslucencyColor * 2.0)
					  ) + tmpvar_22));
					  c_16.xyz = ((c_16.xyz * _LightColor0.xyz) + tmpvar_18);
					  c_16.xyz = (c_16.xyz * _LightColor0.xyz);
					  tmpvar_13 = c_16;
					  c_2 = tmpvar_13;
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
					uniform highp vec4 _Time;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = _glesColor;
					  lowp float tangentSign_3;
					  lowp vec3 worldTangent_4;
					  lowp vec3 worldNormal_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = tmpvar_1.w;
					  highp float bendingFact_7;
					  highp vec4 wind_8;
					  lowp float tmpvar_9;
					  tmpvar_9 = tmpvar_2.w;
					  bendingFact_7 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_WorldToObject[0].xyz;
					  tmpvar_10[1] = unity_WorldToObject[1].xyz;
					  tmpvar_10[2] = unity_WorldToObject[2].xyz;
					  wind_8.xyz = (tmpvar_10 * _Wind.xyz);
					  wind_8.w = (_Wind.w * bendingFact_7);
					  highp vec2 tmpvar_11;
					  tmpvar_11.y = 1.0;
					  tmpvar_11.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_12;
					  pos_12.w = tmpvar_1.w;
					  highp vec3 bend_13;
					  highp vec4 v_14;
					  v_14.x = unity_ObjectToWorld[0].w;
					  v_14.y = unity_ObjectToWorld[1].w;
					  v_14.z = unity_ObjectToWorld[2].w;
					  v_14.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_15;
					  tmpvar_15 = dot (v_14.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_15)));
					  tmpvar_16.y = tmpvar_15;
					  highp vec4 tmpvar_17;
					  tmpvar_17 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_11).xx + tmpvar_16).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_18;
					  tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
					  highp vec2 tmpvar_19;
					  tmpvar_19 = (tmpvar_18.xz + tmpvar_18.yw);
					  bend_13.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_13.y = (bendingFact_7 * 0.3);
					  pos_12.xyz = (_glesVertex.xyz + ((
					    (tmpvar_19.xyx * bend_13)
					   + 
					    ((wind_8.xyz * tmpvar_19.y) * bendingFact_7)
					  ) * wind_8.w));
					  pos_12.xyz = (pos_12.xyz + (bendingFact_7 * wind_8.xyz));
					  tmpvar_6.xyz = pos_12.xyz;
					  highp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = tmpvar_6.xyz;
					  highp vec4 v_21;
					  v_21.x = unity_WorldToObject[0].x;
					  v_21.y = unity_WorldToObject[1].x;
					  v_21.z = unity_WorldToObject[2].x;
					  v_21.w = unity_WorldToObject[3].x;
					  highp vec4 v_22;
					  v_22.x = unity_WorldToObject[0].y;
					  v_22.y = unity_WorldToObject[1].y;
					  v_22.z = unity_WorldToObject[2].y;
					  v_22.w = unity_WorldToObject[3].y;
					  highp vec4 v_23;
					  v_23.x = unity_WorldToObject[0].z;
					  v_23.y = unity_WorldToObject[1].z;
					  v_23.z = unity_WorldToObject[2].z;
					  v_23.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_24;
					  tmpvar_24 = normalize(((
					    (v_21.xyz * _glesNormal.x)
					   + 
					    (v_22.xyz * _glesNormal.y)
					  ) + (v_23.xyz * _glesNormal.z)));
					  worldNormal_5 = tmpvar_24;
					  highp mat3 tmpvar_25;
					  tmpvar_25[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_25[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_25[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_26;
					  tmpvar_26 = normalize((tmpvar_25 * _glesTANGENT.xyz));
					  worldTangent_4 = tmpvar_26;
					  highp float tmpvar_27;
					  tmpvar_27 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_3 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = (((worldNormal_5.yzx * worldTangent_4.zxy) - (worldNormal_5.zxy * worldTangent_4.yzx)) * tangentSign_3);
					  lowp vec3 tmpvar_29;
					  tmpvar_29.x = worldTangent_4.x;
					  tmpvar_29.y = tmpvar_28.x;
					  tmpvar_29.z = worldNormal_5.x;
					  lowp vec3 tmpvar_30;
					  tmpvar_30.x = worldTangent_4.y;
					  tmpvar_30.y = tmpvar_28.y;
					  tmpvar_30.z = worldNormal_5.y;
					  lowp vec3 tmpvar_31;
					  tmpvar_31.x = worldTangent_4.z;
					  tmpvar_31.y = tmpvar_28.z;
					  tmpvar_31.z = worldNormal_5.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_20);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_29;
					  xlv_TEXCOORD2 = tmpvar_30;
					  xlv_TEXCOORD3 = tmpvar_31;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_6).xyz;
					  xlv_COLOR0 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					uniform sampler2D _GlossMap;
					uniform sampler2D _TranslucencyMap;
					uniform mediump float _Shininess;
					uniform lowp vec4 _Color;
					uniform lowp vec3 _TranslucencyColor;
					uniform lowp float _TranslucencyViewDependency;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
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
					  lowp float tmpvar_8;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpvar_8 = _Shininess;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = texture2D (_GlossMap, xlv_TEXCOORD0);
					  tmpvar_7 = tmpvar_10.w;
					  lowp vec3 tmpvar_11;
					  tmpvar_11 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
					  lowp float x_12;
					  x_12 = (tmpvar_9.w - _Cutoff);
					  if ((x_12 < 0.0)) {
					    discard;
					  };
					  worldN_1.x = dot (xlv_TEXCOORD1, tmpvar_11);
					  worldN_1.y = dot (xlv_TEXCOORD2, tmpvar_11);
					  worldN_1.z = dot (xlv_TEXCOORD3, tmpvar_11);
					  mediump vec4 tmpvar_13;
					  mediump vec3 lightDir_14;
					  lightDir_14 = lightDir_4;
					  mediump vec3 viewDir_15;
					  viewDir_15 = worldViewDir_3;
					  lowp vec4 c_16;
					  mediump float tmpvar_17;
					  tmpvar_17 = dot (worldN_1, lightDir_14);
					  mediump float tmpvar_18;
					  tmpvar_18 = (pow (max (0.0, 
					    dot (worldN_1, normalize((lightDir_14 + viewDir_15)))
					  ), (tmpvar_7 * 128.0)) * tmpvar_8);
					  lowp float tmpvar_19;
					  mediump float tmpvar_20;
					  tmpvar_20 = clamp (dot (viewDir_15, -(lightDir_14)), 0.0, 1.0);
					  tmpvar_19 = tmpvar_20;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp (-(tmpvar_17), 0.0, 1.0);
					  mediump float tmpvar_22;
					  tmpvar_22 = max (0.0, ((tmpvar_17 * 0.6) + 0.4));
					  c_16.xyz = (((tmpvar_9.xyz * _Color.xyz) * xlv_COLOR0.xyz) * ((
					    (mix (tmpvar_21, tmpvar_19, _TranslucencyViewDependency) * texture2D (_TranslucencyMap, xlv_TEXCOORD0).xyz)
					   * 
					    (_TranslucencyColor * 2.0)
					  ) + tmpvar_22));
					  c_16.xyz = ((c_16.xyz * _LightColor0.xyz) + tmpvar_18);
					  c_16.xyz = (c_16.xyz * _LightColor0.xyz);
					  tmpvar_13 = c_16;
					  c_2 = tmpvar_13;
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
					uniform highp vec4 _Time;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = _glesColor;
					  lowp float tangentSign_3;
					  lowp vec3 worldTangent_4;
					  lowp vec3 worldNormal_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = tmpvar_1.w;
					  highp float bendingFact_7;
					  highp vec4 wind_8;
					  lowp float tmpvar_9;
					  tmpvar_9 = tmpvar_2.w;
					  bendingFact_7 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_WorldToObject[0].xyz;
					  tmpvar_10[1] = unity_WorldToObject[1].xyz;
					  tmpvar_10[2] = unity_WorldToObject[2].xyz;
					  wind_8.xyz = (tmpvar_10 * _Wind.xyz);
					  wind_8.w = (_Wind.w * bendingFact_7);
					  highp vec2 tmpvar_11;
					  tmpvar_11.y = 1.0;
					  tmpvar_11.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_12;
					  pos_12.w = tmpvar_1.w;
					  highp vec3 bend_13;
					  highp vec4 v_14;
					  v_14.x = unity_ObjectToWorld[0].w;
					  v_14.y = unity_ObjectToWorld[1].w;
					  v_14.z = unity_ObjectToWorld[2].w;
					  v_14.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_15;
					  tmpvar_15 = dot (v_14.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_15)));
					  tmpvar_16.y = tmpvar_15;
					  highp vec4 tmpvar_17;
					  tmpvar_17 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_11).xx + tmpvar_16).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_18;
					  tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
					  highp vec2 tmpvar_19;
					  tmpvar_19 = (tmpvar_18.xz + tmpvar_18.yw);
					  bend_13.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_13.y = (bendingFact_7 * 0.3);
					  pos_12.xyz = (_glesVertex.xyz + ((
					    (tmpvar_19.xyx * bend_13)
					   + 
					    ((wind_8.xyz * tmpvar_19.y) * bendingFact_7)
					  ) * wind_8.w));
					  pos_12.xyz = (pos_12.xyz + (bendingFact_7 * wind_8.xyz));
					  tmpvar_6.xyz = pos_12.xyz;
					  highp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = tmpvar_6.xyz;
					  highp vec4 v_21;
					  v_21.x = unity_WorldToObject[0].x;
					  v_21.y = unity_WorldToObject[1].x;
					  v_21.z = unity_WorldToObject[2].x;
					  v_21.w = unity_WorldToObject[3].x;
					  highp vec4 v_22;
					  v_22.x = unity_WorldToObject[0].y;
					  v_22.y = unity_WorldToObject[1].y;
					  v_22.z = unity_WorldToObject[2].y;
					  v_22.w = unity_WorldToObject[3].y;
					  highp vec4 v_23;
					  v_23.x = unity_WorldToObject[0].z;
					  v_23.y = unity_WorldToObject[1].z;
					  v_23.z = unity_WorldToObject[2].z;
					  v_23.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_24;
					  tmpvar_24 = normalize(((
					    (v_21.xyz * _glesNormal.x)
					   + 
					    (v_22.xyz * _glesNormal.y)
					  ) + (v_23.xyz * _glesNormal.z)));
					  worldNormal_5 = tmpvar_24;
					  highp mat3 tmpvar_25;
					  tmpvar_25[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_25[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_25[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_26;
					  tmpvar_26 = normalize((tmpvar_25 * _glesTANGENT.xyz));
					  worldTangent_4 = tmpvar_26;
					  highp float tmpvar_27;
					  tmpvar_27 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_3 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = (((worldNormal_5.yzx * worldTangent_4.zxy) - (worldNormal_5.zxy * worldTangent_4.yzx)) * tangentSign_3);
					  lowp vec3 tmpvar_29;
					  tmpvar_29.x = worldTangent_4.x;
					  tmpvar_29.y = tmpvar_28.x;
					  tmpvar_29.z = worldNormal_5.x;
					  lowp vec3 tmpvar_30;
					  tmpvar_30.x = worldTangent_4.y;
					  tmpvar_30.y = tmpvar_28.y;
					  tmpvar_30.z = worldNormal_5.y;
					  lowp vec3 tmpvar_31;
					  tmpvar_31.x = worldTangent_4.z;
					  tmpvar_31.y = tmpvar_28.z;
					  tmpvar_31.z = worldNormal_5.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_20);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_29;
					  xlv_TEXCOORD2 = tmpvar_30;
					  xlv_TEXCOORD3 = tmpvar_31;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_6).xyz;
					  xlv_COLOR0 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					uniform sampler2D _GlossMap;
					uniform sampler2D _TranslucencyMap;
					uniform mediump float _Shininess;
					uniform lowp vec4 _Color;
					uniform lowp vec3 _TranslucencyColor;
					uniform lowp float _TranslucencyViewDependency;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
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
					  lowp float tmpvar_8;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpvar_8 = _Shininess;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = texture2D (_GlossMap, xlv_TEXCOORD0);
					  tmpvar_7 = tmpvar_10.w;
					  lowp vec3 tmpvar_11;
					  tmpvar_11 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
					  lowp float x_12;
					  x_12 = (tmpvar_9.w - _Cutoff);
					  if ((x_12 < 0.0)) {
					    discard;
					  };
					  worldN_1.x = dot (xlv_TEXCOORD1, tmpvar_11);
					  worldN_1.y = dot (xlv_TEXCOORD2, tmpvar_11);
					  worldN_1.z = dot (xlv_TEXCOORD3, tmpvar_11);
					  mediump vec4 tmpvar_13;
					  mediump vec3 lightDir_14;
					  lightDir_14 = lightDir_4;
					  mediump vec3 viewDir_15;
					  viewDir_15 = worldViewDir_3;
					  lowp vec4 c_16;
					  mediump float tmpvar_17;
					  tmpvar_17 = dot (worldN_1, lightDir_14);
					  mediump float tmpvar_18;
					  tmpvar_18 = (pow (max (0.0, 
					    dot (worldN_1, normalize((lightDir_14 + viewDir_15)))
					  ), (tmpvar_7 * 128.0)) * tmpvar_8);
					  lowp float tmpvar_19;
					  mediump float tmpvar_20;
					  tmpvar_20 = clamp (dot (viewDir_15, -(lightDir_14)), 0.0, 1.0);
					  tmpvar_19 = tmpvar_20;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp (-(tmpvar_17), 0.0, 1.0);
					  mediump float tmpvar_22;
					  tmpvar_22 = max (0.0, ((tmpvar_17 * 0.6) + 0.4));
					  c_16.xyz = (((tmpvar_9.xyz * _Color.xyz) * xlv_COLOR0.xyz) * ((
					    (mix (tmpvar_21, tmpvar_19, _TranslucencyViewDependency) * texture2D (_TranslucencyMap, xlv_TEXCOORD0).xyz)
					   * 
					    (_TranslucencyColor * 2.0)
					  ) + tmpvar_22));
					  c_16.xyz = ((c_16.xyz * _LightColor0.xyz) + tmpvar_18);
					  c_16.xyz = (c_16.xyz * _LightColor0.xyz);
					  tmpvar_13 = c_16;
					  c_2 = tmpvar_13;
					  gl_FragData[0] = c_2;
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
					uniform highp vec4 _Time;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = _glesColor;
					  lowp float tangentSign_3;
					  lowp vec3 worldTangent_4;
					  lowp vec3 worldNormal_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = tmpvar_1.w;
					  highp float bendingFact_7;
					  highp vec4 wind_8;
					  lowp float tmpvar_9;
					  tmpvar_9 = tmpvar_2.w;
					  bendingFact_7 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_WorldToObject[0].xyz;
					  tmpvar_10[1] = unity_WorldToObject[1].xyz;
					  tmpvar_10[2] = unity_WorldToObject[2].xyz;
					  wind_8.xyz = (tmpvar_10 * _Wind.xyz);
					  wind_8.w = (_Wind.w * bendingFact_7);
					  highp vec2 tmpvar_11;
					  tmpvar_11.y = 1.0;
					  tmpvar_11.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_12;
					  pos_12.w = tmpvar_1.w;
					  highp vec3 bend_13;
					  highp vec4 v_14;
					  v_14.x = unity_ObjectToWorld[0].w;
					  v_14.y = unity_ObjectToWorld[1].w;
					  v_14.z = unity_ObjectToWorld[2].w;
					  v_14.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_15;
					  tmpvar_15 = dot (v_14.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_15)));
					  tmpvar_16.y = tmpvar_15;
					  highp vec4 tmpvar_17;
					  tmpvar_17 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_11).xx + tmpvar_16).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_18;
					  tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
					  highp vec2 tmpvar_19;
					  tmpvar_19 = (tmpvar_18.xz + tmpvar_18.yw);
					  bend_13.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_13.y = (bendingFact_7 * 0.3);
					  pos_12.xyz = (_glesVertex.xyz + ((
					    (tmpvar_19.xyx * bend_13)
					   + 
					    ((wind_8.xyz * tmpvar_19.y) * bendingFact_7)
					  ) * wind_8.w));
					  pos_12.xyz = (pos_12.xyz + (bendingFact_7 * wind_8.xyz));
					  tmpvar_6.xyz = pos_12.xyz;
					  highp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = tmpvar_6.xyz;
					  highp vec4 v_21;
					  v_21.x = unity_WorldToObject[0].x;
					  v_21.y = unity_WorldToObject[1].x;
					  v_21.z = unity_WorldToObject[2].x;
					  v_21.w = unity_WorldToObject[3].x;
					  highp vec4 v_22;
					  v_22.x = unity_WorldToObject[0].y;
					  v_22.y = unity_WorldToObject[1].y;
					  v_22.z = unity_WorldToObject[2].y;
					  v_22.w = unity_WorldToObject[3].y;
					  highp vec4 v_23;
					  v_23.x = unity_WorldToObject[0].z;
					  v_23.y = unity_WorldToObject[1].z;
					  v_23.z = unity_WorldToObject[2].z;
					  v_23.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_24;
					  tmpvar_24 = normalize(((
					    (v_21.xyz * _glesNormal.x)
					   + 
					    (v_22.xyz * _glesNormal.y)
					  ) + (v_23.xyz * _glesNormal.z)));
					  worldNormal_5 = tmpvar_24;
					  highp mat3 tmpvar_25;
					  tmpvar_25[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_25[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_25[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_26;
					  tmpvar_26 = normalize((tmpvar_25 * _glesTANGENT.xyz));
					  worldTangent_4 = tmpvar_26;
					  highp float tmpvar_27;
					  tmpvar_27 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_3 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = (((worldNormal_5.yzx * worldTangent_4.zxy) - (worldNormal_5.zxy * worldTangent_4.yzx)) * tangentSign_3);
					  lowp vec3 tmpvar_29;
					  tmpvar_29.x = worldTangent_4.x;
					  tmpvar_29.y = tmpvar_28.x;
					  tmpvar_29.z = worldNormal_5.x;
					  lowp vec3 tmpvar_30;
					  tmpvar_30.x = worldTangent_4.y;
					  tmpvar_30.y = tmpvar_28.y;
					  tmpvar_30.z = worldNormal_5.y;
					  lowp vec3 tmpvar_31;
					  tmpvar_31.x = worldTangent_4.z;
					  tmpvar_31.y = tmpvar_28.z;
					  tmpvar_31.z = worldNormal_5.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_20);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_29;
					  xlv_TEXCOORD2 = tmpvar_30;
					  xlv_TEXCOORD3 = tmpvar_31;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_6).xyz;
					  xlv_COLOR0 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					uniform sampler2D _GlossMap;
					uniform sampler2D _TranslucencyMap;
					uniform mediump float _Shininess;
					uniform lowp vec4 _Color;
					uniform lowp vec3 _TranslucencyColor;
					uniform lowp float _TranslucencyViewDependency;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
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
					  lowp float tmpvar_8;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpvar_8 = _Shininess;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = texture2D (_GlossMap, xlv_TEXCOORD0);
					  tmpvar_7 = tmpvar_10.w;
					  lowp vec3 tmpvar_11;
					  tmpvar_11 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
					  lowp float x_12;
					  x_12 = (tmpvar_9.w - _Cutoff);
					  if ((x_12 < 0.0)) {
					    discard;
					  };
					  worldN_1.x = dot (xlv_TEXCOORD1, tmpvar_11);
					  worldN_1.y = dot (xlv_TEXCOORD2, tmpvar_11);
					  worldN_1.z = dot (xlv_TEXCOORD3, tmpvar_11);
					  mediump vec4 tmpvar_13;
					  mediump vec3 lightDir_14;
					  lightDir_14 = lightDir_4;
					  mediump vec3 viewDir_15;
					  viewDir_15 = worldViewDir_3;
					  lowp vec4 c_16;
					  mediump float tmpvar_17;
					  tmpvar_17 = dot (worldN_1, lightDir_14);
					  mediump float tmpvar_18;
					  tmpvar_18 = (pow (max (0.0, 
					    dot (worldN_1, normalize((lightDir_14 + viewDir_15)))
					  ), (tmpvar_7 * 128.0)) * tmpvar_8);
					  lowp float tmpvar_19;
					  mediump float tmpvar_20;
					  tmpvar_20 = clamp (dot (viewDir_15, -(lightDir_14)), 0.0, 1.0);
					  tmpvar_19 = tmpvar_20;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp (-(tmpvar_17), 0.0, 1.0);
					  mediump float tmpvar_22;
					  tmpvar_22 = max (0.0, ((tmpvar_17 * 0.6) + 0.4));
					  c_16.xyz = (((tmpvar_9.xyz * _Color.xyz) * xlv_COLOR0.xyz) * ((
					    (mix (tmpvar_21, tmpvar_19, _TranslucencyViewDependency) * texture2D (_TranslucencyMap, xlv_TEXCOORD0).xyz)
					   * 
					    (_TranslucencyColor * 2.0)
					  ) + tmpvar_22));
					  c_16.xyz = ((c_16.xyz * _LightColor0.xyz) + tmpvar_18);
					  c_16.xyz = (c_16.xyz * _LightColor0.xyz);
					  tmpvar_13 = c_16;
					  c_2 = tmpvar_13;
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
					uniform highp vec4 _Time;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = _glesColor;
					  lowp float tangentSign_3;
					  lowp vec3 worldTangent_4;
					  lowp vec3 worldNormal_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = tmpvar_1.w;
					  highp float bendingFact_7;
					  highp vec4 wind_8;
					  lowp float tmpvar_9;
					  tmpvar_9 = tmpvar_2.w;
					  bendingFact_7 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_WorldToObject[0].xyz;
					  tmpvar_10[1] = unity_WorldToObject[1].xyz;
					  tmpvar_10[2] = unity_WorldToObject[2].xyz;
					  wind_8.xyz = (tmpvar_10 * _Wind.xyz);
					  wind_8.w = (_Wind.w * bendingFact_7);
					  highp vec2 tmpvar_11;
					  tmpvar_11.y = 1.0;
					  tmpvar_11.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_12;
					  pos_12.w = tmpvar_1.w;
					  highp vec3 bend_13;
					  highp vec4 v_14;
					  v_14.x = unity_ObjectToWorld[0].w;
					  v_14.y = unity_ObjectToWorld[1].w;
					  v_14.z = unity_ObjectToWorld[2].w;
					  v_14.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_15;
					  tmpvar_15 = dot (v_14.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_15)));
					  tmpvar_16.y = tmpvar_15;
					  highp vec4 tmpvar_17;
					  tmpvar_17 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_11).xx + tmpvar_16).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_18;
					  tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
					  highp vec2 tmpvar_19;
					  tmpvar_19 = (tmpvar_18.xz + tmpvar_18.yw);
					  bend_13.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_13.y = (bendingFact_7 * 0.3);
					  pos_12.xyz = (_glesVertex.xyz + ((
					    (tmpvar_19.xyx * bend_13)
					   + 
					    ((wind_8.xyz * tmpvar_19.y) * bendingFact_7)
					  ) * wind_8.w));
					  pos_12.xyz = (pos_12.xyz + (bendingFact_7 * wind_8.xyz));
					  tmpvar_6.xyz = pos_12.xyz;
					  highp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = tmpvar_6.xyz;
					  highp vec4 v_21;
					  v_21.x = unity_WorldToObject[0].x;
					  v_21.y = unity_WorldToObject[1].x;
					  v_21.z = unity_WorldToObject[2].x;
					  v_21.w = unity_WorldToObject[3].x;
					  highp vec4 v_22;
					  v_22.x = unity_WorldToObject[0].y;
					  v_22.y = unity_WorldToObject[1].y;
					  v_22.z = unity_WorldToObject[2].y;
					  v_22.w = unity_WorldToObject[3].y;
					  highp vec4 v_23;
					  v_23.x = unity_WorldToObject[0].z;
					  v_23.y = unity_WorldToObject[1].z;
					  v_23.z = unity_WorldToObject[2].z;
					  v_23.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_24;
					  tmpvar_24 = normalize(((
					    (v_21.xyz * _glesNormal.x)
					   + 
					    (v_22.xyz * _glesNormal.y)
					  ) + (v_23.xyz * _glesNormal.z)));
					  worldNormal_5 = tmpvar_24;
					  highp mat3 tmpvar_25;
					  tmpvar_25[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_25[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_25[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_26;
					  tmpvar_26 = normalize((tmpvar_25 * _glesTANGENT.xyz));
					  worldTangent_4 = tmpvar_26;
					  highp float tmpvar_27;
					  tmpvar_27 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_3 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = (((worldNormal_5.yzx * worldTangent_4.zxy) - (worldNormal_5.zxy * worldTangent_4.yzx)) * tangentSign_3);
					  lowp vec3 tmpvar_29;
					  tmpvar_29.x = worldTangent_4.x;
					  tmpvar_29.y = tmpvar_28.x;
					  tmpvar_29.z = worldNormal_5.x;
					  lowp vec3 tmpvar_30;
					  tmpvar_30.x = worldTangent_4.y;
					  tmpvar_30.y = tmpvar_28.y;
					  tmpvar_30.z = worldNormal_5.y;
					  lowp vec3 tmpvar_31;
					  tmpvar_31.x = worldTangent_4.z;
					  tmpvar_31.y = tmpvar_28.z;
					  tmpvar_31.z = worldNormal_5.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_20);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_29;
					  xlv_TEXCOORD2 = tmpvar_30;
					  xlv_TEXCOORD3 = tmpvar_31;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_6).xyz;
					  xlv_COLOR0 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					uniform sampler2D _GlossMap;
					uniform sampler2D _TranslucencyMap;
					uniform mediump float _Shininess;
					uniform lowp vec4 _Color;
					uniform lowp vec3 _TranslucencyColor;
					uniform lowp float _TranslucencyViewDependency;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
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
					  lowp float tmpvar_8;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpvar_8 = _Shininess;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = texture2D (_GlossMap, xlv_TEXCOORD0);
					  tmpvar_7 = tmpvar_10.w;
					  lowp vec3 tmpvar_11;
					  tmpvar_11 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
					  lowp float x_12;
					  x_12 = (tmpvar_9.w - _Cutoff);
					  if ((x_12 < 0.0)) {
					    discard;
					  };
					  worldN_1.x = dot (xlv_TEXCOORD1, tmpvar_11);
					  worldN_1.y = dot (xlv_TEXCOORD2, tmpvar_11);
					  worldN_1.z = dot (xlv_TEXCOORD3, tmpvar_11);
					  mediump vec4 tmpvar_13;
					  mediump vec3 lightDir_14;
					  lightDir_14 = lightDir_4;
					  mediump vec3 viewDir_15;
					  viewDir_15 = worldViewDir_3;
					  lowp vec4 c_16;
					  mediump float tmpvar_17;
					  tmpvar_17 = dot (worldN_1, lightDir_14);
					  mediump float tmpvar_18;
					  tmpvar_18 = (pow (max (0.0, 
					    dot (worldN_1, normalize((lightDir_14 + viewDir_15)))
					  ), (tmpvar_7 * 128.0)) * tmpvar_8);
					  lowp float tmpvar_19;
					  mediump float tmpvar_20;
					  tmpvar_20 = clamp (dot (viewDir_15, -(lightDir_14)), 0.0, 1.0);
					  tmpvar_19 = tmpvar_20;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp (-(tmpvar_17), 0.0, 1.0);
					  mediump float tmpvar_22;
					  tmpvar_22 = max (0.0, ((tmpvar_17 * 0.6) + 0.4));
					  c_16.xyz = (((tmpvar_9.xyz * _Color.xyz) * xlv_COLOR0.xyz) * ((
					    (mix (tmpvar_21, tmpvar_19, _TranslucencyViewDependency) * texture2D (_TranslucencyMap, xlv_TEXCOORD0).xyz)
					   * 
					    (_TranslucencyColor * 2.0)
					  ) + tmpvar_22));
					  c_16.xyz = ((c_16.xyz * _LightColor0.xyz) + tmpvar_18);
					  c_16.xyz = (c_16.xyz * _LightColor0.xyz);
					  tmpvar_13 = c_16;
					  c_2 = tmpvar_13;
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
					uniform highp vec4 _Time;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = _glesColor;
					  lowp float tangentSign_3;
					  lowp vec3 worldTangent_4;
					  lowp vec3 worldNormal_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = tmpvar_1.w;
					  highp float bendingFact_7;
					  highp vec4 wind_8;
					  lowp float tmpvar_9;
					  tmpvar_9 = tmpvar_2.w;
					  bendingFact_7 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_WorldToObject[0].xyz;
					  tmpvar_10[1] = unity_WorldToObject[1].xyz;
					  tmpvar_10[2] = unity_WorldToObject[2].xyz;
					  wind_8.xyz = (tmpvar_10 * _Wind.xyz);
					  wind_8.w = (_Wind.w * bendingFact_7);
					  highp vec2 tmpvar_11;
					  tmpvar_11.y = 1.0;
					  tmpvar_11.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_12;
					  pos_12.w = tmpvar_1.w;
					  highp vec3 bend_13;
					  highp vec4 v_14;
					  v_14.x = unity_ObjectToWorld[0].w;
					  v_14.y = unity_ObjectToWorld[1].w;
					  v_14.z = unity_ObjectToWorld[2].w;
					  v_14.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_15;
					  tmpvar_15 = dot (v_14.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_15)));
					  tmpvar_16.y = tmpvar_15;
					  highp vec4 tmpvar_17;
					  tmpvar_17 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_11).xx + tmpvar_16).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_18;
					  tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
					  highp vec2 tmpvar_19;
					  tmpvar_19 = (tmpvar_18.xz + tmpvar_18.yw);
					  bend_13.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_13.y = (bendingFact_7 * 0.3);
					  pos_12.xyz = (_glesVertex.xyz + ((
					    (tmpvar_19.xyx * bend_13)
					   + 
					    ((wind_8.xyz * tmpvar_19.y) * bendingFact_7)
					  ) * wind_8.w));
					  pos_12.xyz = (pos_12.xyz + (bendingFact_7 * wind_8.xyz));
					  tmpvar_6.xyz = pos_12.xyz;
					  highp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = tmpvar_6.xyz;
					  highp vec4 v_21;
					  v_21.x = unity_WorldToObject[0].x;
					  v_21.y = unity_WorldToObject[1].x;
					  v_21.z = unity_WorldToObject[2].x;
					  v_21.w = unity_WorldToObject[3].x;
					  highp vec4 v_22;
					  v_22.x = unity_WorldToObject[0].y;
					  v_22.y = unity_WorldToObject[1].y;
					  v_22.z = unity_WorldToObject[2].y;
					  v_22.w = unity_WorldToObject[3].y;
					  highp vec4 v_23;
					  v_23.x = unity_WorldToObject[0].z;
					  v_23.y = unity_WorldToObject[1].z;
					  v_23.z = unity_WorldToObject[2].z;
					  v_23.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_24;
					  tmpvar_24 = normalize(((
					    (v_21.xyz * _glesNormal.x)
					   + 
					    (v_22.xyz * _glesNormal.y)
					  ) + (v_23.xyz * _glesNormal.z)));
					  worldNormal_5 = tmpvar_24;
					  highp mat3 tmpvar_25;
					  tmpvar_25[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_25[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_25[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_26;
					  tmpvar_26 = normalize((tmpvar_25 * _glesTANGENT.xyz));
					  worldTangent_4 = tmpvar_26;
					  highp float tmpvar_27;
					  tmpvar_27 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_3 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = (((worldNormal_5.yzx * worldTangent_4.zxy) - (worldNormal_5.zxy * worldTangent_4.yzx)) * tangentSign_3);
					  lowp vec3 tmpvar_29;
					  tmpvar_29.x = worldTangent_4.x;
					  tmpvar_29.y = tmpvar_28.x;
					  tmpvar_29.z = worldNormal_5.x;
					  lowp vec3 tmpvar_30;
					  tmpvar_30.x = worldTangent_4.y;
					  tmpvar_30.y = tmpvar_28.y;
					  tmpvar_30.z = worldNormal_5.y;
					  lowp vec3 tmpvar_31;
					  tmpvar_31.x = worldTangent_4.z;
					  tmpvar_31.y = tmpvar_28.z;
					  tmpvar_31.z = worldNormal_5.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_20);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_29;
					  xlv_TEXCOORD2 = tmpvar_30;
					  xlv_TEXCOORD3 = tmpvar_31;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_6).xyz;
					  xlv_COLOR0 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					uniform sampler2D _GlossMap;
					uniform sampler2D _TranslucencyMap;
					uniform mediump float _Shininess;
					uniform lowp vec4 _Color;
					uniform lowp vec3 _TranslucencyColor;
					uniform lowp float _TranslucencyViewDependency;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
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
					  lowp float tmpvar_8;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpvar_8 = _Shininess;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = texture2D (_GlossMap, xlv_TEXCOORD0);
					  tmpvar_7 = tmpvar_10.w;
					  lowp vec3 tmpvar_11;
					  tmpvar_11 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
					  lowp float x_12;
					  x_12 = (tmpvar_9.w - _Cutoff);
					  if ((x_12 < 0.0)) {
					    discard;
					  };
					  worldN_1.x = dot (xlv_TEXCOORD1, tmpvar_11);
					  worldN_1.y = dot (xlv_TEXCOORD2, tmpvar_11);
					  worldN_1.z = dot (xlv_TEXCOORD3, tmpvar_11);
					  mediump vec4 tmpvar_13;
					  mediump vec3 lightDir_14;
					  lightDir_14 = lightDir_4;
					  mediump vec3 viewDir_15;
					  viewDir_15 = worldViewDir_3;
					  lowp vec4 c_16;
					  mediump float tmpvar_17;
					  tmpvar_17 = dot (worldN_1, lightDir_14);
					  mediump float tmpvar_18;
					  tmpvar_18 = (pow (max (0.0, 
					    dot (worldN_1, normalize((lightDir_14 + viewDir_15)))
					  ), (tmpvar_7 * 128.0)) * tmpvar_8);
					  lowp float tmpvar_19;
					  mediump float tmpvar_20;
					  tmpvar_20 = clamp (dot (viewDir_15, -(lightDir_14)), 0.0, 1.0);
					  tmpvar_19 = tmpvar_20;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp (-(tmpvar_17), 0.0, 1.0);
					  mediump float tmpvar_22;
					  tmpvar_22 = max (0.0, ((tmpvar_17 * 0.6) + 0.4));
					  c_16.xyz = (((tmpvar_9.xyz * _Color.xyz) * xlv_COLOR0.xyz) * ((
					    (mix (tmpvar_21, tmpvar_19, _TranslucencyViewDependency) * texture2D (_TranslucencyMap, xlv_TEXCOORD0).xyz)
					   * 
					    (_TranslucencyColor * 2.0)
					  ) + tmpvar_22));
					  c_16.xyz = ((c_16.xyz * _LightColor0.xyz) + tmpvar_18);
					  c_16.xyz = (c_16.xyz * _LightColor0.xyz);
					  tmpvar_13 = c_16;
					  c_2 = tmpvar_13;
					  gl_FragData[0] = c_2;
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
					uniform highp vec4 _Time;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = _glesColor;
					  lowp float tangentSign_3;
					  lowp vec3 worldTangent_4;
					  lowp vec3 worldNormal_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = tmpvar_1.w;
					  highp float bendingFact_7;
					  highp vec4 wind_8;
					  lowp float tmpvar_9;
					  tmpvar_9 = tmpvar_2.w;
					  bendingFact_7 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_WorldToObject[0].xyz;
					  tmpvar_10[1] = unity_WorldToObject[1].xyz;
					  tmpvar_10[2] = unity_WorldToObject[2].xyz;
					  wind_8.xyz = (tmpvar_10 * _Wind.xyz);
					  wind_8.w = (_Wind.w * bendingFact_7);
					  highp vec2 tmpvar_11;
					  tmpvar_11.y = 1.0;
					  tmpvar_11.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_12;
					  pos_12.w = tmpvar_1.w;
					  highp vec3 bend_13;
					  highp vec4 v_14;
					  v_14.x = unity_ObjectToWorld[0].w;
					  v_14.y = unity_ObjectToWorld[1].w;
					  v_14.z = unity_ObjectToWorld[2].w;
					  v_14.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_15;
					  tmpvar_15 = dot (v_14.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_15)));
					  tmpvar_16.y = tmpvar_15;
					  highp vec4 tmpvar_17;
					  tmpvar_17 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_11).xx + tmpvar_16).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_18;
					  tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
					  highp vec2 tmpvar_19;
					  tmpvar_19 = (tmpvar_18.xz + tmpvar_18.yw);
					  bend_13.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_13.y = (bendingFact_7 * 0.3);
					  pos_12.xyz = (_glesVertex.xyz + ((
					    (tmpvar_19.xyx * bend_13)
					   + 
					    ((wind_8.xyz * tmpvar_19.y) * bendingFact_7)
					  ) * wind_8.w));
					  pos_12.xyz = (pos_12.xyz + (bendingFact_7 * wind_8.xyz));
					  tmpvar_6.xyz = pos_12.xyz;
					  highp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = tmpvar_6.xyz;
					  highp vec4 v_21;
					  v_21.x = unity_WorldToObject[0].x;
					  v_21.y = unity_WorldToObject[1].x;
					  v_21.z = unity_WorldToObject[2].x;
					  v_21.w = unity_WorldToObject[3].x;
					  highp vec4 v_22;
					  v_22.x = unity_WorldToObject[0].y;
					  v_22.y = unity_WorldToObject[1].y;
					  v_22.z = unity_WorldToObject[2].y;
					  v_22.w = unity_WorldToObject[3].y;
					  highp vec4 v_23;
					  v_23.x = unity_WorldToObject[0].z;
					  v_23.y = unity_WorldToObject[1].z;
					  v_23.z = unity_WorldToObject[2].z;
					  v_23.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_24;
					  tmpvar_24 = normalize(((
					    (v_21.xyz * _glesNormal.x)
					   + 
					    (v_22.xyz * _glesNormal.y)
					  ) + (v_23.xyz * _glesNormal.z)));
					  worldNormal_5 = tmpvar_24;
					  highp mat3 tmpvar_25;
					  tmpvar_25[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_25[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_25[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_26;
					  tmpvar_26 = normalize((tmpvar_25 * _glesTANGENT.xyz));
					  worldTangent_4 = tmpvar_26;
					  highp float tmpvar_27;
					  tmpvar_27 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_3 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = (((worldNormal_5.yzx * worldTangent_4.zxy) - (worldNormal_5.zxy * worldTangent_4.yzx)) * tangentSign_3);
					  lowp vec3 tmpvar_29;
					  tmpvar_29.x = worldTangent_4.x;
					  tmpvar_29.y = tmpvar_28.x;
					  tmpvar_29.z = worldNormal_5.x;
					  lowp vec3 tmpvar_30;
					  tmpvar_30.x = worldTangent_4.y;
					  tmpvar_30.y = tmpvar_28.y;
					  tmpvar_30.z = worldNormal_5.y;
					  lowp vec3 tmpvar_31;
					  tmpvar_31.x = worldTangent_4.z;
					  tmpvar_31.y = tmpvar_28.z;
					  tmpvar_31.z = worldNormal_5.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_20);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_29;
					  xlv_TEXCOORD2 = tmpvar_30;
					  xlv_TEXCOORD3 = tmpvar_31;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_6).xyz;
					  xlv_COLOR0 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					uniform sampler2D _GlossMap;
					uniform sampler2D _TranslucencyMap;
					uniform mediump float _Shininess;
					uniform lowp vec4 _Color;
					uniform lowp vec3 _TranslucencyColor;
					uniform lowp float _TranslucencyViewDependency;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
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
					  lowp float tmpvar_8;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpvar_8 = _Shininess;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = texture2D (_GlossMap, xlv_TEXCOORD0);
					  tmpvar_7 = tmpvar_10.w;
					  lowp vec3 tmpvar_11;
					  tmpvar_11 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
					  lowp float x_12;
					  x_12 = (tmpvar_9.w - _Cutoff);
					  if ((x_12 < 0.0)) {
					    discard;
					  };
					  worldN_1.x = dot (xlv_TEXCOORD1, tmpvar_11);
					  worldN_1.y = dot (xlv_TEXCOORD2, tmpvar_11);
					  worldN_1.z = dot (xlv_TEXCOORD3, tmpvar_11);
					  mediump vec4 tmpvar_13;
					  mediump vec3 lightDir_14;
					  lightDir_14 = lightDir_4;
					  mediump vec3 viewDir_15;
					  viewDir_15 = worldViewDir_3;
					  lowp vec4 c_16;
					  mediump float tmpvar_17;
					  tmpvar_17 = dot (worldN_1, lightDir_14);
					  mediump float tmpvar_18;
					  tmpvar_18 = (pow (max (0.0, 
					    dot (worldN_1, normalize((lightDir_14 + viewDir_15)))
					  ), (tmpvar_7 * 128.0)) * tmpvar_8);
					  lowp float tmpvar_19;
					  mediump float tmpvar_20;
					  tmpvar_20 = clamp (dot (viewDir_15, -(lightDir_14)), 0.0, 1.0);
					  tmpvar_19 = tmpvar_20;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp (-(tmpvar_17), 0.0, 1.0);
					  mediump float tmpvar_22;
					  tmpvar_22 = max (0.0, ((tmpvar_17 * 0.6) + 0.4));
					  c_16.xyz = (((tmpvar_9.xyz * _Color.xyz) * xlv_COLOR0.xyz) * ((
					    (mix (tmpvar_21, tmpvar_19, _TranslucencyViewDependency) * texture2D (_TranslucencyMap, xlv_TEXCOORD0).xyz)
					   * 
					    (_TranslucencyColor * 2.0)
					  ) + tmpvar_22));
					  c_16.xyz = ((c_16.xyz * _LightColor0.xyz) + tmpvar_18);
					  c_16.xyz = (c_16.xyz * _LightColor0.xyz);
					  tmpvar_13 = c_16;
					  c_2 = tmpvar_13;
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
					uniform highp vec4 _Time;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = _glesColor;
					  lowp float tangentSign_3;
					  lowp vec3 worldTangent_4;
					  lowp vec3 worldNormal_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = tmpvar_1.w;
					  highp float bendingFact_7;
					  highp vec4 wind_8;
					  lowp float tmpvar_9;
					  tmpvar_9 = tmpvar_2.w;
					  bendingFact_7 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_WorldToObject[0].xyz;
					  tmpvar_10[1] = unity_WorldToObject[1].xyz;
					  tmpvar_10[2] = unity_WorldToObject[2].xyz;
					  wind_8.xyz = (tmpvar_10 * _Wind.xyz);
					  wind_8.w = (_Wind.w * bendingFact_7);
					  highp vec2 tmpvar_11;
					  tmpvar_11.y = 1.0;
					  tmpvar_11.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_12;
					  pos_12.w = tmpvar_1.w;
					  highp vec3 bend_13;
					  highp vec4 v_14;
					  v_14.x = unity_ObjectToWorld[0].w;
					  v_14.y = unity_ObjectToWorld[1].w;
					  v_14.z = unity_ObjectToWorld[2].w;
					  v_14.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_15;
					  tmpvar_15 = dot (v_14.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_15)));
					  tmpvar_16.y = tmpvar_15;
					  highp vec4 tmpvar_17;
					  tmpvar_17 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_11).xx + tmpvar_16).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_18;
					  tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
					  highp vec2 tmpvar_19;
					  tmpvar_19 = (tmpvar_18.xz + tmpvar_18.yw);
					  bend_13.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_13.y = (bendingFact_7 * 0.3);
					  pos_12.xyz = (_glesVertex.xyz + ((
					    (tmpvar_19.xyx * bend_13)
					   + 
					    ((wind_8.xyz * tmpvar_19.y) * bendingFact_7)
					  ) * wind_8.w));
					  pos_12.xyz = (pos_12.xyz + (bendingFact_7 * wind_8.xyz));
					  tmpvar_6.xyz = pos_12.xyz;
					  highp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = tmpvar_6.xyz;
					  highp vec4 v_21;
					  v_21.x = unity_WorldToObject[0].x;
					  v_21.y = unity_WorldToObject[1].x;
					  v_21.z = unity_WorldToObject[2].x;
					  v_21.w = unity_WorldToObject[3].x;
					  highp vec4 v_22;
					  v_22.x = unity_WorldToObject[0].y;
					  v_22.y = unity_WorldToObject[1].y;
					  v_22.z = unity_WorldToObject[2].y;
					  v_22.w = unity_WorldToObject[3].y;
					  highp vec4 v_23;
					  v_23.x = unity_WorldToObject[0].z;
					  v_23.y = unity_WorldToObject[1].z;
					  v_23.z = unity_WorldToObject[2].z;
					  v_23.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_24;
					  tmpvar_24 = normalize(((
					    (v_21.xyz * _glesNormal.x)
					   + 
					    (v_22.xyz * _glesNormal.y)
					  ) + (v_23.xyz * _glesNormal.z)));
					  worldNormal_5 = tmpvar_24;
					  highp mat3 tmpvar_25;
					  tmpvar_25[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_25[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_25[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_26;
					  tmpvar_26 = normalize((tmpvar_25 * _glesTANGENT.xyz));
					  worldTangent_4 = tmpvar_26;
					  highp float tmpvar_27;
					  tmpvar_27 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_3 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = (((worldNormal_5.yzx * worldTangent_4.zxy) - (worldNormal_5.zxy * worldTangent_4.yzx)) * tangentSign_3);
					  lowp vec3 tmpvar_29;
					  tmpvar_29.x = worldTangent_4.x;
					  tmpvar_29.y = tmpvar_28.x;
					  tmpvar_29.z = worldNormal_5.x;
					  lowp vec3 tmpvar_30;
					  tmpvar_30.x = worldTangent_4.y;
					  tmpvar_30.y = tmpvar_28.y;
					  tmpvar_30.z = worldNormal_5.y;
					  lowp vec3 tmpvar_31;
					  tmpvar_31.x = worldTangent_4.z;
					  tmpvar_31.y = tmpvar_28.z;
					  tmpvar_31.z = worldNormal_5.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_20);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_29;
					  xlv_TEXCOORD2 = tmpvar_30;
					  xlv_TEXCOORD3 = tmpvar_31;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_6).xyz;
					  xlv_COLOR0 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					uniform sampler2D _GlossMap;
					uniform sampler2D _TranslucencyMap;
					uniform mediump float _Shininess;
					uniform lowp vec4 _Color;
					uniform lowp vec3 _TranslucencyColor;
					uniform lowp float _TranslucencyViewDependency;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
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
					  lowp float tmpvar_8;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpvar_8 = _Shininess;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = texture2D (_GlossMap, xlv_TEXCOORD0);
					  tmpvar_7 = tmpvar_10.w;
					  lowp vec3 tmpvar_11;
					  tmpvar_11 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
					  lowp float x_12;
					  x_12 = (tmpvar_9.w - _Cutoff);
					  if ((x_12 < 0.0)) {
					    discard;
					  };
					  worldN_1.x = dot (xlv_TEXCOORD1, tmpvar_11);
					  worldN_1.y = dot (xlv_TEXCOORD2, tmpvar_11);
					  worldN_1.z = dot (xlv_TEXCOORD3, tmpvar_11);
					  mediump vec4 tmpvar_13;
					  mediump vec3 lightDir_14;
					  lightDir_14 = lightDir_4;
					  mediump vec3 viewDir_15;
					  viewDir_15 = worldViewDir_3;
					  lowp vec4 c_16;
					  mediump float tmpvar_17;
					  tmpvar_17 = dot (worldN_1, lightDir_14);
					  mediump float tmpvar_18;
					  tmpvar_18 = (pow (max (0.0, 
					    dot (worldN_1, normalize((lightDir_14 + viewDir_15)))
					  ), (tmpvar_7 * 128.0)) * tmpvar_8);
					  lowp float tmpvar_19;
					  mediump float tmpvar_20;
					  tmpvar_20 = clamp (dot (viewDir_15, -(lightDir_14)), 0.0, 1.0);
					  tmpvar_19 = tmpvar_20;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp (-(tmpvar_17), 0.0, 1.0);
					  mediump float tmpvar_22;
					  tmpvar_22 = max (0.0, ((tmpvar_17 * 0.6) + 0.4));
					  c_16.xyz = (((tmpvar_9.xyz * _Color.xyz) * xlv_COLOR0.xyz) * ((
					    (mix (tmpvar_21, tmpvar_19, _TranslucencyViewDependency) * texture2D (_TranslucencyMap, xlv_TEXCOORD0).xyz)
					   * 
					    (_TranslucencyColor * 2.0)
					  ) + tmpvar_22));
					  c_16.xyz = ((c_16.xyz * _LightColor0.xyz) + tmpvar_18);
					  c_16.xyz = (c_16.xyz * _LightColor0.xyz);
					  tmpvar_13 = c_16;
					  c_2 = tmpvar_13;
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
					uniform highp vec4 _Time;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = _glesColor;
					  lowp float tangentSign_3;
					  lowp vec3 worldTangent_4;
					  lowp vec3 worldNormal_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = tmpvar_1.w;
					  highp float bendingFact_7;
					  highp vec4 wind_8;
					  lowp float tmpvar_9;
					  tmpvar_9 = tmpvar_2.w;
					  bendingFact_7 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_WorldToObject[0].xyz;
					  tmpvar_10[1] = unity_WorldToObject[1].xyz;
					  tmpvar_10[2] = unity_WorldToObject[2].xyz;
					  wind_8.xyz = (tmpvar_10 * _Wind.xyz);
					  wind_8.w = (_Wind.w * bendingFact_7);
					  highp vec2 tmpvar_11;
					  tmpvar_11.y = 1.0;
					  tmpvar_11.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_12;
					  pos_12.w = tmpvar_1.w;
					  highp vec3 bend_13;
					  highp vec4 v_14;
					  v_14.x = unity_ObjectToWorld[0].w;
					  v_14.y = unity_ObjectToWorld[1].w;
					  v_14.z = unity_ObjectToWorld[2].w;
					  v_14.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_15;
					  tmpvar_15 = dot (v_14.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_15)));
					  tmpvar_16.y = tmpvar_15;
					  highp vec4 tmpvar_17;
					  tmpvar_17 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_11).xx + tmpvar_16).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_18;
					  tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
					  highp vec2 tmpvar_19;
					  tmpvar_19 = (tmpvar_18.xz + tmpvar_18.yw);
					  bend_13.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_13.y = (bendingFact_7 * 0.3);
					  pos_12.xyz = (_glesVertex.xyz + ((
					    (tmpvar_19.xyx * bend_13)
					   + 
					    ((wind_8.xyz * tmpvar_19.y) * bendingFact_7)
					  ) * wind_8.w));
					  pos_12.xyz = (pos_12.xyz + (bendingFact_7 * wind_8.xyz));
					  tmpvar_6.xyz = pos_12.xyz;
					  highp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = tmpvar_6.xyz;
					  highp vec4 v_21;
					  v_21.x = unity_WorldToObject[0].x;
					  v_21.y = unity_WorldToObject[1].x;
					  v_21.z = unity_WorldToObject[2].x;
					  v_21.w = unity_WorldToObject[3].x;
					  highp vec4 v_22;
					  v_22.x = unity_WorldToObject[0].y;
					  v_22.y = unity_WorldToObject[1].y;
					  v_22.z = unity_WorldToObject[2].y;
					  v_22.w = unity_WorldToObject[3].y;
					  highp vec4 v_23;
					  v_23.x = unity_WorldToObject[0].z;
					  v_23.y = unity_WorldToObject[1].z;
					  v_23.z = unity_WorldToObject[2].z;
					  v_23.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_24;
					  tmpvar_24 = normalize(((
					    (v_21.xyz * _glesNormal.x)
					   + 
					    (v_22.xyz * _glesNormal.y)
					  ) + (v_23.xyz * _glesNormal.z)));
					  worldNormal_5 = tmpvar_24;
					  highp mat3 tmpvar_25;
					  tmpvar_25[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_25[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_25[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_26;
					  tmpvar_26 = normalize((tmpvar_25 * _glesTANGENT.xyz));
					  worldTangent_4 = tmpvar_26;
					  highp float tmpvar_27;
					  tmpvar_27 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_3 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = (((worldNormal_5.yzx * worldTangent_4.zxy) - (worldNormal_5.zxy * worldTangent_4.yzx)) * tangentSign_3);
					  lowp vec3 tmpvar_29;
					  tmpvar_29.x = worldTangent_4.x;
					  tmpvar_29.y = tmpvar_28.x;
					  tmpvar_29.z = worldNormal_5.x;
					  lowp vec3 tmpvar_30;
					  tmpvar_30.x = worldTangent_4.y;
					  tmpvar_30.y = tmpvar_28.y;
					  tmpvar_30.z = worldNormal_5.y;
					  lowp vec3 tmpvar_31;
					  tmpvar_31.x = worldTangent_4.z;
					  tmpvar_31.y = tmpvar_28.z;
					  tmpvar_31.z = worldNormal_5.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_20);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_29;
					  xlv_TEXCOORD2 = tmpvar_30;
					  xlv_TEXCOORD3 = tmpvar_31;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_6).xyz;
					  xlv_COLOR0 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					uniform sampler2D _GlossMap;
					uniform sampler2D _TranslucencyMap;
					uniform mediump float _Shininess;
					uniform lowp vec4 _Color;
					uniform lowp vec3 _TranslucencyColor;
					uniform lowp float _TranslucencyViewDependency;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
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
					  lowp float tmpvar_8;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpvar_8 = _Shininess;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = texture2D (_GlossMap, xlv_TEXCOORD0);
					  tmpvar_7 = tmpvar_10.w;
					  lowp vec3 tmpvar_11;
					  tmpvar_11 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
					  lowp float x_12;
					  x_12 = (tmpvar_9.w - _Cutoff);
					  if ((x_12 < 0.0)) {
					    discard;
					  };
					  worldN_1.x = dot (xlv_TEXCOORD1, tmpvar_11);
					  worldN_1.y = dot (xlv_TEXCOORD2, tmpvar_11);
					  worldN_1.z = dot (xlv_TEXCOORD3, tmpvar_11);
					  mediump vec4 tmpvar_13;
					  mediump vec3 lightDir_14;
					  lightDir_14 = lightDir_4;
					  mediump vec3 viewDir_15;
					  viewDir_15 = worldViewDir_3;
					  lowp vec4 c_16;
					  mediump float tmpvar_17;
					  tmpvar_17 = dot (worldN_1, lightDir_14);
					  mediump float tmpvar_18;
					  tmpvar_18 = (pow (max (0.0, 
					    dot (worldN_1, normalize((lightDir_14 + viewDir_15)))
					  ), (tmpvar_7 * 128.0)) * tmpvar_8);
					  lowp float tmpvar_19;
					  mediump float tmpvar_20;
					  tmpvar_20 = clamp (dot (viewDir_15, -(lightDir_14)), 0.0, 1.0);
					  tmpvar_19 = tmpvar_20;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp (-(tmpvar_17), 0.0, 1.0);
					  mediump float tmpvar_22;
					  tmpvar_22 = max (0.0, ((tmpvar_17 * 0.6) + 0.4));
					  c_16.xyz = (((tmpvar_9.xyz * _Color.xyz) * xlv_COLOR0.xyz) * ((
					    (mix (tmpvar_21, tmpvar_19, _TranslucencyViewDependency) * texture2D (_TranslucencyMap, xlv_TEXCOORD0).xyz)
					   * 
					    (_TranslucencyColor * 2.0)
					  ) + tmpvar_22));
					  c_16.xyz = ((c_16.xyz * _LightColor0.xyz) + tmpvar_18);
					  c_16.xyz = (c_16.xyz * _LightColor0.xyz);
					  tmpvar_13 = c_16;
					  c_2 = tmpvar_13;
					  gl_FragData[0] = c_2;
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
					uniform highp vec4 _Time;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = _glesColor;
					  lowp float tangentSign_3;
					  lowp vec3 worldTangent_4;
					  lowp vec3 worldNormal_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = tmpvar_1.w;
					  highp float bendingFact_7;
					  highp vec4 wind_8;
					  lowp float tmpvar_9;
					  tmpvar_9 = tmpvar_2.w;
					  bendingFact_7 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_WorldToObject[0].xyz;
					  tmpvar_10[1] = unity_WorldToObject[1].xyz;
					  tmpvar_10[2] = unity_WorldToObject[2].xyz;
					  wind_8.xyz = (tmpvar_10 * _Wind.xyz);
					  wind_8.w = (_Wind.w * bendingFact_7);
					  highp vec2 tmpvar_11;
					  tmpvar_11.y = 1.0;
					  tmpvar_11.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_12;
					  pos_12.w = tmpvar_1.w;
					  highp vec3 bend_13;
					  highp vec4 v_14;
					  v_14.x = unity_ObjectToWorld[0].w;
					  v_14.y = unity_ObjectToWorld[1].w;
					  v_14.z = unity_ObjectToWorld[2].w;
					  v_14.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_15;
					  tmpvar_15 = dot (v_14.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_15)));
					  tmpvar_16.y = tmpvar_15;
					  highp vec4 tmpvar_17;
					  tmpvar_17 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_11).xx + tmpvar_16).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_18;
					  tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
					  highp vec2 tmpvar_19;
					  tmpvar_19 = (tmpvar_18.xz + tmpvar_18.yw);
					  bend_13.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_13.y = (bendingFact_7 * 0.3);
					  pos_12.xyz = (_glesVertex.xyz + ((
					    (tmpvar_19.xyx * bend_13)
					   + 
					    ((wind_8.xyz * tmpvar_19.y) * bendingFact_7)
					  ) * wind_8.w));
					  pos_12.xyz = (pos_12.xyz + (bendingFact_7 * wind_8.xyz));
					  tmpvar_6.xyz = pos_12.xyz;
					  highp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = tmpvar_6.xyz;
					  highp vec4 v_21;
					  v_21.x = unity_WorldToObject[0].x;
					  v_21.y = unity_WorldToObject[1].x;
					  v_21.z = unity_WorldToObject[2].x;
					  v_21.w = unity_WorldToObject[3].x;
					  highp vec4 v_22;
					  v_22.x = unity_WorldToObject[0].y;
					  v_22.y = unity_WorldToObject[1].y;
					  v_22.z = unity_WorldToObject[2].y;
					  v_22.w = unity_WorldToObject[3].y;
					  highp vec4 v_23;
					  v_23.x = unity_WorldToObject[0].z;
					  v_23.y = unity_WorldToObject[1].z;
					  v_23.z = unity_WorldToObject[2].z;
					  v_23.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_24;
					  tmpvar_24 = normalize(((
					    (v_21.xyz * _glesNormal.x)
					   + 
					    (v_22.xyz * _glesNormal.y)
					  ) + (v_23.xyz * _glesNormal.z)));
					  worldNormal_5 = tmpvar_24;
					  highp mat3 tmpvar_25;
					  tmpvar_25[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_25[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_25[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_26;
					  tmpvar_26 = normalize((tmpvar_25 * _glesTANGENT.xyz));
					  worldTangent_4 = tmpvar_26;
					  highp float tmpvar_27;
					  tmpvar_27 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_3 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = (((worldNormal_5.yzx * worldTangent_4.zxy) - (worldNormal_5.zxy * worldTangent_4.yzx)) * tangentSign_3);
					  lowp vec3 tmpvar_29;
					  tmpvar_29.x = worldTangent_4.x;
					  tmpvar_29.y = tmpvar_28.x;
					  tmpvar_29.z = worldNormal_5.x;
					  lowp vec3 tmpvar_30;
					  tmpvar_30.x = worldTangent_4.y;
					  tmpvar_30.y = tmpvar_28.y;
					  tmpvar_30.z = worldNormal_5.y;
					  lowp vec3 tmpvar_31;
					  tmpvar_31.x = worldTangent_4.z;
					  tmpvar_31.y = tmpvar_28.z;
					  tmpvar_31.z = worldNormal_5.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_20);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_29;
					  xlv_TEXCOORD2 = tmpvar_30;
					  xlv_TEXCOORD3 = tmpvar_31;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_6).xyz;
					  xlv_COLOR0 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					uniform sampler2D _GlossMap;
					uniform sampler2D _TranslucencyMap;
					uniform mediump float _Shininess;
					uniform lowp vec4 _Color;
					uniform lowp vec3 _TranslucencyColor;
					uniform lowp float _TranslucencyViewDependency;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
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
					  lowp float tmpvar_8;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpvar_8 = _Shininess;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = texture2D (_GlossMap, xlv_TEXCOORD0);
					  tmpvar_7 = tmpvar_10.w;
					  lowp vec3 tmpvar_11;
					  tmpvar_11 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
					  lowp float x_12;
					  x_12 = (tmpvar_9.w - _Cutoff);
					  if ((x_12 < 0.0)) {
					    discard;
					  };
					  worldN_1.x = dot (xlv_TEXCOORD1, tmpvar_11);
					  worldN_1.y = dot (xlv_TEXCOORD2, tmpvar_11);
					  worldN_1.z = dot (xlv_TEXCOORD3, tmpvar_11);
					  mediump vec4 tmpvar_13;
					  mediump vec3 lightDir_14;
					  lightDir_14 = lightDir_4;
					  mediump vec3 viewDir_15;
					  viewDir_15 = worldViewDir_3;
					  lowp vec4 c_16;
					  mediump float tmpvar_17;
					  tmpvar_17 = dot (worldN_1, lightDir_14);
					  mediump float tmpvar_18;
					  tmpvar_18 = (pow (max (0.0, 
					    dot (worldN_1, normalize((lightDir_14 + viewDir_15)))
					  ), (tmpvar_7 * 128.0)) * tmpvar_8);
					  lowp float tmpvar_19;
					  mediump float tmpvar_20;
					  tmpvar_20 = clamp (dot (viewDir_15, -(lightDir_14)), 0.0, 1.0);
					  tmpvar_19 = tmpvar_20;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp (-(tmpvar_17), 0.0, 1.0);
					  mediump float tmpvar_22;
					  tmpvar_22 = max (0.0, ((tmpvar_17 * 0.6) + 0.4));
					  c_16.xyz = (((tmpvar_9.xyz * _Color.xyz) * xlv_COLOR0.xyz) * ((
					    (mix (tmpvar_21, tmpvar_19, _TranslucencyViewDependency) * texture2D (_TranslucencyMap, xlv_TEXCOORD0).xyz)
					   * 
					    (_TranslucencyColor * 2.0)
					  ) + tmpvar_22));
					  c_16.xyz = ((c_16.xyz * _LightColor0.xyz) + tmpvar_18);
					  c_16.xyz = (c_16.xyz * _LightColor0.xyz);
					  tmpvar_13 = c_16;
					  c_2 = tmpvar_13;
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
					uniform highp vec4 _Time;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = _glesColor;
					  lowp float tangentSign_3;
					  lowp vec3 worldTangent_4;
					  lowp vec3 worldNormal_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = tmpvar_1.w;
					  highp float bendingFact_7;
					  highp vec4 wind_8;
					  lowp float tmpvar_9;
					  tmpvar_9 = tmpvar_2.w;
					  bendingFact_7 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_WorldToObject[0].xyz;
					  tmpvar_10[1] = unity_WorldToObject[1].xyz;
					  tmpvar_10[2] = unity_WorldToObject[2].xyz;
					  wind_8.xyz = (tmpvar_10 * _Wind.xyz);
					  wind_8.w = (_Wind.w * bendingFact_7);
					  highp vec2 tmpvar_11;
					  tmpvar_11.y = 1.0;
					  tmpvar_11.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_12;
					  pos_12.w = tmpvar_1.w;
					  highp vec3 bend_13;
					  highp vec4 v_14;
					  v_14.x = unity_ObjectToWorld[0].w;
					  v_14.y = unity_ObjectToWorld[1].w;
					  v_14.z = unity_ObjectToWorld[2].w;
					  v_14.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_15;
					  tmpvar_15 = dot (v_14.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_15)));
					  tmpvar_16.y = tmpvar_15;
					  highp vec4 tmpvar_17;
					  tmpvar_17 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_11).xx + tmpvar_16).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_18;
					  tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
					  highp vec2 tmpvar_19;
					  tmpvar_19 = (tmpvar_18.xz + tmpvar_18.yw);
					  bend_13.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_13.y = (bendingFact_7 * 0.3);
					  pos_12.xyz = (_glesVertex.xyz + ((
					    (tmpvar_19.xyx * bend_13)
					   + 
					    ((wind_8.xyz * tmpvar_19.y) * bendingFact_7)
					  ) * wind_8.w));
					  pos_12.xyz = (pos_12.xyz + (bendingFact_7 * wind_8.xyz));
					  tmpvar_6.xyz = pos_12.xyz;
					  highp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = tmpvar_6.xyz;
					  highp vec4 v_21;
					  v_21.x = unity_WorldToObject[0].x;
					  v_21.y = unity_WorldToObject[1].x;
					  v_21.z = unity_WorldToObject[2].x;
					  v_21.w = unity_WorldToObject[3].x;
					  highp vec4 v_22;
					  v_22.x = unity_WorldToObject[0].y;
					  v_22.y = unity_WorldToObject[1].y;
					  v_22.z = unity_WorldToObject[2].y;
					  v_22.w = unity_WorldToObject[3].y;
					  highp vec4 v_23;
					  v_23.x = unity_WorldToObject[0].z;
					  v_23.y = unity_WorldToObject[1].z;
					  v_23.z = unity_WorldToObject[2].z;
					  v_23.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_24;
					  tmpvar_24 = normalize(((
					    (v_21.xyz * _glesNormal.x)
					   + 
					    (v_22.xyz * _glesNormal.y)
					  ) + (v_23.xyz * _glesNormal.z)));
					  worldNormal_5 = tmpvar_24;
					  highp mat3 tmpvar_25;
					  tmpvar_25[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_25[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_25[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_26;
					  tmpvar_26 = normalize((tmpvar_25 * _glesTANGENT.xyz));
					  worldTangent_4 = tmpvar_26;
					  highp float tmpvar_27;
					  tmpvar_27 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_3 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = (((worldNormal_5.yzx * worldTangent_4.zxy) - (worldNormal_5.zxy * worldTangent_4.yzx)) * tangentSign_3);
					  lowp vec3 tmpvar_29;
					  tmpvar_29.x = worldTangent_4.x;
					  tmpvar_29.y = tmpvar_28.x;
					  tmpvar_29.z = worldNormal_5.x;
					  lowp vec3 tmpvar_30;
					  tmpvar_30.x = worldTangent_4.y;
					  tmpvar_30.y = tmpvar_28.y;
					  tmpvar_30.z = worldNormal_5.y;
					  lowp vec3 tmpvar_31;
					  tmpvar_31.x = worldTangent_4.z;
					  tmpvar_31.y = tmpvar_28.z;
					  tmpvar_31.z = worldNormal_5.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_20);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_29;
					  xlv_TEXCOORD2 = tmpvar_30;
					  xlv_TEXCOORD3 = tmpvar_31;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_6).xyz;
					  xlv_COLOR0 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					uniform sampler2D _GlossMap;
					uniform sampler2D _TranslucencyMap;
					uniform mediump float _Shininess;
					uniform lowp vec4 _Color;
					uniform lowp vec3 _TranslucencyColor;
					uniform lowp float _TranslucencyViewDependency;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
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
					  lowp float tmpvar_8;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpvar_8 = _Shininess;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = texture2D (_GlossMap, xlv_TEXCOORD0);
					  tmpvar_7 = tmpvar_10.w;
					  lowp vec3 tmpvar_11;
					  tmpvar_11 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
					  lowp float x_12;
					  x_12 = (tmpvar_9.w - _Cutoff);
					  if ((x_12 < 0.0)) {
					    discard;
					  };
					  worldN_1.x = dot (xlv_TEXCOORD1, tmpvar_11);
					  worldN_1.y = dot (xlv_TEXCOORD2, tmpvar_11);
					  worldN_1.z = dot (xlv_TEXCOORD3, tmpvar_11);
					  mediump vec4 tmpvar_13;
					  mediump vec3 lightDir_14;
					  lightDir_14 = lightDir_4;
					  mediump vec3 viewDir_15;
					  viewDir_15 = worldViewDir_3;
					  lowp vec4 c_16;
					  mediump float tmpvar_17;
					  tmpvar_17 = dot (worldN_1, lightDir_14);
					  mediump float tmpvar_18;
					  tmpvar_18 = (pow (max (0.0, 
					    dot (worldN_1, normalize((lightDir_14 + viewDir_15)))
					  ), (tmpvar_7 * 128.0)) * tmpvar_8);
					  lowp float tmpvar_19;
					  mediump float tmpvar_20;
					  tmpvar_20 = clamp (dot (viewDir_15, -(lightDir_14)), 0.0, 1.0);
					  tmpvar_19 = tmpvar_20;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp (-(tmpvar_17), 0.0, 1.0);
					  mediump float tmpvar_22;
					  tmpvar_22 = max (0.0, ((tmpvar_17 * 0.6) + 0.4));
					  c_16.xyz = (((tmpvar_9.xyz * _Color.xyz) * xlv_COLOR0.xyz) * ((
					    (mix (tmpvar_21, tmpvar_19, _TranslucencyViewDependency) * texture2D (_TranslucencyMap, xlv_TEXCOORD0).xyz)
					   * 
					    (_TranslucencyColor * 2.0)
					  ) + tmpvar_22));
					  c_16.xyz = ((c_16.xyz * _LightColor0.xyz) + tmpvar_18);
					  c_16.xyz = (c_16.xyz * _LightColor0.xyz);
					  tmpvar_13 = c_16;
					  c_2 = tmpvar_13;
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
					uniform highp vec4 _Time;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = _glesColor;
					  lowp float tangentSign_3;
					  lowp vec3 worldTangent_4;
					  lowp vec3 worldNormal_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = tmpvar_1.w;
					  highp float bendingFact_7;
					  highp vec4 wind_8;
					  lowp float tmpvar_9;
					  tmpvar_9 = tmpvar_2.w;
					  bendingFact_7 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_WorldToObject[0].xyz;
					  tmpvar_10[1] = unity_WorldToObject[1].xyz;
					  tmpvar_10[2] = unity_WorldToObject[2].xyz;
					  wind_8.xyz = (tmpvar_10 * _Wind.xyz);
					  wind_8.w = (_Wind.w * bendingFact_7);
					  highp vec2 tmpvar_11;
					  tmpvar_11.y = 1.0;
					  tmpvar_11.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_12;
					  pos_12.w = tmpvar_1.w;
					  highp vec3 bend_13;
					  highp vec4 v_14;
					  v_14.x = unity_ObjectToWorld[0].w;
					  v_14.y = unity_ObjectToWorld[1].w;
					  v_14.z = unity_ObjectToWorld[2].w;
					  v_14.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_15;
					  tmpvar_15 = dot (v_14.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_15)));
					  tmpvar_16.y = tmpvar_15;
					  highp vec4 tmpvar_17;
					  tmpvar_17 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_11).xx + tmpvar_16).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_18;
					  tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
					  highp vec2 tmpvar_19;
					  tmpvar_19 = (tmpvar_18.xz + tmpvar_18.yw);
					  bend_13.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_13.y = (bendingFact_7 * 0.3);
					  pos_12.xyz = (_glesVertex.xyz + ((
					    (tmpvar_19.xyx * bend_13)
					   + 
					    ((wind_8.xyz * tmpvar_19.y) * bendingFact_7)
					  ) * wind_8.w));
					  pos_12.xyz = (pos_12.xyz + (bendingFact_7 * wind_8.xyz));
					  tmpvar_6.xyz = pos_12.xyz;
					  highp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = tmpvar_6.xyz;
					  highp vec4 v_21;
					  v_21.x = unity_WorldToObject[0].x;
					  v_21.y = unity_WorldToObject[1].x;
					  v_21.z = unity_WorldToObject[2].x;
					  v_21.w = unity_WorldToObject[3].x;
					  highp vec4 v_22;
					  v_22.x = unity_WorldToObject[0].y;
					  v_22.y = unity_WorldToObject[1].y;
					  v_22.z = unity_WorldToObject[2].y;
					  v_22.w = unity_WorldToObject[3].y;
					  highp vec4 v_23;
					  v_23.x = unity_WorldToObject[0].z;
					  v_23.y = unity_WorldToObject[1].z;
					  v_23.z = unity_WorldToObject[2].z;
					  v_23.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_24;
					  tmpvar_24 = normalize(((
					    (v_21.xyz * _glesNormal.x)
					   + 
					    (v_22.xyz * _glesNormal.y)
					  ) + (v_23.xyz * _glesNormal.z)));
					  worldNormal_5 = tmpvar_24;
					  highp mat3 tmpvar_25;
					  tmpvar_25[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_25[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_25[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_26;
					  tmpvar_26 = normalize((tmpvar_25 * _glesTANGENT.xyz));
					  worldTangent_4 = tmpvar_26;
					  highp float tmpvar_27;
					  tmpvar_27 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_3 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = (((worldNormal_5.yzx * worldTangent_4.zxy) - (worldNormal_5.zxy * worldTangent_4.yzx)) * tangentSign_3);
					  lowp vec3 tmpvar_29;
					  tmpvar_29.x = worldTangent_4.x;
					  tmpvar_29.y = tmpvar_28.x;
					  tmpvar_29.z = worldNormal_5.x;
					  lowp vec3 tmpvar_30;
					  tmpvar_30.x = worldTangent_4.y;
					  tmpvar_30.y = tmpvar_28.y;
					  tmpvar_30.z = worldNormal_5.y;
					  lowp vec3 tmpvar_31;
					  tmpvar_31.x = worldTangent_4.z;
					  tmpvar_31.y = tmpvar_28.z;
					  tmpvar_31.z = worldNormal_5.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_20);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_29;
					  xlv_TEXCOORD2 = tmpvar_30;
					  xlv_TEXCOORD3 = tmpvar_31;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_6).xyz;
					  xlv_COLOR0 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					uniform sampler2D _GlossMap;
					uniform sampler2D _TranslucencyMap;
					uniform mediump float _Shininess;
					uniform lowp vec4 _Color;
					uniform lowp vec3 _TranslucencyColor;
					uniform lowp float _TranslucencyViewDependency;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
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
					  lowp float tmpvar_8;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpvar_8 = _Shininess;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = texture2D (_GlossMap, xlv_TEXCOORD0);
					  tmpvar_7 = tmpvar_10.w;
					  lowp vec3 tmpvar_11;
					  tmpvar_11 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
					  lowp float x_12;
					  x_12 = (tmpvar_9.w - _Cutoff);
					  if ((x_12 < 0.0)) {
					    discard;
					  };
					  worldN_1.x = dot (xlv_TEXCOORD1, tmpvar_11);
					  worldN_1.y = dot (xlv_TEXCOORD2, tmpvar_11);
					  worldN_1.z = dot (xlv_TEXCOORD3, tmpvar_11);
					  mediump vec4 tmpvar_13;
					  mediump vec3 lightDir_14;
					  lightDir_14 = lightDir_4;
					  mediump vec3 viewDir_15;
					  viewDir_15 = worldViewDir_3;
					  lowp vec4 c_16;
					  mediump float tmpvar_17;
					  tmpvar_17 = dot (worldN_1, lightDir_14);
					  mediump float tmpvar_18;
					  tmpvar_18 = (pow (max (0.0, 
					    dot (worldN_1, normalize((lightDir_14 + viewDir_15)))
					  ), (tmpvar_7 * 128.0)) * tmpvar_8);
					  lowp float tmpvar_19;
					  mediump float tmpvar_20;
					  tmpvar_20 = clamp (dot (viewDir_15, -(lightDir_14)), 0.0, 1.0);
					  tmpvar_19 = tmpvar_20;
					  mediump float tmpvar_21;
					  tmpvar_21 = clamp (-(tmpvar_17), 0.0, 1.0);
					  mediump float tmpvar_22;
					  tmpvar_22 = max (0.0, ((tmpvar_17 * 0.6) + 0.4));
					  c_16.xyz = (((tmpvar_9.xyz * _Color.xyz) * xlv_COLOR0.xyz) * ((
					    (mix (tmpvar_21, tmpvar_19, _TranslucencyViewDependency) * texture2D (_TranslucencyMap, xlv_TEXCOORD0).xyz)
					   * 
					    (_TranslucencyColor * 2.0)
					  ) + tmpvar_22));
					  c_16.xyz = ((c_16.xyz * _LightColor0.xyz) + tmpvar_18);
					  c_16.xyz = (c_16.xyz * _LightColor0.xyz);
					  tmpvar_13 = c_16;
					  c_2 = tmpvar_13;
					  gl_FragData[0] = c_2;
					}
					
					
					#endif
}
}
Program "fp" {
// Platform gles3 skipped due to earlier errors
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
					
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
					
}
SubProgram "gles hw_tier03 " {
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
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" }
					
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
					
}
SubProgram "gles hw_tier03 " {
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
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
					
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
					
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL_COOKIE" }
					
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassBase" "IGNOREPROJECTOR"="true" "RenderType"="TreeLeaf" }
  Cull Off
  GpuProgramID 194094
Program "vp" {
// Platform gles3 skipped due to earlier errors
// Platform gles3 skipped due to earlier errors
SubProgram "gles hw_tier01 " {

					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp float tangentSign_2;
					  lowp vec3 worldTangent_3;
					  lowp vec3 worldNormal_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = tmpvar_1.w;
					  highp float bendingFact_6;
					  highp vec4 wind_7;
					  lowp float tmpvar_8;
					  tmpvar_8 = _glesColor.w;
					  bendingFact_6 = tmpvar_8;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_WorldToObject[0].xyz;
					  tmpvar_9[1] = unity_WorldToObject[1].xyz;
					  tmpvar_9[2] = unity_WorldToObject[2].xyz;
					  wind_7.xyz = (tmpvar_9 * _Wind.xyz);
					  wind_7.w = (_Wind.w * bendingFact_6);
					  highp vec2 tmpvar_10;
					  tmpvar_10.y = 1.0;
					  tmpvar_10.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_11;
					  pos_11.w = tmpvar_1.w;
					  highp vec3 bend_12;
					  highp vec4 v_13;
					  v_13.x = unity_ObjectToWorld[0].w;
					  v_13.y = unity_ObjectToWorld[1].w;
					  v_13.z = unity_ObjectToWorld[2].w;
					  v_13.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_14;
					  tmpvar_14 = dot (v_13.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_15;
					  tmpvar_15.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_14)));
					  tmpvar_15.y = tmpvar_14;
					  highp vec4 tmpvar_16;
					  tmpvar_16 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_10).xx + tmpvar_15).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_17;
					  tmpvar_17 = ((tmpvar_16 * tmpvar_16) * (3.0 - (2.0 * tmpvar_16)));
					  highp vec2 tmpvar_18;
					  tmpvar_18 = (tmpvar_17.xz + tmpvar_17.yw);
					  bend_12.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_12.y = (bendingFact_6 * 0.3);
					  pos_11.xyz = (_glesVertex.xyz + ((
					    (tmpvar_18.xyx * bend_12)
					   + 
					    ((wind_7.xyz * tmpvar_18.y) * bendingFact_6)
					  ) * wind_7.w));
					  pos_11.xyz = (pos_11.xyz + (bendingFact_6 * wind_7.xyz));
					  tmpvar_5.xyz = pos_11.xyz;
					  highp vec4 tmpvar_19;
					  tmpvar_19.w = 1.0;
					  tmpvar_19.xyz = tmpvar_5.xyz;
					  highp vec4 v_20;
					  v_20.x = unity_WorldToObject[0].x;
					  v_20.y = unity_WorldToObject[1].x;
					  v_20.z = unity_WorldToObject[2].x;
					  v_20.w = unity_WorldToObject[3].x;
					  highp vec4 v_21;
					  v_21.x = unity_WorldToObject[0].y;
					  v_21.y = unity_WorldToObject[1].y;
					  v_21.z = unity_WorldToObject[2].y;
					  v_21.w = unity_WorldToObject[3].y;
					  highp vec4 v_22;
					  v_22.x = unity_WorldToObject[0].z;
					  v_22.y = unity_WorldToObject[1].z;
					  v_22.z = unity_WorldToObject[2].z;
					  v_22.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_23;
					  tmpvar_23 = normalize(((
					    (v_20.xyz * _glesNormal.x)
					   + 
					    (v_21.xyz * _glesNormal.y)
					  ) + (v_22.xyz * _glesNormal.z)));
					  worldNormal_4 = tmpvar_23;
					  highp mat3 tmpvar_24;
					  tmpvar_24[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_24[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_24[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_25;
					  tmpvar_25 = normalize((tmpvar_24 * _glesTANGENT.xyz));
					  worldTangent_3 = tmpvar_25;
					  highp float tmpvar_26;
					  tmpvar_26 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_2 = tmpvar_26;
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * tangentSign_2);
					  lowp vec3 tmpvar_28;
					  tmpvar_28.x = worldTangent_3.x;
					  tmpvar_28.y = tmpvar_27.x;
					  tmpvar_28.z = worldNormal_4.x;
					  lowp vec3 tmpvar_29;
					  tmpvar_29.x = worldTangent_3.y;
					  tmpvar_29.y = tmpvar_27.y;
					  tmpvar_29.z = worldNormal_4.y;
					  lowp vec3 tmpvar_30;
					  tmpvar_30.x = worldTangent_3.z;
					  tmpvar_30.y = tmpvar_27.z;
					  tmpvar_30.z = worldNormal_4.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_19);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_28;
					  xlv_TEXCOORD2 = tmpvar_29;
					  xlv_TEXCOORD3 = tmpvar_30;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					uniform sampler2D _GlossMap;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec4 res_1;
					  lowp vec3 worldN_2;
					  mediump float tmpvar_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_GlossMap, xlv_TEXCOORD0);
					  tmpvar_3 = tmpvar_4.w;
					  lowp vec3 tmpvar_5;
					  tmpvar_5 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
					  lowp float x_6;
					  x_6 = (texture2D (_MainTex, xlv_TEXCOORD0).w - _Cutoff);
					  if ((x_6 < 0.0)) {
					    discard;
					  };
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
					uniform highp vec4 _Time;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp float tangentSign_2;
					  lowp vec3 worldTangent_3;
					  lowp vec3 worldNormal_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = tmpvar_1.w;
					  highp float bendingFact_6;
					  highp vec4 wind_7;
					  lowp float tmpvar_8;
					  tmpvar_8 = _glesColor.w;
					  bendingFact_6 = tmpvar_8;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_WorldToObject[0].xyz;
					  tmpvar_9[1] = unity_WorldToObject[1].xyz;
					  tmpvar_9[2] = unity_WorldToObject[2].xyz;
					  wind_7.xyz = (tmpvar_9 * _Wind.xyz);
					  wind_7.w = (_Wind.w * bendingFact_6);
					  highp vec2 tmpvar_10;
					  tmpvar_10.y = 1.0;
					  tmpvar_10.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_11;
					  pos_11.w = tmpvar_1.w;
					  highp vec3 bend_12;
					  highp vec4 v_13;
					  v_13.x = unity_ObjectToWorld[0].w;
					  v_13.y = unity_ObjectToWorld[1].w;
					  v_13.z = unity_ObjectToWorld[2].w;
					  v_13.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_14;
					  tmpvar_14 = dot (v_13.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_15;
					  tmpvar_15.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_14)));
					  tmpvar_15.y = tmpvar_14;
					  highp vec4 tmpvar_16;
					  tmpvar_16 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_10).xx + tmpvar_15).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_17;
					  tmpvar_17 = ((tmpvar_16 * tmpvar_16) * (3.0 - (2.0 * tmpvar_16)));
					  highp vec2 tmpvar_18;
					  tmpvar_18 = (tmpvar_17.xz + tmpvar_17.yw);
					  bend_12.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_12.y = (bendingFact_6 * 0.3);
					  pos_11.xyz = (_glesVertex.xyz + ((
					    (tmpvar_18.xyx * bend_12)
					   + 
					    ((wind_7.xyz * tmpvar_18.y) * bendingFact_6)
					  ) * wind_7.w));
					  pos_11.xyz = (pos_11.xyz + (bendingFact_6 * wind_7.xyz));
					  tmpvar_5.xyz = pos_11.xyz;
					  highp vec4 tmpvar_19;
					  tmpvar_19.w = 1.0;
					  tmpvar_19.xyz = tmpvar_5.xyz;
					  highp vec4 v_20;
					  v_20.x = unity_WorldToObject[0].x;
					  v_20.y = unity_WorldToObject[1].x;
					  v_20.z = unity_WorldToObject[2].x;
					  v_20.w = unity_WorldToObject[3].x;
					  highp vec4 v_21;
					  v_21.x = unity_WorldToObject[0].y;
					  v_21.y = unity_WorldToObject[1].y;
					  v_21.z = unity_WorldToObject[2].y;
					  v_21.w = unity_WorldToObject[3].y;
					  highp vec4 v_22;
					  v_22.x = unity_WorldToObject[0].z;
					  v_22.y = unity_WorldToObject[1].z;
					  v_22.z = unity_WorldToObject[2].z;
					  v_22.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_23;
					  tmpvar_23 = normalize(((
					    (v_20.xyz * _glesNormal.x)
					   + 
					    (v_21.xyz * _glesNormal.y)
					  ) + (v_22.xyz * _glesNormal.z)));
					  worldNormal_4 = tmpvar_23;
					  highp mat3 tmpvar_24;
					  tmpvar_24[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_24[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_24[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_25;
					  tmpvar_25 = normalize((tmpvar_24 * _glesTANGENT.xyz));
					  worldTangent_3 = tmpvar_25;
					  highp float tmpvar_26;
					  tmpvar_26 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_2 = tmpvar_26;
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * tangentSign_2);
					  lowp vec3 tmpvar_28;
					  tmpvar_28.x = worldTangent_3.x;
					  tmpvar_28.y = tmpvar_27.x;
					  tmpvar_28.z = worldNormal_4.x;
					  lowp vec3 tmpvar_29;
					  tmpvar_29.x = worldTangent_3.y;
					  tmpvar_29.y = tmpvar_27.y;
					  tmpvar_29.z = worldNormal_4.y;
					  lowp vec3 tmpvar_30;
					  tmpvar_30.x = worldTangent_3.z;
					  tmpvar_30.y = tmpvar_27.z;
					  tmpvar_30.z = worldNormal_4.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_19);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_28;
					  xlv_TEXCOORD2 = tmpvar_29;
					  xlv_TEXCOORD3 = tmpvar_30;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					uniform sampler2D _GlossMap;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec4 res_1;
					  lowp vec3 worldN_2;
					  mediump float tmpvar_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_GlossMap, xlv_TEXCOORD0);
					  tmpvar_3 = tmpvar_4.w;
					  lowp vec3 tmpvar_5;
					  tmpvar_5 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
					  lowp float x_6;
					  x_6 = (texture2D (_MainTex, xlv_TEXCOORD0).w - _Cutoff);
					  if ((x_6 < 0.0)) {
					    discard;
					  };
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
					uniform highp vec4 _Time;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp float tangentSign_2;
					  lowp vec3 worldTangent_3;
					  lowp vec3 worldNormal_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = tmpvar_1.w;
					  highp float bendingFact_6;
					  highp vec4 wind_7;
					  lowp float tmpvar_8;
					  tmpvar_8 = _glesColor.w;
					  bendingFact_6 = tmpvar_8;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_WorldToObject[0].xyz;
					  tmpvar_9[1] = unity_WorldToObject[1].xyz;
					  tmpvar_9[2] = unity_WorldToObject[2].xyz;
					  wind_7.xyz = (tmpvar_9 * _Wind.xyz);
					  wind_7.w = (_Wind.w * bendingFact_6);
					  highp vec2 tmpvar_10;
					  tmpvar_10.y = 1.0;
					  tmpvar_10.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_11;
					  pos_11.w = tmpvar_1.w;
					  highp vec3 bend_12;
					  highp vec4 v_13;
					  v_13.x = unity_ObjectToWorld[0].w;
					  v_13.y = unity_ObjectToWorld[1].w;
					  v_13.z = unity_ObjectToWorld[2].w;
					  v_13.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_14;
					  tmpvar_14 = dot (v_13.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_15;
					  tmpvar_15.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_14)));
					  tmpvar_15.y = tmpvar_14;
					  highp vec4 tmpvar_16;
					  tmpvar_16 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_10).xx + tmpvar_15).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_17;
					  tmpvar_17 = ((tmpvar_16 * tmpvar_16) * (3.0 - (2.0 * tmpvar_16)));
					  highp vec2 tmpvar_18;
					  tmpvar_18 = (tmpvar_17.xz + tmpvar_17.yw);
					  bend_12.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_12.y = (bendingFact_6 * 0.3);
					  pos_11.xyz = (_glesVertex.xyz + ((
					    (tmpvar_18.xyx * bend_12)
					   + 
					    ((wind_7.xyz * tmpvar_18.y) * bendingFact_6)
					  ) * wind_7.w));
					  pos_11.xyz = (pos_11.xyz + (bendingFact_6 * wind_7.xyz));
					  tmpvar_5.xyz = pos_11.xyz;
					  highp vec4 tmpvar_19;
					  tmpvar_19.w = 1.0;
					  tmpvar_19.xyz = tmpvar_5.xyz;
					  highp vec4 v_20;
					  v_20.x = unity_WorldToObject[0].x;
					  v_20.y = unity_WorldToObject[1].x;
					  v_20.z = unity_WorldToObject[2].x;
					  v_20.w = unity_WorldToObject[3].x;
					  highp vec4 v_21;
					  v_21.x = unity_WorldToObject[0].y;
					  v_21.y = unity_WorldToObject[1].y;
					  v_21.z = unity_WorldToObject[2].y;
					  v_21.w = unity_WorldToObject[3].y;
					  highp vec4 v_22;
					  v_22.x = unity_WorldToObject[0].z;
					  v_22.y = unity_WorldToObject[1].z;
					  v_22.z = unity_WorldToObject[2].z;
					  v_22.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_23;
					  tmpvar_23 = normalize(((
					    (v_20.xyz * _glesNormal.x)
					   + 
					    (v_21.xyz * _glesNormal.y)
					  ) + (v_22.xyz * _glesNormal.z)));
					  worldNormal_4 = tmpvar_23;
					  highp mat3 tmpvar_24;
					  tmpvar_24[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_24[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_24[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_25;
					  tmpvar_25 = normalize((tmpvar_24 * _glesTANGENT.xyz));
					  worldTangent_3 = tmpvar_25;
					  highp float tmpvar_26;
					  tmpvar_26 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_2 = tmpvar_26;
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = (((worldNormal_4.yzx * worldTangent_3.zxy) - (worldNormal_4.zxy * worldTangent_3.yzx)) * tangentSign_2);
					  lowp vec3 tmpvar_28;
					  tmpvar_28.x = worldTangent_3.x;
					  tmpvar_28.y = tmpvar_27.x;
					  tmpvar_28.z = worldNormal_4.x;
					  lowp vec3 tmpvar_29;
					  tmpvar_29.x = worldTangent_3.y;
					  tmpvar_29.y = tmpvar_27.y;
					  tmpvar_29.z = worldNormal_4.y;
					  lowp vec3 tmpvar_30;
					  tmpvar_30.x = worldTangent_3.z;
					  tmpvar_30.y = tmpvar_27.z;
					  tmpvar_30.z = worldNormal_4.z;
					  gl_Position = (glstate_matrix_mvp * tmpvar_19);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_28;
					  xlv_TEXCOORD2 = tmpvar_29;
					  xlv_TEXCOORD3 = tmpvar_30;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					uniform sampler2D _GlossMap;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec4 res_1;
					  lowp vec3 worldN_2;
					  mediump float tmpvar_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_GlossMap, xlv_TEXCOORD0);
					  tmpvar_3 = tmpvar_4.w;
					  lowp vec3 tmpvar_5;
					  tmpvar_5 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
					  lowp float x_6;
					  x_6 = (texture2D (_MainTex, xlv_TEXCOORD0).w - _Cutoff);
					  if ((x_6 < 0.0)) {
					    discard;
					  };
					  worldN_2.x = dot (xlv_TEXCOORD1, tmpvar_5);
					  worldN_2.y = dot (xlv_TEXCOORD2, tmpvar_5);
					  worldN_2.z = dot (xlv_TEXCOORD3, tmpvar_5);
					  res_1.xyz = ((worldN_2 * 0.5) + 0.5);
					  res_1.w = tmpvar_3;
					  gl_FragData[0] = res_1;
					}
					
					
					#endif
}
}
Program "fp" {
// Platform gles3 skipped due to earlier errors
// Platform gles3 skipped due to earlier errors
SubProgram "gles hw_tier01 " {

}
SubProgram "gles hw_tier02 " {

}
SubProgram "gles hw_tier03 " {

}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassFinal" "IGNOREPROJECTOR"="true" "RenderType"="TreeLeaf" }
  ZWrite Off
  Cull Off
  GpuProgramID 251333
Program "vp" {
// Platform gles3 skipped due to earlier errors
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
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
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = _glesColor;
					  highp vec4 tmpvar_3;
					  highp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = tmpvar_1.w;
					  highp float bendingFact_6;
					  highp vec4 wind_7;
					  lowp float tmpvar_8;
					  tmpvar_8 = tmpvar_2.w;
					  bendingFact_6 = tmpvar_8;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_WorldToObject[0].xyz;
					  tmpvar_9[1] = unity_WorldToObject[1].xyz;
					  tmpvar_9[2] = unity_WorldToObject[2].xyz;
					  wind_7.xyz = (tmpvar_9 * _Wind.xyz);
					  wind_7.w = (_Wind.w * bendingFact_6);
					  highp vec2 tmpvar_10;
					  tmpvar_10.y = 1.0;
					  tmpvar_10.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_11;
					  pos_11.w = tmpvar_1.w;
					  highp vec3 bend_12;
					  highp vec4 v_13;
					  v_13.x = unity_ObjectToWorld[0].w;
					  v_13.y = unity_ObjectToWorld[1].w;
					  v_13.z = unity_ObjectToWorld[2].w;
					  v_13.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_14;
					  tmpvar_14 = dot (v_13.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_15;
					  tmpvar_15.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_14)));
					  tmpvar_15.y = tmpvar_14;
					  highp vec4 tmpvar_16;
					  tmpvar_16 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_10).xx + tmpvar_15).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_17;
					  tmpvar_17 = ((tmpvar_16 * tmpvar_16) * (3.0 - (2.0 * tmpvar_16)));
					  highp vec2 tmpvar_18;
					  tmpvar_18 = (tmpvar_17.xz + tmpvar_17.yw);
					  bend_12.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_12.y = (bendingFact_6 * 0.3);
					  pos_11.xyz = (_glesVertex.xyz + ((
					    (tmpvar_18.xyx * bend_12)
					   + 
					    ((wind_7.xyz * tmpvar_18.y) * bendingFact_6)
					  ) * wind_7.w));
					  pos_11.xyz = (pos_11.xyz + (bendingFact_6 * wind_7.xyz));
					  tmpvar_5.xyz = pos_11.xyz;
					  highp vec4 tmpvar_19;
					  highp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = tmpvar_5.xyz;
					  tmpvar_19 = (glstate_matrix_mvp * tmpvar_20);
					  highp vec4 o_21;
					  highp vec4 tmpvar_22;
					  tmpvar_22 = (tmpvar_19 * 0.5);
					  highp vec2 tmpvar_23;
					  tmpvar_23.x = tmpvar_22.x;
					  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
					  o_21.xy = (tmpvar_23 + tmpvar_22.w);
					  o_21.zw = tmpvar_19.zw;
					  tmpvar_3.zw = vec2(0.0, 0.0);
					  tmpvar_3.xy = vec2(0.0, 0.0);
					  highp vec4 v_24;
					  v_24.x = unity_WorldToObject[0].x;
					  v_24.y = unity_WorldToObject[1].x;
					  v_24.z = unity_WorldToObject[2].x;
					  v_24.w = unity_WorldToObject[3].x;
					  highp vec4 v_25;
					  v_25.x = unity_WorldToObject[0].y;
					  v_25.y = unity_WorldToObject[1].y;
					  v_25.z = unity_WorldToObject[2].y;
					  v_25.w = unity_WorldToObject[3].y;
					  highp vec4 v_26;
					  v_26.x = unity_WorldToObject[0].z;
					  v_26.y = unity_WorldToObject[1].z;
					  v_26.z = unity_WorldToObject[2].z;
					  v_26.w = unity_WorldToObject[3].z;
					  highp vec4 tmpvar_27;
					  tmpvar_27.w = 1.0;
					  tmpvar_27.xyz = normalize(((
					    (v_24.xyz * _glesNormal.x)
					   + 
					    (v_25.xyz * _glesNormal.y)
					  ) + (v_26.xyz * _glesNormal.z)));
					  mediump vec4 normal_28;
					  normal_28 = tmpvar_27;
					  mediump vec3 res_29;
					  mediump vec3 x_30;
					  x_30.x = dot (unity_SHAr, normal_28);
					  x_30.y = dot (unity_SHAg, normal_28);
					  x_30.z = dot (unity_SHAb, normal_28);
					  mediump vec3 x1_31;
					  mediump vec4 tmpvar_32;
					  tmpvar_32 = (normal_28.xyzz * normal_28.yzzx);
					  x1_31.x = dot (unity_SHBr, tmpvar_32);
					  x1_31.y = dot (unity_SHBg, tmpvar_32);
					  x1_31.z = dot (unity_SHBb, tmpvar_32);
					  res_29 = (x_30 + (x1_31 + (unity_SHC.xyz * 
					    ((normal_28.x * normal_28.x) - (normal_28.y * normal_28.y))
					  )));
					  res_29 = max (((1.055 * 
					    pow (max (res_29, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_4 = res_29;
					  gl_Position = tmpvar_19;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_COLOR0 = tmpvar_2;
					  xlv_TEXCOORD2 = o_21;
					  xlv_TEXCOORD3 = tmpvar_3;
					  xlv_TEXCOORD4 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _MainTex;
					uniform mediump float _Shininess;
					uniform lowp vec4 _Color;
					uniform sampler2D _LightBuffer;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 light_2;
					  lowp float tmpvar_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpvar_3 = _Shininess;
					  lowp float x_5;
					  x_5 = (tmpvar_4.w - _Cutoff);
					  if ((x_5 < 0.0)) {
					    discard;
					  };
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_2 = tmpvar_6;
					  light_2 = -(log2(max (light_2, vec4(0.001, 0.001, 0.001, 0.001))));
					  light_2.xyz = (light_2.xyz + xlv_TEXCOORD4);
					  mediump vec4 tmpvar_7;
					  lowp vec4 c_8;
					  lowp float spec_9;
					  mediump float tmpvar_10;
					  tmpvar_10 = (light_2.w * tmpvar_3);
					  spec_9 = tmpvar_10;
					  c_8.xyz = (((tmpvar_4.xyz * _Color.xyz) * (xlv_COLOR0.xyz * light_2.xyz)) + ((light_2.xyz * _SpecColor.xyz) * spec_9));
					  c_8.w = (tmpvar_4.w + (spec_9 * _SpecColor.w));
					  tmpvar_7 = c_8;
					  tmpvar_1 = tmpvar_7;
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
					uniform highp vec4 _Time;
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
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = _glesColor;
					  highp vec4 tmpvar_3;
					  highp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = tmpvar_1.w;
					  highp float bendingFact_6;
					  highp vec4 wind_7;
					  lowp float tmpvar_8;
					  tmpvar_8 = tmpvar_2.w;
					  bendingFact_6 = tmpvar_8;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_WorldToObject[0].xyz;
					  tmpvar_9[1] = unity_WorldToObject[1].xyz;
					  tmpvar_9[2] = unity_WorldToObject[2].xyz;
					  wind_7.xyz = (tmpvar_9 * _Wind.xyz);
					  wind_7.w = (_Wind.w * bendingFact_6);
					  highp vec2 tmpvar_10;
					  tmpvar_10.y = 1.0;
					  tmpvar_10.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_11;
					  pos_11.w = tmpvar_1.w;
					  highp vec3 bend_12;
					  highp vec4 v_13;
					  v_13.x = unity_ObjectToWorld[0].w;
					  v_13.y = unity_ObjectToWorld[1].w;
					  v_13.z = unity_ObjectToWorld[2].w;
					  v_13.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_14;
					  tmpvar_14 = dot (v_13.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_15;
					  tmpvar_15.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_14)));
					  tmpvar_15.y = tmpvar_14;
					  highp vec4 tmpvar_16;
					  tmpvar_16 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_10).xx + tmpvar_15).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_17;
					  tmpvar_17 = ((tmpvar_16 * tmpvar_16) * (3.0 - (2.0 * tmpvar_16)));
					  highp vec2 tmpvar_18;
					  tmpvar_18 = (tmpvar_17.xz + tmpvar_17.yw);
					  bend_12.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_12.y = (bendingFact_6 * 0.3);
					  pos_11.xyz = (_glesVertex.xyz + ((
					    (tmpvar_18.xyx * bend_12)
					   + 
					    ((wind_7.xyz * tmpvar_18.y) * bendingFact_6)
					  ) * wind_7.w));
					  pos_11.xyz = (pos_11.xyz + (bendingFact_6 * wind_7.xyz));
					  tmpvar_5.xyz = pos_11.xyz;
					  highp vec4 tmpvar_19;
					  highp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = tmpvar_5.xyz;
					  tmpvar_19 = (glstate_matrix_mvp * tmpvar_20);
					  highp vec4 o_21;
					  highp vec4 tmpvar_22;
					  tmpvar_22 = (tmpvar_19 * 0.5);
					  highp vec2 tmpvar_23;
					  tmpvar_23.x = tmpvar_22.x;
					  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
					  o_21.xy = (tmpvar_23 + tmpvar_22.w);
					  o_21.zw = tmpvar_19.zw;
					  tmpvar_3.zw = vec2(0.0, 0.0);
					  tmpvar_3.xy = vec2(0.0, 0.0);
					  highp vec4 v_24;
					  v_24.x = unity_WorldToObject[0].x;
					  v_24.y = unity_WorldToObject[1].x;
					  v_24.z = unity_WorldToObject[2].x;
					  v_24.w = unity_WorldToObject[3].x;
					  highp vec4 v_25;
					  v_25.x = unity_WorldToObject[0].y;
					  v_25.y = unity_WorldToObject[1].y;
					  v_25.z = unity_WorldToObject[2].y;
					  v_25.w = unity_WorldToObject[3].y;
					  highp vec4 v_26;
					  v_26.x = unity_WorldToObject[0].z;
					  v_26.y = unity_WorldToObject[1].z;
					  v_26.z = unity_WorldToObject[2].z;
					  v_26.w = unity_WorldToObject[3].z;
					  highp vec4 tmpvar_27;
					  tmpvar_27.w = 1.0;
					  tmpvar_27.xyz = normalize(((
					    (v_24.xyz * _glesNormal.x)
					   + 
					    (v_25.xyz * _glesNormal.y)
					  ) + (v_26.xyz * _glesNormal.z)));
					  mediump vec4 normal_28;
					  normal_28 = tmpvar_27;
					  mediump vec3 res_29;
					  mediump vec3 x_30;
					  x_30.x = dot (unity_SHAr, normal_28);
					  x_30.y = dot (unity_SHAg, normal_28);
					  x_30.z = dot (unity_SHAb, normal_28);
					  mediump vec3 x1_31;
					  mediump vec4 tmpvar_32;
					  tmpvar_32 = (normal_28.xyzz * normal_28.yzzx);
					  x1_31.x = dot (unity_SHBr, tmpvar_32);
					  x1_31.y = dot (unity_SHBg, tmpvar_32);
					  x1_31.z = dot (unity_SHBb, tmpvar_32);
					  res_29 = (x_30 + (x1_31 + (unity_SHC.xyz * 
					    ((normal_28.x * normal_28.x) - (normal_28.y * normal_28.y))
					  )));
					  res_29 = max (((1.055 * 
					    pow (max (res_29, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_4 = res_29;
					  gl_Position = tmpvar_19;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_COLOR0 = tmpvar_2;
					  xlv_TEXCOORD2 = o_21;
					  xlv_TEXCOORD3 = tmpvar_3;
					  xlv_TEXCOORD4 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _MainTex;
					uniform mediump float _Shininess;
					uniform lowp vec4 _Color;
					uniform sampler2D _LightBuffer;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 light_2;
					  lowp float tmpvar_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpvar_3 = _Shininess;
					  lowp float x_5;
					  x_5 = (tmpvar_4.w - _Cutoff);
					  if ((x_5 < 0.0)) {
					    discard;
					  };
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_2 = tmpvar_6;
					  light_2 = -(log2(max (light_2, vec4(0.001, 0.001, 0.001, 0.001))));
					  light_2.xyz = (light_2.xyz + xlv_TEXCOORD4);
					  mediump vec4 tmpvar_7;
					  lowp vec4 c_8;
					  lowp float spec_9;
					  mediump float tmpvar_10;
					  tmpvar_10 = (light_2.w * tmpvar_3);
					  spec_9 = tmpvar_10;
					  c_8.xyz = (((tmpvar_4.xyz * _Color.xyz) * (xlv_COLOR0.xyz * light_2.xyz)) + ((light_2.xyz * _SpecColor.xyz) * spec_9));
					  c_8.w = (tmpvar_4.w + (spec_9 * _SpecColor.w));
					  tmpvar_7 = c_8;
					  tmpvar_1 = tmpvar_7;
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
					uniform highp vec4 _Time;
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
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = _glesColor;
					  highp vec4 tmpvar_3;
					  highp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = tmpvar_1.w;
					  highp float bendingFact_6;
					  highp vec4 wind_7;
					  lowp float tmpvar_8;
					  tmpvar_8 = tmpvar_2.w;
					  bendingFact_6 = tmpvar_8;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_WorldToObject[0].xyz;
					  tmpvar_9[1] = unity_WorldToObject[1].xyz;
					  tmpvar_9[2] = unity_WorldToObject[2].xyz;
					  wind_7.xyz = (tmpvar_9 * _Wind.xyz);
					  wind_7.w = (_Wind.w * bendingFact_6);
					  highp vec2 tmpvar_10;
					  tmpvar_10.y = 1.0;
					  tmpvar_10.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_11;
					  pos_11.w = tmpvar_1.w;
					  highp vec3 bend_12;
					  highp vec4 v_13;
					  v_13.x = unity_ObjectToWorld[0].w;
					  v_13.y = unity_ObjectToWorld[1].w;
					  v_13.z = unity_ObjectToWorld[2].w;
					  v_13.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_14;
					  tmpvar_14 = dot (v_13.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_15;
					  tmpvar_15.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_14)));
					  tmpvar_15.y = tmpvar_14;
					  highp vec4 tmpvar_16;
					  tmpvar_16 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_10).xx + tmpvar_15).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_17;
					  tmpvar_17 = ((tmpvar_16 * tmpvar_16) * (3.0 - (2.0 * tmpvar_16)));
					  highp vec2 tmpvar_18;
					  tmpvar_18 = (tmpvar_17.xz + tmpvar_17.yw);
					  bend_12.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_12.y = (bendingFact_6 * 0.3);
					  pos_11.xyz = (_glesVertex.xyz + ((
					    (tmpvar_18.xyx * bend_12)
					   + 
					    ((wind_7.xyz * tmpvar_18.y) * bendingFact_6)
					  ) * wind_7.w));
					  pos_11.xyz = (pos_11.xyz + (bendingFact_6 * wind_7.xyz));
					  tmpvar_5.xyz = pos_11.xyz;
					  highp vec4 tmpvar_19;
					  highp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = tmpvar_5.xyz;
					  tmpvar_19 = (glstate_matrix_mvp * tmpvar_20);
					  highp vec4 o_21;
					  highp vec4 tmpvar_22;
					  tmpvar_22 = (tmpvar_19 * 0.5);
					  highp vec2 tmpvar_23;
					  tmpvar_23.x = tmpvar_22.x;
					  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
					  o_21.xy = (tmpvar_23 + tmpvar_22.w);
					  o_21.zw = tmpvar_19.zw;
					  tmpvar_3.zw = vec2(0.0, 0.0);
					  tmpvar_3.xy = vec2(0.0, 0.0);
					  highp vec4 v_24;
					  v_24.x = unity_WorldToObject[0].x;
					  v_24.y = unity_WorldToObject[1].x;
					  v_24.z = unity_WorldToObject[2].x;
					  v_24.w = unity_WorldToObject[3].x;
					  highp vec4 v_25;
					  v_25.x = unity_WorldToObject[0].y;
					  v_25.y = unity_WorldToObject[1].y;
					  v_25.z = unity_WorldToObject[2].y;
					  v_25.w = unity_WorldToObject[3].y;
					  highp vec4 v_26;
					  v_26.x = unity_WorldToObject[0].z;
					  v_26.y = unity_WorldToObject[1].z;
					  v_26.z = unity_WorldToObject[2].z;
					  v_26.w = unity_WorldToObject[3].z;
					  highp vec4 tmpvar_27;
					  tmpvar_27.w = 1.0;
					  tmpvar_27.xyz = normalize(((
					    (v_24.xyz * _glesNormal.x)
					   + 
					    (v_25.xyz * _glesNormal.y)
					  ) + (v_26.xyz * _glesNormal.z)));
					  mediump vec4 normal_28;
					  normal_28 = tmpvar_27;
					  mediump vec3 res_29;
					  mediump vec3 x_30;
					  x_30.x = dot (unity_SHAr, normal_28);
					  x_30.y = dot (unity_SHAg, normal_28);
					  x_30.z = dot (unity_SHAb, normal_28);
					  mediump vec3 x1_31;
					  mediump vec4 tmpvar_32;
					  tmpvar_32 = (normal_28.xyzz * normal_28.yzzx);
					  x1_31.x = dot (unity_SHBr, tmpvar_32);
					  x1_31.y = dot (unity_SHBg, tmpvar_32);
					  x1_31.z = dot (unity_SHBb, tmpvar_32);
					  res_29 = (x_30 + (x1_31 + (unity_SHC.xyz * 
					    ((normal_28.x * normal_28.x) - (normal_28.y * normal_28.y))
					  )));
					  res_29 = max (((1.055 * 
					    pow (max (res_29, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_4 = res_29;
					  gl_Position = tmpvar_19;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_COLOR0 = tmpvar_2;
					  xlv_TEXCOORD2 = o_21;
					  xlv_TEXCOORD3 = tmpvar_3;
					  xlv_TEXCOORD4 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _MainTex;
					uniform mediump float _Shininess;
					uniform lowp vec4 _Color;
					uniform sampler2D _LightBuffer;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 light_2;
					  lowp float tmpvar_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpvar_3 = _Shininess;
					  lowp float x_5;
					  x_5 = (tmpvar_4.w - _Cutoff);
					  if ((x_5 < 0.0)) {
					    discard;
					  };
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_2 = tmpvar_6;
					  light_2 = -(log2(max (light_2, vec4(0.001, 0.001, 0.001, 0.001))));
					  light_2.xyz = (light_2.xyz + xlv_TEXCOORD4);
					  mediump vec4 tmpvar_7;
					  lowp vec4 c_8;
					  lowp float spec_9;
					  mediump float tmpvar_10;
					  tmpvar_10 = (light_2.w * tmpvar_3);
					  spec_9 = tmpvar_10;
					  c_8.xyz = (((tmpvar_4.xyz * _Color.xyz) * (xlv_COLOR0.xyz * light_2.xyz)) + ((light_2.xyz * _SpecColor.xyz) * spec_9));
					  c_8.w = (tmpvar_4.w + (spec_9 * _SpecColor.w));
					  tmpvar_7 = c_8;
					  tmpvar_1 = tmpvar_7;
					  gl_FragData[0] = tmpvar_1;
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
					uniform highp vec4 _Time;
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
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = _glesColor;
					  highp vec4 tmpvar_3;
					  highp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = tmpvar_1.w;
					  highp float bendingFact_6;
					  highp vec4 wind_7;
					  lowp float tmpvar_8;
					  tmpvar_8 = tmpvar_2.w;
					  bendingFact_6 = tmpvar_8;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_WorldToObject[0].xyz;
					  tmpvar_9[1] = unity_WorldToObject[1].xyz;
					  tmpvar_9[2] = unity_WorldToObject[2].xyz;
					  wind_7.xyz = (tmpvar_9 * _Wind.xyz);
					  wind_7.w = (_Wind.w * bendingFact_6);
					  highp vec2 tmpvar_10;
					  tmpvar_10.y = 1.0;
					  tmpvar_10.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_11;
					  pos_11.w = tmpvar_1.w;
					  highp vec3 bend_12;
					  highp vec4 v_13;
					  v_13.x = unity_ObjectToWorld[0].w;
					  v_13.y = unity_ObjectToWorld[1].w;
					  v_13.z = unity_ObjectToWorld[2].w;
					  v_13.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_14;
					  tmpvar_14 = dot (v_13.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_15;
					  tmpvar_15.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_14)));
					  tmpvar_15.y = tmpvar_14;
					  highp vec4 tmpvar_16;
					  tmpvar_16 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_10).xx + tmpvar_15).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_17;
					  tmpvar_17 = ((tmpvar_16 * tmpvar_16) * (3.0 - (2.0 * tmpvar_16)));
					  highp vec2 tmpvar_18;
					  tmpvar_18 = (tmpvar_17.xz + tmpvar_17.yw);
					  bend_12.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_12.y = (bendingFact_6 * 0.3);
					  pos_11.xyz = (_glesVertex.xyz + ((
					    (tmpvar_18.xyx * bend_12)
					   + 
					    ((wind_7.xyz * tmpvar_18.y) * bendingFact_6)
					  ) * wind_7.w));
					  pos_11.xyz = (pos_11.xyz + (bendingFact_6 * wind_7.xyz));
					  tmpvar_5.xyz = pos_11.xyz;
					  highp vec4 tmpvar_19;
					  highp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = tmpvar_5.xyz;
					  tmpvar_19 = (glstate_matrix_mvp * tmpvar_20);
					  highp vec4 o_21;
					  highp vec4 tmpvar_22;
					  tmpvar_22 = (tmpvar_19 * 0.5);
					  highp vec2 tmpvar_23;
					  tmpvar_23.x = tmpvar_22.x;
					  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
					  o_21.xy = (tmpvar_23 + tmpvar_22.w);
					  o_21.zw = tmpvar_19.zw;
					  tmpvar_3.zw = vec2(0.0, 0.0);
					  tmpvar_3.xy = vec2(0.0, 0.0);
					  highp vec4 v_24;
					  v_24.x = unity_WorldToObject[0].x;
					  v_24.y = unity_WorldToObject[1].x;
					  v_24.z = unity_WorldToObject[2].x;
					  v_24.w = unity_WorldToObject[3].x;
					  highp vec4 v_25;
					  v_25.x = unity_WorldToObject[0].y;
					  v_25.y = unity_WorldToObject[1].y;
					  v_25.z = unity_WorldToObject[2].y;
					  v_25.w = unity_WorldToObject[3].y;
					  highp vec4 v_26;
					  v_26.x = unity_WorldToObject[0].z;
					  v_26.y = unity_WorldToObject[1].z;
					  v_26.z = unity_WorldToObject[2].z;
					  v_26.w = unity_WorldToObject[3].z;
					  highp vec4 tmpvar_27;
					  tmpvar_27.w = 1.0;
					  tmpvar_27.xyz = normalize(((
					    (v_24.xyz * _glesNormal.x)
					   + 
					    (v_25.xyz * _glesNormal.y)
					  ) + (v_26.xyz * _glesNormal.z)));
					  mediump vec4 normal_28;
					  normal_28 = tmpvar_27;
					  mediump vec3 res_29;
					  mediump vec3 x_30;
					  x_30.x = dot (unity_SHAr, normal_28);
					  x_30.y = dot (unity_SHAg, normal_28);
					  x_30.z = dot (unity_SHAb, normal_28);
					  mediump vec3 x1_31;
					  mediump vec4 tmpvar_32;
					  tmpvar_32 = (normal_28.xyzz * normal_28.yzzx);
					  x1_31.x = dot (unity_SHBr, tmpvar_32);
					  x1_31.y = dot (unity_SHBg, tmpvar_32);
					  x1_31.z = dot (unity_SHBb, tmpvar_32);
					  res_29 = (x_30 + (x1_31 + (unity_SHC.xyz * 
					    ((normal_28.x * normal_28.x) - (normal_28.y * normal_28.y))
					  )));
					  res_29 = max (((1.055 * 
					    pow (max (res_29, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_4 = res_29;
					  gl_Position = tmpvar_19;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_COLOR0 = tmpvar_2;
					  xlv_TEXCOORD2 = o_21;
					  xlv_TEXCOORD3 = tmpvar_3;
					  xlv_TEXCOORD4 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _MainTex;
					uniform mediump float _Shininess;
					uniform lowp vec4 _Color;
					uniform sampler2D _LightBuffer;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 light_2;
					  lowp float tmpvar_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpvar_3 = _Shininess;
					  lowp float x_5;
					  x_5 = (tmpvar_4.w - _Cutoff);
					  if ((x_5 < 0.0)) {
					    discard;
					  };
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_2 = tmpvar_6;
					  mediump vec4 tmpvar_7;
					  tmpvar_7 = max (light_2, vec4(0.001, 0.001, 0.001, 0.001));
					  light_2.w = tmpvar_7.w;
					  light_2.xyz = (tmpvar_7.xyz + xlv_TEXCOORD4);
					  mediump vec4 tmpvar_8;
					  lowp vec4 c_9;
					  lowp float spec_10;
					  mediump float tmpvar_11;
					  tmpvar_11 = (tmpvar_7.w * tmpvar_3);
					  spec_10 = tmpvar_11;
					  c_9.xyz = (((tmpvar_4.xyz * _Color.xyz) * (xlv_COLOR0.xyz * light_2.xyz)) + ((light_2.xyz * _SpecColor.xyz) * spec_10));
					  c_9.w = (tmpvar_4.w + (spec_10 * _SpecColor.w));
					  tmpvar_8 = c_9;
					  tmpvar_1 = tmpvar_8;
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
					uniform highp vec4 _Time;
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
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = _glesColor;
					  highp vec4 tmpvar_3;
					  highp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = tmpvar_1.w;
					  highp float bendingFact_6;
					  highp vec4 wind_7;
					  lowp float tmpvar_8;
					  tmpvar_8 = tmpvar_2.w;
					  bendingFact_6 = tmpvar_8;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_WorldToObject[0].xyz;
					  tmpvar_9[1] = unity_WorldToObject[1].xyz;
					  tmpvar_9[2] = unity_WorldToObject[2].xyz;
					  wind_7.xyz = (tmpvar_9 * _Wind.xyz);
					  wind_7.w = (_Wind.w * bendingFact_6);
					  highp vec2 tmpvar_10;
					  tmpvar_10.y = 1.0;
					  tmpvar_10.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_11;
					  pos_11.w = tmpvar_1.w;
					  highp vec3 bend_12;
					  highp vec4 v_13;
					  v_13.x = unity_ObjectToWorld[0].w;
					  v_13.y = unity_ObjectToWorld[1].w;
					  v_13.z = unity_ObjectToWorld[2].w;
					  v_13.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_14;
					  tmpvar_14 = dot (v_13.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_15;
					  tmpvar_15.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_14)));
					  tmpvar_15.y = tmpvar_14;
					  highp vec4 tmpvar_16;
					  tmpvar_16 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_10).xx + tmpvar_15).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_17;
					  tmpvar_17 = ((tmpvar_16 * tmpvar_16) * (3.0 - (2.0 * tmpvar_16)));
					  highp vec2 tmpvar_18;
					  tmpvar_18 = (tmpvar_17.xz + tmpvar_17.yw);
					  bend_12.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_12.y = (bendingFact_6 * 0.3);
					  pos_11.xyz = (_glesVertex.xyz + ((
					    (tmpvar_18.xyx * bend_12)
					   + 
					    ((wind_7.xyz * tmpvar_18.y) * bendingFact_6)
					  ) * wind_7.w));
					  pos_11.xyz = (pos_11.xyz + (bendingFact_6 * wind_7.xyz));
					  tmpvar_5.xyz = pos_11.xyz;
					  highp vec4 tmpvar_19;
					  highp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = tmpvar_5.xyz;
					  tmpvar_19 = (glstate_matrix_mvp * tmpvar_20);
					  highp vec4 o_21;
					  highp vec4 tmpvar_22;
					  tmpvar_22 = (tmpvar_19 * 0.5);
					  highp vec2 tmpvar_23;
					  tmpvar_23.x = tmpvar_22.x;
					  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
					  o_21.xy = (tmpvar_23 + tmpvar_22.w);
					  o_21.zw = tmpvar_19.zw;
					  tmpvar_3.zw = vec2(0.0, 0.0);
					  tmpvar_3.xy = vec2(0.0, 0.0);
					  highp vec4 v_24;
					  v_24.x = unity_WorldToObject[0].x;
					  v_24.y = unity_WorldToObject[1].x;
					  v_24.z = unity_WorldToObject[2].x;
					  v_24.w = unity_WorldToObject[3].x;
					  highp vec4 v_25;
					  v_25.x = unity_WorldToObject[0].y;
					  v_25.y = unity_WorldToObject[1].y;
					  v_25.z = unity_WorldToObject[2].y;
					  v_25.w = unity_WorldToObject[3].y;
					  highp vec4 v_26;
					  v_26.x = unity_WorldToObject[0].z;
					  v_26.y = unity_WorldToObject[1].z;
					  v_26.z = unity_WorldToObject[2].z;
					  v_26.w = unity_WorldToObject[3].z;
					  highp vec4 tmpvar_27;
					  tmpvar_27.w = 1.0;
					  tmpvar_27.xyz = normalize(((
					    (v_24.xyz * _glesNormal.x)
					   + 
					    (v_25.xyz * _glesNormal.y)
					  ) + (v_26.xyz * _glesNormal.z)));
					  mediump vec4 normal_28;
					  normal_28 = tmpvar_27;
					  mediump vec3 res_29;
					  mediump vec3 x_30;
					  x_30.x = dot (unity_SHAr, normal_28);
					  x_30.y = dot (unity_SHAg, normal_28);
					  x_30.z = dot (unity_SHAb, normal_28);
					  mediump vec3 x1_31;
					  mediump vec4 tmpvar_32;
					  tmpvar_32 = (normal_28.xyzz * normal_28.yzzx);
					  x1_31.x = dot (unity_SHBr, tmpvar_32);
					  x1_31.y = dot (unity_SHBg, tmpvar_32);
					  x1_31.z = dot (unity_SHBb, tmpvar_32);
					  res_29 = (x_30 + (x1_31 + (unity_SHC.xyz * 
					    ((normal_28.x * normal_28.x) - (normal_28.y * normal_28.y))
					  )));
					  res_29 = max (((1.055 * 
					    pow (max (res_29, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_4 = res_29;
					  gl_Position = tmpvar_19;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_COLOR0 = tmpvar_2;
					  xlv_TEXCOORD2 = o_21;
					  xlv_TEXCOORD3 = tmpvar_3;
					  xlv_TEXCOORD4 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _MainTex;
					uniform mediump float _Shininess;
					uniform lowp vec4 _Color;
					uniform sampler2D _LightBuffer;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 light_2;
					  lowp float tmpvar_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpvar_3 = _Shininess;
					  lowp float x_5;
					  x_5 = (tmpvar_4.w - _Cutoff);
					  if ((x_5 < 0.0)) {
					    discard;
					  };
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_2 = tmpvar_6;
					  mediump vec4 tmpvar_7;
					  tmpvar_7 = max (light_2, vec4(0.001, 0.001, 0.001, 0.001));
					  light_2.w = tmpvar_7.w;
					  light_2.xyz = (tmpvar_7.xyz + xlv_TEXCOORD4);
					  mediump vec4 tmpvar_8;
					  lowp vec4 c_9;
					  lowp float spec_10;
					  mediump float tmpvar_11;
					  tmpvar_11 = (tmpvar_7.w * tmpvar_3);
					  spec_10 = tmpvar_11;
					  c_9.xyz = (((tmpvar_4.xyz * _Color.xyz) * (xlv_COLOR0.xyz * light_2.xyz)) + ((light_2.xyz * _SpecColor.xyz) * spec_10));
					  c_9.w = (tmpvar_4.w + (spec_10 * _SpecColor.w));
					  tmpvar_8 = c_9;
					  tmpvar_1 = tmpvar_8;
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
					uniform highp vec4 _Time;
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
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = _glesColor;
					  highp vec4 tmpvar_3;
					  highp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = tmpvar_1.w;
					  highp float bendingFact_6;
					  highp vec4 wind_7;
					  lowp float tmpvar_8;
					  tmpvar_8 = tmpvar_2.w;
					  bendingFact_6 = tmpvar_8;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_WorldToObject[0].xyz;
					  tmpvar_9[1] = unity_WorldToObject[1].xyz;
					  tmpvar_9[2] = unity_WorldToObject[2].xyz;
					  wind_7.xyz = (tmpvar_9 * _Wind.xyz);
					  wind_7.w = (_Wind.w * bendingFact_6);
					  highp vec2 tmpvar_10;
					  tmpvar_10.y = 1.0;
					  tmpvar_10.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_11;
					  pos_11.w = tmpvar_1.w;
					  highp vec3 bend_12;
					  highp vec4 v_13;
					  v_13.x = unity_ObjectToWorld[0].w;
					  v_13.y = unity_ObjectToWorld[1].w;
					  v_13.z = unity_ObjectToWorld[2].w;
					  v_13.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_14;
					  tmpvar_14 = dot (v_13.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_15;
					  tmpvar_15.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_14)));
					  tmpvar_15.y = tmpvar_14;
					  highp vec4 tmpvar_16;
					  tmpvar_16 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_10).xx + tmpvar_15).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_17;
					  tmpvar_17 = ((tmpvar_16 * tmpvar_16) * (3.0 - (2.0 * tmpvar_16)));
					  highp vec2 tmpvar_18;
					  tmpvar_18 = (tmpvar_17.xz + tmpvar_17.yw);
					  bend_12.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_12.y = (bendingFact_6 * 0.3);
					  pos_11.xyz = (_glesVertex.xyz + ((
					    (tmpvar_18.xyx * bend_12)
					   + 
					    ((wind_7.xyz * tmpvar_18.y) * bendingFact_6)
					  ) * wind_7.w));
					  pos_11.xyz = (pos_11.xyz + (bendingFact_6 * wind_7.xyz));
					  tmpvar_5.xyz = pos_11.xyz;
					  highp vec4 tmpvar_19;
					  highp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = tmpvar_5.xyz;
					  tmpvar_19 = (glstate_matrix_mvp * tmpvar_20);
					  highp vec4 o_21;
					  highp vec4 tmpvar_22;
					  tmpvar_22 = (tmpvar_19 * 0.5);
					  highp vec2 tmpvar_23;
					  tmpvar_23.x = tmpvar_22.x;
					  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
					  o_21.xy = (tmpvar_23 + tmpvar_22.w);
					  o_21.zw = tmpvar_19.zw;
					  tmpvar_3.zw = vec2(0.0, 0.0);
					  tmpvar_3.xy = vec2(0.0, 0.0);
					  highp vec4 v_24;
					  v_24.x = unity_WorldToObject[0].x;
					  v_24.y = unity_WorldToObject[1].x;
					  v_24.z = unity_WorldToObject[2].x;
					  v_24.w = unity_WorldToObject[3].x;
					  highp vec4 v_25;
					  v_25.x = unity_WorldToObject[0].y;
					  v_25.y = unity_WorldToObject[1].y;
					  v_25.z = unity_WorldToObject[2].y;
					  v_25.w = unity_WorldToObject[3].y;
					  highp vec4 v_26;
					  v_26.x = unity_WorldToObject[0].z;
					  v_26.y = unity_WorldToObject[1].z;
					  v_26.z = unity_WorldToObject[2].z;
					  v_26.w = unity_WorldToObject[3].z;
					  highp vec4 tmpvar_27;
					  tmpvar_27.w = 1.0;
					  tmpvar_27.xyz = normalize(((
					    (v_24.xyz * _glesNormal.x)
					   + 
					    (v_25.xyz * _glesNormal.y)
					  ) + (v_26.xyz * _glesNormal.z)));
					  mediump vec4 normal_28;
					  normal_28 = tmpvar_27;
					  mediump vec3 res_29;
					  mediump vec3 x_30;
					  x_30.x = dot (unity_SHAr, normal_28);
					  x_30.y = dot (unity_SHAg, normal_28);
					  x_30.z = dot (unity_SHAb, normal_28);
					  mediump vec3 x1_31;
					  mediump vec4 tmpvar_32;
					  tmpvar_32 = (normal_28.xyzz * normal_28.yzzx);
					  x1_31.x = dot (unity_SHBr, tmpvar_32);
					  x1_31.y = dot (unity_SHBg, tmpvar_32);
					  x1_31.z = dot (unity_SHBb, tmpvar_32);
					  res_29 = (x_30 + (x1_31 + (unity_SHC.xyz * 
					    ((normal_28.x * normal_28.x) - (normal_28.y * normal_28.y))
					  )));
					  res_29 = max (((1.055 * 
					    pow (max (res_29, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_4 = res_29;
					  gl_Position = tmpvar_19;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_COLOR0 = tmpvar_2;
					  xlv_TEXCOORD2 = o_21;
					  xlv_TEXCOORD3 = tmpvar_3;
					  xlv_TEXCOORD4 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _MainTex;
					uniform mediump float _Shininess;
					uniform lowp vec4 _Color;
					uniform sampler2D _LightBuffer;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 light_2;
					  lowp float tmpvar_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpvar_3 = _Shininess;
					  lowp float x_5;
					  x_5 = (tmpvar_4.w - _Cutoff);
					  if ((x_5 < 0.0)) {
					    discard;
					  };
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
					  light_2 = tmpvar_6;
					  mediump vec4 tmpvar_7;
					  tmpvar_7 = max (light_2, vec4(0.001, 0.001, 0.001, 0.001));
					  light_2.w = tmpvar_7.w;
					  light_2.xyz = (tmpvar_7.xyz + xlv_TEXCOORD4);
					  mediump vec4 tmpvar_8;
					  lowp vec4 c_9;
					  lowp float spec_10;
					  mediump float tmpvar_11;
					  tmpvar_11 = (tmpvar_7.w * tmpvar_3);
					  spec_10 = tmpvar_11;
					  c_9.xyz = (((tmpvar_4.xyz * _Color.xyz) * (xlv_COLOR0.xyz * light_2.xyz)) + ((light_2.xyz * _SpecColor.xyz) * spec_10));
					  c_9.w = (tmpvar_4.w + (spec_10 * _SpecColor.w));
					  tmpvar_8 = c_9;
					  tmpvar_1 = tmpvar_8;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif
}
}
Program "fp" {
// Platform gles3 skipped due to earlier errors
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					
}
SubProgram "gles hw_tier03 " {
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
}
 }
 Pass {
  Name "SHADOWCASTER"
  Tags { "LIGHTMODE"="SHADOWCASTER" "IGNOREPROJECTOR"="true" "SHADOWSUPPORT"="true" "RenderType"="TreeLeaf" }
  Cull Off
  GpuProgramID 262339
Program "vp" {
// Platform gles3 skipped due to earlier errors
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
					
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform highp vec4 unity_LightShadowBias;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  highp vec2 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = tmpvar_1.w;
					  highp float bendingFact_4;
					  highp vec4 wind_5;
					  lowp float tmpvar_6;
					  tmpvar_6 = _glesColor.w;
					  bendingFact_4 = tmpvar_6;
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = unity_WorldToObject[0].xyz;
					  tmpvar_7[1] = unity_WorldToObject[1].xyz;
					  tmpvar_7[2] = unity_WorldToObject[2].xyz;
					  wind_5.xyz = (tmpvar_7 * _Wind.xyz);
					  wind_5.w = (_Wind.w * bendingFact_4);
					  highp vec2 tmpvar_8;
					  tmpvar_8.y = 1.0;
					  tmpvar_8.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_9;
					  pos_9.w = tmpvar_1.w;
					  highp vec3 bend_10;
					  highp vec4 v_11;
					  v_11.x = unity_ObjectToWorld[0].w;
					  v_11.y = unity_ObjectToWorld[1].w;
					  v_11.z = unity_ObjectToWorld[2].w;
					  v_11.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_12;
					  tmpvar_12 = dot (v_11.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_13;
					  tmpvar_13.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_12)));
					  tmpvar_13.y = tmpvar_12;
					  highp vec4 tmpvar_14;
					  tmpvar_14 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_8).xx + tmpvar_13).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_15;
					  tmpvar_15 = ((tmpvar_14 * tmpvar_14) * (3.0 - (2.0 * tmpvar_14)));
					  highp vec2 tmpvar_16;
					  tmpvar_16 = (tmpvar_15.xz + tmpvar_15.yw);
					  bend_10.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_10.y = (bendingFact_4 * 0.3);
					  pos_9.xyz = (_glesVertex.xyz + ((
					    (tmpvar_16.xyx * bend_10)
					   + 
					    ((wind_5.xyz * tmpvar_16.y) * bendingFact_4)
					  ) * wind_5.w));
					  pos_9.xyz = (pos_9.xyz + (bendingFact_4 * wind_5.xyz));
					  tmpvar_3.xyz = pos_9.xyz;
					  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  highp vec3 vertex_17;
					  vertex_17 = tmpvar_3.xyz;
					  highp vec4 clipPos_18;
					  if ((unity_LightShadowBias.z != 0.0)) {
					    highp vec4 tmpvar_19;
					    tmpvar_19.w = 1.0;
					    tmpvar_19.xyz = vertex_17;
					    highp vec3 tmpvar_20;
					    tmpvar_20 = (unity_ObjectToWorld * tmpvar_19).xyz;
					    highp vec4 v_21;
					    v_21.x = unity_WorldToObject[0].x;
					    v_21.y = unity_WorldToObject[1].x;
					    v_21.z = unity_WorldToObject[2].x;
					    v_21.w = unity_WorldToObject[3].x;
					    highp vec4 v_22;
					    v_22.x = unity_WorldToObject[0].y;
					    v_22.y = unity_WorldToObject[1].y;
					    v_22.z = unity_WorldToObject[2].y;
					    v_22.w = unity_WorldToObject[3].y;
					    highp vec4 v_23;
					    v_23.x = unity_WorldToObject[0].z;
					    v_23.y = unity_WorldToObject[1].z;
					    v_23.z = unity_WorldToObject[2].z;
					    v_23.w = unity_WorldToObject[3].z;
					    highp vec3 tmpvar_24;
					    tmpvar_24 = normalize(((
					      (v_21.xyz * _glesNormal.x)
					     + 
					      (v_22.xyz * _glesNormal.y)
					    ) + (v_23.xyz * _glesNormal.z)));
					    highp float tmpvar_25;
					    tmpvar_25 = dot (tmpvar_24, normalize((_WorldSpaceLightPos0.xyz - 
					      (tmpvar_20 * _WorldSpaceLightPos0.w)
					    )));
					    highp vec4 tmpvar_26;
					    tmpvar_26.w = 1.0;
					    tmpvar_26.xyz = (tmpvar_20 - (tmpvar_24 * (unity_LightShadowBias.z * 
					      sqrt((1.0 - (tmpvar_25 * tmpvar_25)))
					    )));
					    clipPos_18 = (unity_MatrixVP * tmpvar_26);
					  } else {
					    highp vec4 tmpvar_27;
					    tmpvar_27.w = 1.0;
					    tmpvar_27.xyz = vertex_17;
					    clipPos_18 = (glstate_matrix_mvp * tmpvar_27);
					  };
					  highp vec4 clipPos_28;
					  clipPos_28.xyw = clipPos_18.xyw;
					  clipPos_28.z = (clipPos_18.z + clamp ((unity_LightShadowBias.x / clipPos_18.w), 0.0, 1.0));
					  clipPos_28.z = mix (clipPos_28.z, max (clipPos_28.z, -(clipPos_18.w)), unity_LightShadowBias.y);
					  gl_Position = clipPos_28;
					  xlv_TEXCOORD1 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD1;
					void main ()
					{
					  lowp float x_1;
					  x_1 = (texture2D (_MainTex, xlv_TEXCOORD1).w - _Cutoff);
					  if ((x_1 < 0.0)) {
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
					uniform highp vec4 _Time;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform highp vec4 unity_LightShadowBias;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  highp vec2 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = tmpvar_1.w;
					  highp float bendingFact_4;
					  highp vec4 wind_5;
					  lowp float tmpvar_6;
					  tmpvar_6 = _glesColor.w;
					  bendingFact_4 = tmpvar_6;
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = unity_WorldToObject[0].xyz;
					  tmpvar_7[1] = unity_WorldToObject[1].xyz;
					  tmpvar_7[2] = unity_WorldToObject[2].xyz;
					  wind_5.xyz = (tmpvar_7 * _Wind.xyz);
					  wind_5.w = (_Wind.w * bendingFact_4);
					  highp vec2 tmpvar_8;
					  tmpvar_8.y = 1.0;
					  tmpvar_8.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_9;
					  pos_9.w = tmpvar_1.w;
					  highp vec3 bend_10;
					  highp vec4 v_11;
					  v_11.x = unity_ObjectToWorld[0].w;
					  v_11.y = unity_ObjectToWorld[1].w;
					  v_11.z = unity_ObjectToWorld[2].w;
					  v_11.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_12;
					  tmpvar_12 = dot (v_11.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_13;
					  tmpvar_13.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_12)));
					  tmpvar_13.y = tmpvar_12;
					  highp vec4 tmpvar_14;
					  tmpvar_14 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_8).xx + tmpvar_13).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_15;
					  tmpvar_15 = ((tmpvar_14 * tmpvar_14) * (3.0 - (2.0 * tmpvar_14)));
					  highp vec2 tmpvar_16;
					  tmpvar_16 = (tmpvar_15.xz + tmpvar_15.yw);
					  bend_10.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_10.y = (bendingFact_4 * 0.3);
					  pos_9.xyz = (_glesVertex.xyz + ((
					    (tmpvar_16.xyx * bend_10)
					   + 
					    ((wind_5.xyz * tmpvar_16.y) * bendingFact_4)
					  ) * wind_5.w));
					  pos_9.xyz = (pos_9.xyz + (bendingFact_4 * wind_5.xyz));
					  tmpvar_3.xyz = pos_9.xyz;
					  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  highp vec3 vertex_17;
					  vertex_17 = tmpvar_3.xyz;
					  highp vec4 clipPos_18;
					  if ((unity_LightShadowBias.z != 0.0)) {
					    highp vec4 tmpvar_19;
					    tmpvar_19.w = 1.0;
					    tmpvar_19.xyz = vertex_17;
					    highp vec3 tmpvar_20;
					    tmpvar_20 = (unity_ObjectToWorld * tmpvar_19).xyz;
					    highp vec4 v_21;
					    v_21.x = unity_WorldToObject[0].x;
					    v_21.y = unity_WorldToObject[1].x;
					    v_21.z = unity_WorldToObject[2].x;
					    v_21.w = unity_WorldToObject[3].x;
					    highp vec4 v_22;
					    v_22.x = unity_WorldToObject[0].y;
					    v_22.y = unity_WorldToObject[1].y;
					    v_22.z = unity_WorldToObject[2].y;
					    v_22.w = unity_WorldToObject[3].y;
					    highp vec4 v_23;
					    v_23.x = unity_WorldToObject[0].z;
					    v_23.y = unity_WorldToObject[1].z;
					    v_23.z = unity_WorldToObject[2].z;
					    v_23.w = unity_WorldToObject[3].z;
					    highp vec3 tmpvar_24;
					    tmpvar_24 = normalize(((
					      (v_21.xyz * _glesNormal.x)
					     + 
					      (v_22.xyz * _glesNormal.y)
					    ) + (v_23.xyz * _glesNormal.z)));
					    highp float tmpvar_25;
					    tmpvar_25 = dot (tmpvar_24, normalize((_WorldSpaceLightPos0.xyz - 
					      (tmpvar_20 * _WorldSpaceLightPos0.w)
					    )));
					    highp vec4 tmpvar_26;
					    tmpvar_26.w = 1.0;
					    tmpvar_26.xyz = (tmpvar_20 - (tmpvar_24 * (unity_LightShadowBias.z * 
					      sqrt((1.0 - (tmpvar_25 * tmpvar_25)))
					    )));
					    clipPos_18 = (unity_MatrixVP * tmpvar_26);
					  } else {
					    highp vec4 tmpvar_27;
					    tmpvar_27.w = 1.0;
					    tmpvar_27.xyz = vertex_17;
					    clipPos_18 = (glstate_matrix_mvp * tmpvar_27);
					  };
					  highp vec4 clipPos_28;
					  clipPos_28.xyw = clipPos_18.xyw;
					  clipPos_28.z = (clipPos_18.z + clamp ((unity_LightShadowBias.x / clipPos_18.w), 0.0, 1.0));
					  clipPos_28.z = mix (clipPos_28.z, max (clipPos_28.z, -(clipPos_18.w)), unity_LightShadowBias.y);
					  gl_Position = clipPos_28;
					  xlv_TEXCOORD1 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD1;
					void main ()
					{
					  lowp float x_1;
					  x_1 = (texture2D (_MainTex, xlv_TEXCOORD1).w - _Cutoff);
					  if ((x_1 < 0.0)) {
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
					uniform highp vec4 _Time;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform highp vec4 unity_LightShadowBias;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  highp vec2 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = tmpvar_1.w;
					  highp float bendingFact_4;
					  highp vec4 wind_5;
					  lowp float tmpvar_6;
					  tmpvar_6 = _glesColor.w;
					  bendingFact_4 = tmpvar_6;
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = unity_WorldToObject[0].xyz;
					  tmpvar_7[1] = unity_WorldToObject[1].xyz;
					  tmpvar_7[2] = unity_WorldToObject[2].xyz;
					  wind_5.xyz = (tmpvar_7 * _Wind.xyz);
					  wind_5.w = (_Wind.w * bendingFact_4);
					  highp vec2 tmpvar_8;
					  tmpvar_8.y = 1.0;
					  tmpvar_8.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_9;
					  pos_9.w = tmpvar_1.w;
					  highp vec3 bend_10;
					  highp vec4 v_11;
					  v_11.x = unity_ObjectToWorld[0].w;
					  v_11.y = unity_ObjectToWorld[1].w;
					  v_11.z = unity_ObjectToWorld[2].w;
					  v_11.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_12;
					  tmpvar_12 = dot (v_11.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_13;
					  tmpvar_13.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_12)));
					  tmpvar_13.y = tmpvar_12;
					  highp vec4 tmpvar_14;
					  tmpvar_14 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_8).xx + tmpvar_13).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_15;
					  tmpvar_15 = ((tmpvar_14 * tmpvar_14) * (3.0 - (2.0 * tmpvar_14)));
					  highp vec2 tmpvar_16;
					  tmpvar_16 = (tmpvar_15.xz + tmpvar_15.yw);
					  bend_10.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_10.y = (bendingFact_4 * 0.3);
					  pos_9.xyz = (_glesVertex.xyz + ((
					    (tmpvar_16.xyx * bend_10)
					   + 
					    ((wind_5.xyz * tmpvar_16.y) * bendingFact_4)
					  ) * wind_5.w));
					  pos_9.xyz = (pos_9.xyz + (bendingFact_4 * wind_5.xyz));
					  tmpvar_3.xyz = pos_9.xyz;
					  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  highp vec3 vertex_17;
					  vertex_17 = tmpvar_3.xyz;
					  highp vec4 clipPos_18;
					  if ((unity_LightShadowBias.z != 0.0)) {
					    highp vec4 tmpvar_19;
					    tmpvar_19.w = 1.0;
					    tmpvar_19.xyz = vertex_17;
					    highp vec3 tmpvar_20;
					    tmpvar_20 = (unity_ObjectToWorld * tmpvar_19).xyz;
					    highp vec4 v_21;
					    v_21.x = unity_WorldToObject[0].x;
					    v_21.y = unity_WorldToObject[1].x;
					    v_21.z = unity_WorldToObject[2].x;
					    v_21.w = unity_WorldToObject[3].x;
					    highp vec4 v_22;
					    v_22.x = unity_WorldToObject[0].y;
					    v_22.y = unity_WorldToObject[1].y;
					    v_22.z = unity_WorldToObject[2].y;
					    v_22.w = unity_WorldToObject[3].y;
					    highp vec4 v_23;
					    v_23.x = unity_WorldToObject[0].z;
					    v_23.y = unity_WorldToObject[1].z;
					    v_23.z = unity_WorldToObject[2].z;
					    v_23.w = unity_WorldToObject[3].z;
					    highp vec3 tmpvar_24;
					    tmpvar_24 = normalize(((
					      (v_21.xyz * _glesNormal.x)
					     + 
					      (v_22.xyz * _glesNormal.y)
					    ) + (v_23.xyz * _glesNormal.z)));
					    highp float tmpvar_25;
					    tmpvar_25 = dot (tmpvar_24, normalize((_WorldSpaceLightPos0.xyz - 
					      (tmpvar_20 * _WorldSpaceLightPos0.w)
					    )));
					    highp vec4 tmpvar_26;
					    tmpvar_26.w = 1.0;
					    tmpvar_26.xyz = (tmpvar_20 - (tmpvar_24 * (unity_LightShadowBias.z * 
					      sqrt((1.0 - (tmpvar_25 * tmpvar_25)))
					    )));
					    clipPos_18 = (unity_MatrixVP * tmpvar_26);
					  } else {
					    highp vec4 tmpvar_27;
					    tmpvar_27.w = 1.0;
					    tmpvar_27.xyz = vertex_17;
					    clipPos_18 = (glstate_matrix_mvp * tmpvar_27);
					  };
					  highp vec4 clipPos_28;
					  clipPos_28.xyw = clipPos_18.xyw;
					  clipPos_28.z = (clipPos_18.z + clamp ((unity_LightShadowBias.x / clipPos_18.w), 0.0, 1.0));
					  clipPos_28.z = mix (clipPos_28.z, max (clipPos_28.z, -(clipPos_18.w)), unity_LightShadowBias.y);
					  gl_Position = clipPos_28;
					  xlv_TEXCOORD1 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD1;
					void main ()
					{
					  lowp float x_1;
					  x_1 = (texture2D (_MainTex, xlv_TEXCOORD1).w - _Cutoff);
					  if ((x_1 < 0.0)) {
					    discard;
					  };
					  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp vec4 _LightPositionRange;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec3 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = tmpvar_1.w;
					  highp float bendingFact_3;
					  highp vec4 wind_4;
					  lowp float tmpvar_5;
					  tmpvar_5 = _glesColor.w;
					  bendingFact_3 = tmpvar_5;
					  highp mat3 tmpvar_6;
					  tmpvar_6[0] = unity_WorldToObject[0].xyz;
					  tmpvar_6[1] = unity_WorldToObject[1].xyz;
					  tmpvar_6[2] = unity_WorldToObject[2].xyz;
					  wind_4.xyz = (tmpvar_6 * _Wind.xyz);
					  wind_4.w = (_Wind.w * bendingFact_3);
					  highp vec2 tmpvar_7;
					  tmpvar_7.y = 1.0;
					  tmpvar_7.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_8;
					  pos_8.w = tmpvar_1.w;
					  highp vec3 bend_9;
					  highp vec4 v_10;
					  v_10.x = unity_ObjectToWorld[0].w;
					  v_10.y = unity_ObjectToWorld[1].w;
					  v_10.z = unity_ObjectToWorld[2].w;
					  v_10.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_11;
					  tmpvar_11 = dot (v_10.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_12;
					  tmpvar_12.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_11)));
					  tmpvar_12.y = tmpvar_11;
					  highp vec4 tmpvar_13;
					  tmpvar_13 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_7).xx + tmpvar_12).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_14;
					  tmpvar_14 = ((tmpvar_13 * tmpvar_13) * (3.0 - (2.0 * tmpvar_13)));
					  highp vec2 tmpvar_15;
					  tmpvar_15 = (tmpvar_14.xz + tmpvar_14.yw);
					  bend_9.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_9.y = (bendingFact_3 * 0.3);
					  pos_8.xyz = (_glesVertex.xyz + ((
					    (tmpvar_15.xyx * bend_9)
					   + 
					    ((wind_4.xyz * tmpvar_15.y) * bendingFact_3)
					  ) * wind_4.w));
					  pos_8.xyz = (pos_8.xyz + (bendingFact_3 * wind_4.xyz));
					  tmpvar_2.xyz = pos_8.xyz;
					  highp vec4 tmpvar_16;
					  tmpvar_16.w = 1.0;
					  tmpvar_16.xyz = tmpvar_2.xyz;
					  xlv_TEXCOORD0 = ((unity_ObjectToWorld * tmpvar_2).xyz - _LightPositionRange.xyz);
					  gl_Position = (glstate_matrix_mvp * tmpvar_16);
					  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _LightPositionRange;
					uniform highp vec4 unity_LightShadowBias;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec3 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  lowp float x_2;
					  x_2 = (texture2D (_MainTex, xlv_TEXCOORD1).w - _Cutoff);
					  if ((x_2 < 0.0)) {
					    discard;
					  };
					  highp vec4 enc_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
					    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
					  , 0.999)));
					  enc_3 = (tmpvar_4 - (tmpvar_4.yzww * 0.003921569));
					  tmpvar_1 = enc_3;
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
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp vec4 _LightPositionRange;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec3 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = tmpvar_1.w;
					  highp float bendingFact_3;
					  highp vec4 wind_4;
					  lowp float tmpvar_5;
					  tmpvar_5 = _glesColor.w;
					  bendingFact_3 = tmpvar_5;
					  highp mat3 tmpvar_6;
					  tmpvar_6[0] = unity_WorldToObject[0].xyz;
					  tmpvar_6[1] = unity_WorldToObject[1].xyz;
					  tmpvar_6[2] = unity_WorldToObject[2].xyz;
					  wind_4.xyz = (tmpvar_6 * _Wind.xyz);
					  wind_4.w = (_Wind.w * bendingFact_3);
					  highp vec2 tmpvar_7;
					  tmpvar_7.y = 1.0;
					  tmpvar_7.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_8;
					  pos_8.w = tmpvar_1.w;
					  highp vec3 bend_9;
					  highp vec4 v_10;
					  v_10.x = unity_ObjectToWorld[0].w;
					  v_10.y = unity_ObjectToWorld[1].w;
					  v_10.z = unity_ObjectToWorld[2].w;
					  v_10.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_11;
					  tmpvar_11 = dot (v_10.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_12;
					  tmpvar_12.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_11)));
					  tmpvar_12.y = tmpvar_11;
					  highp vec4 tmpvar_13;
					  tmpvar_13 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_7).xx + tmpvar_12).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_14;
					  tmpvar_14 = ((tmpvar_13 * tmpvar_13) * (3.0 - (2.0 * tmpvar_13)));
					  highp vec2 tmpvar_15;
					  tmpvar_15 = (tmpvar_14.xz + tmpvar_14.yw);
					  bend_9.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_9.y = (bendingFact_3 * 0.3);
					  pos_8.xyz = (_glesVertex.xyz + ((
					    (tmpvar_15.xyx * bend_9)
					   + 
					    ((wind_4.xyz * tmpvar_15.y) * bendingFact_3)
					  ) * wind_4.w));
					  pos_8.xyz = (pos_8.xyz + (bendingFact_3 * wind_4.xyz));
					  tmpvar_2.xyz = pos_8.xyz;
					  highp vec4 tmpvar_16;
					  tmpvar_16.w = 1.0;
					  tmpvar_16.xyz = tmpvar_2.xyz;
					  xlv_TEXCOORD0 = ((unity_ObjectToWorld * tmpvar_2).xyz - _LightPositionRange.xyz);
					  gl_Position = (glstate_matrix_mvp * tmpvar_16);
					  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _LightPositionRange;
					uniform highp vec4 unity_LightShadowBias;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec3 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  lowp float x_2;
					  x_2 = (texture2D (_MainTex, xlv_TEXCOORD1).w - _Cutoff);
					  if ((x_2 < 0.0)) {
					    discard;
					  };
					  highp vec4 enc_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
					    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
					  , 0.999)));
					  enc_3 = (tmpvar_4 - (tmpvar_4.yzww * 0.003921569));
					  tmpvar_1 = enc_3;
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
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp vec4 _LightPositionRange;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _Wind;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindEdgeFlutterFreqScale;
					uniform highp vec4 _MainTex_ST;
					varying highp vec3 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = tmpvar_1.w;
					  highp float bendingFact_3;
					  highp vec4 wind_4;
					  lowp float tmpvar_5;
					  tmpvar_5 = _glesColor.w;
					  bendingFact_3 = tmpvar_5;
					  highp mat3 tmpvar_6;
					  tmpvar_6[0] = unity_WorldToObject[0].xyz;
					  tmpvar_6[1] = unity_WorldToObject[1].xyz;
					  tmpvar_6[2] = unity_WorldToObject[2].xyz;
					  wind_4.xyz = (tmpvar_6 * _Wind.xyz);
					  wind_4.w = (_Wind.w * bendingFact_3);
					  highp vec2 tmpvar_7;
					  tmpvar_7.y = 1.0;
					  tmpvar_7.x = _WindEdgeFlutterFreqScale;
					  highp vec4 pos_8;
					  pos_8.w = tmpvar_1.w;
					  highp vec3 bend_9;
					  highp vec4 v_10;
					  v_10.x = unity_ObjectToWorld[0].w;
					  v_10.y = unity_ObjectToWorld[1].w;
					  v_10.z = unity_ObjectToWorld[2].w;
					  v_10.w = unity_ObjectToWorld[3].w;
					  highp float tmpvar_11;
					  tmpvar_11 = dot (v_10.xyz, vec3(1.0, 1.0, 1.0));
					  highp vec2 tmpvar_12;
					  tmpvar_12.x = dot (_glesVertex.xyz, vec3((_WindEdgeFlutter + tmpvar_11)));
					  tmpvar_12.y = tmpvar_11;
					  highp vec4 tmpvar_13;
					  tmpvar_13 = abs(((
					    fract((((
					      fract((((_Time.y * tmpvar_7).xx + tmpvar_12).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_14;
					  tmpvar_14 = ((tmpvar_13 * tmpvar_13) * (3.0 - (2.0 * tmpvar_13)));
					  highp vec2 tmpvar_15;
					  tmpvar_15 = (tmpvar_14.xz + tmpvar_14.yw);
					  bend_9.xz = ((_WindEdgeFlutter * 0.1) * _glesNormal).xz;
					  bend_9.y = (bendingFact_3 * 0.3);
					  pos_8.xyz = (_glesVertex.xyz + ((
					    (tmpvar_15.xyx * bend_9)
					   + 
					    ((wind_4.xyz * tmpvar_15.y) * bendingFact_3)
					  ) * wind_4.w));
					  pos_8.xyz = (pos_8.xyz + (bendingFact_3 * wind_4.xyz));
					  tmpvar_2.xyz = pos_8.xyz;
					  highp vec4 tmpvar_16;
					  tmpvar_16.w = 1.0;
					  tmpvar_16.xyz = tmpvar_2.xyz;
					  xlv_TEXCOORD0 = ((unity_ObjectToWorld * tmpvar_2).xyz - _LightPositionRange.xyz);
					  gl_Position = (glstate_matrix_mvp * tmpvar_16);
					  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _LightPositionRange;
					uniform highp vec4 unity_LightShadowBias;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec3 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  lowp float x_2;
					  x_2 = (texture2D (_MainTex, xlv_TEXCOORD1).w - _Cutoff);
					  if ((x_2 < 0.0)) {
					    discard;
					  };
					  highp vec4 enc_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
					    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
					  , 0.999)));
					  enc_3 = (tmpvar_4 - (tmpvar_4.yzww * 0.003921569));
					  tmpvar_1 = enc_3;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif
}
}
Program "fp" {
// Platform gles3 skipped due to earlier errors
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
					
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
					
}
SubProgram "gles hw_tier03 " {
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
}
 }
}
Fallback "Transparent/Cutout/Diffuse"
}