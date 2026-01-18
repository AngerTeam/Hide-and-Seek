Shader "kaleb/Rainbow-Transparent" {
Properties {
 _MainTex ("Main Texture", 2D) = "white" { }
 _CutOff ("Cut off", Range(0.000000,1.000000)) = 0.800000
 _Scale ("Scale", Float) = 100.000000
 _Saturation ("Saturation", Range(0.000000,1.000000)) = 0.800000
 _value ("Value", Range(0.000000,1.000000)) = 0.800000
}
SubShader { 
 LOD 100
 Tags { "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }
 Pass {
  Tags { "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }
  Blend SrcAlpha OneMinusSrcAlpha
  GpuProgramID 51380
Program "vp" {
SubProgram "gles hw_tier01 " {

					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = _glesVertex;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp float _CutOff;
					uniform highp float _Scale;
					uniform highp float _Saturation;
					uniform highp float _value;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 xlat_varmod_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  xlat_varmod_1 = tmpvar_2;
					  if ((xlat_varmod_1.w < _CutOff)) {
					    discard;
					  };
					  highp int tmpvar_3;
					  tmpvar_3 = int(max (0.0, sign(xlat_varmod_1.w)));
					  if (bool(tmpvar_3)) {
					    highp float _Hue_4;
					    highp vec4 ver_5;
					    ver_5.yzw = xlv_TEXCOORD1.yzw;
					    highp float tmpvar_6;
					    tmpvar_6 = (_Time.y * 0.1);
					    ver_5.x = ((xlv_TEXCOORD1.x + sin(xlv_TEXCOORD1.y)) + cos((xlv_TEXCOORD1.z + tmpvar_6)));
					    ver_5.y = ((xlv_TEXCOORD1.y + sin(xlv_TEXCOORD1.z)) + cos((ver_5.x + tmpvar_6)));
					    ver_5.z = ((xlv_TEXCOORD1.z + sin(ver_5.x)) + cos((ver_5.y + tmpvar_6)));
					    _Hue_4 = sin((_Time.x + (ver_5.x / _Scale)));
					    _Hue_4 = (_Hue_4 + sin((_Time.z + 
					      (ver_5.x / _Scale)
					    )));
					    _Hue_4 = (_Hue_4 + cos((_Time.y + 
					      (ver_5.y / _Scale)
					    )));
					    _Hue_4 = (_Hue_4 + cos((_Time.x + 
					      (ver_5.y / _Scale)
					    )));
					    _Hue_4 = (_Hue_4 + sin((_Time.y + 
					      (ver_5.z / _Scale)
					    )));
					    _Hue_4 = (_Hue_4 + sin((_Time.z + 
					      (ver_5.z / _Scale)
					    )));
					    _Hue_4 += 6.0;
					    _Hue_4 = (_Hue_4 / 12.0);
					    _Hue_4 = (_Hue_4 / 4.0);
					    highp vec3 tmpvar_7;
					    tmpvar_7.x = _Hue_4;
					    tmpvar_7.y = _Saturation;
					    tmpvar_7.z = _value;
					    highp vec3 RGB_8;
					    RGB_8 = tmpvar_7.zzz;
					    highp float tmpvar_9;
					    tmpvar_9 = (_Hue_4 * 6.0);
					    highp float tmpvar_10;
					    tmpvar_10 = floor(tmpvar_9);
					    highp float tmpvar_11;
					    tmpvar_11 = (_value * (1.0 - _Saturation));
					    highp float tmpvar_12;
					    tmpvar_12 = (_value * (1.0 - (_Saturation * 
					      (tmpvar_9 - tmpvar_10)
					    )));
					    highp float tmpvar_13;
					    tmpvar_13 = (_value * (1.0 - (_Saturation * 
					      (1.0 - (tmpvar_9 - tmpvar_10))
					    )));
					    if ((tmpvar_10 == 0.0)) {
					      highp vec3 tmpvar_14;
					      tmpvar_14.x = tmpvar_7.z;
					      tmpvar_14.y = tmpvar_13;
					      tmpvar_14.z = tmpvar_11;
					      RGB_8 = tmpvar_14;
					    } else {
					      if ((tmpvar_10 == 1.0)) {
					        highp vec3 tmpvar_15;
					        tmpvar_15.x = tmpvar_12;
					        tmpvar_15.y = tmpvar_7.z;
					        tmpvar_15.z = tmpvar_11;
					        RGB_8 = tmpvar_15;
					      } else {
					        if ((tmpvar_10 == 2.0)) {
					          highp vec3 tmpvar_16;
					          tmpvar_16.x = tmpvar_11;
					          tmpvar_16.y = tmpvar_7.z;
					          tmpvar_16.z = tmpvar_13;
					          RGB_8 = tmpvar_16;
					        } else {
					          if ((tmpvar_10 == 3.0)) {
					            highp vec3 tmpvar_17;
					            tmpvar_17.x = tmpvar_11;
					            tmpvar_17.y = tmpvar_12;
					            tmpvar_17.z = tmpvar_7.z;
					            RGB_8 = tmpvar_17;
					          } else {
					            if ((tmpvar_10 == 4.0)) {
					              highp vec3 tmpvar_18;
					              tmpvar_18.x = tmpvar_13;
					              tmpvar_18.y = tmpvar_11;
					              tmpvar_18.z = tmpvar_7.z;
					              RGB_8 = tmpvar_18;
					            } else {
					              highp vec3 tmpvar_19;
					              tmpvar_19.x = tmpvar_7.z;
					              tmpvar_19.y = tmpvar_11;
					              tmpvar_19.z = tmpvar_12;
					              RGB_8 = tmpvar_19;
					            };
					          };
					        };
					      };
					    };
					    xlat_varmod_1.xyz = RGB_8;
					  };
					  gl_FragData[0] = xlat_varmod_1;
					}
					
					
					#endif
}
SubProgram "gles hw_tier02 " {

					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = _glesVertex;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp float _CutOff;
					uniform highp float _Scale;
					uniform highp float _Saturation;
					uniform highp float _value;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 xlat_varmod_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  xlat_varmod_1 = tmpvar_2;
					  if ((xlat_varmod_1.w < _CutOff)) {
					    discard;
					  };
					  highp int tmpvar_3;
					  tmpvar_3 = int(max (0.0, sign(xlat_varmod_1.w)));
					  if (bool(tmpvar_3)) {
					    highp float _Hue_4;
					    highp vec4 ver_5;
					    ver_5.yzw = xlv_TEXCOORD1.yzw;
					    highp float tmpvar_6;
					    tmpvar_6 = (_Time.y * 0.1);
					    ver_5.x = ((xlv_TEXCOORD1.x + sin(xlv_TEXCOORD1.y)) + cos((xlv_TEXCOORD1.z + tmpvar_6)));
					    ver_5.y = ((xlv_TEXCOORD1.y + sin(xlv_TEXCOORD1.z)) + cos((ver_5.x + tmpvar_6)));
					    ver_5.z = ((xlv_TEXCOORD1.z + sin(ver_5.x)) + cos((ver_5.y + tmpvar_6)));
					    _Hue_4 = sin((_Time.x + (ver_5.x / _Scale)));
					    _Hue_4 = (_Hue_4 + sin((_Time.z + 
					      (ver_5.x / _Scale)
					    )));
					    _Hue_4 = (_Hue_4 + cos((_Time.y + 
					      (ver_5.y / _Scale)
					    )));
					    _Hue_4 = (_Hue_4 + cos((_Time.x + 
					      (ver_5.y / _Scale)
					    )));
					    _Hue_4 = (_Hue_4 + sin((_Time.y + 
					      (ver_5.z / _Scale)
					    )));
					    _Hue_4 = (_Hue_4 + sin((_Time.z + 
					      (ver_5.z / _Scale)
					    )));
					    _Hue_4 += 6.0;
					    _Hue_4 = (_Hue_4 / 12.0);
					    _Hue_4 = (_Hue_4 / 4.0);
					    highp vec3 tmpvar_7;
					    tmpvar_7.x = _Hue_4;
					    tmpvar_7.y = _Saturation;
					    tmpvar_7.z = _value;
					    highp vec3 RGB_8;
					    RGB_8 = tmpvar_7.zzz;
					    highp float tmpvar_9;
					    tmpvar_9 = (_Hue_4 * 6.0);
					    highp float tmpvar_10;
					    tmpvar_10 = floor(tmpvar_9);
					    highp float tmpvar_11;
					    tmpvar_11 = (_value * (1.0 - _Saturation));
					    highp float tmpvar_12;
					    tmpvar_12 = (_value * (1.0 - (_Saturation * 
					      (tmpvar_9 - tmpvar_10)
					    )));
					    highp float tmpvar_13;
					    tmpvar_13 = (_value * (1.0 - (_Saturation * 
					      (1.0 - (tmpvar_9 - tmpvar_10))
					    )));
					    if ((tmpvar_10 == 0.0)) {
					      highp vec3 tmpvar_14;
					      tmpvar_14.x = tmpvar_7.z;
					      tmpvar_14.y = tmpvar_13;
					      tmpvar_14.z = tmpvar_11;
					      RGB_8 = tmpvar_14;
					    } else {
					      if ((tmpvar_10 == 1.0)) {
					        highp vec3 tmpvar_15;
					        tmpvar_15.x = tmpvar_12;
					        tmpvar_15.y = tmpvar_7.z;
					        tmpvar_15.z = tmpvar_11;
					        RGB_8 = tmpvar_15;
					      } else {
					        if ((tmpvar_10 == 2.0)) {
					          highp vec3 tmpvar_16;
					          tmpvar_16.x = tmpvar_11;
					          tmpvar_16.y = tmpvar_7.z;
					          tmpvar_16.z = tmpvar_13;
					          RGB_8 = tmpvar_16;
					        } else {
					          if ((tmpvar_10 == 3.0)) {
					            highp vec3 tmpvar_17;
					            tmpvar_17.x = tmpvar_11;
					            tmpvar_17.y = tmpvar_12;
					            tmpvar_17.z = tmpvar_7.z;
					            RGB_8 = tmpvar_17;
					          } else {
					            if ((tmpvar_10 == 4.0)) {
					              highp vec3 tmpvar_18;
					              tmpvar_18.x = tmpvar_13;
					              tmpvar_18.y = tmpvar_11;
					              tmpvar_18.z = tmpvar_7.z;
					              RGB_8 = tmpvar_18;
					            } else {
					              highp vec3 tmpvar_19;
					              tmpvar_19.x = tmpvar_7.z;
					              tmpvar_19.y = tmpvar_11;
					              tmpvar_19.z = tmpvar_12;
					              RGB_8 = tmpvar_19;
					            };
					          };
					        };
					      };
					    };
					    xlat_varmod_1.xyz = RGB_8;
					  };
					  gl_FragData[0] = xlat_varmod_1;
					}
					
					
					#endif
}
SubProgram "gles hw_tier03 " {

					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = _glesVertex;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform sampler2D _MainTex;
					uniform highp float _CutOff;
					uniform highp float _Scale;
					uniform highp float _Saturation;
					uniform highp float _value;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 xlat_varmod_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  xlat_varmod_1 = tmpvar_2;
					  if ((xlat_varmod_1.w < _CutOff)) {
					    discard;
					  };
					  highp int tmpvar_3;
					  tmpvar_3 = int(max (0.0, sign(xlat_varmod_1.w)));
					  if (bool(tmpvar_3)) {
					    highp float _Hue_4;
					    highp vec4 ver_5;
					    ver_5.yzw = xlv_TEXCOORD1.yzw;
					    highp float tmpvar_6;
					    tmpvar_6 = (_Time.y * 0.1);
					    ver_5.x = ((xlv_TEXCOORD1.x + sin(xlv_TEXCOORD1.y)) + cos((xlv_TEXCOORD1.z + tmpvar_6)));
					    ver_5.y = ((xlv_TEXCOORD1.y + sin(xlv_TEXCOORD1.z)) + cos((ver_5.x + tmpvar_6)));
					    ver_5.z = ((xlv_TEXCOORD1.z + sin(ver_5.x)) + cos((ver_5.y + tmpvar_6)));
					    _Hue_4 = sin((_Time.x + (ver_5.x / _Scale)));
					    _Hue_4 = (_Hue_4 + sin((_Time.z + 
					      (ver_5.x / _Scale)
					    )));
					    _Hue_4 = (_Hue_4 + cos((_Time.y + 
					      (ver_5.y / _Scale)
					    )));
					    _Hue_4 = (_Hue_4 + cos((_Time.x + 
					      (ver_5.y / _Scale)
					    )));
					    _Hue_4 = (_Hue_4 + sin((_Time.y + 
					      (ver_5.z / _Scale)
					    )));
					    _Hue_4 = (_Hue_4 + sin((_Time.z + 
					      (ver_5.z / _Scale)
					    )));
					    _Hue_4 += 6.0;
					    _Hue_4 = (_Hue_4 / 12.0);
					    _Hue_4 = (_Hue_4 / 4.0);
					    highp vec3 tmpvar_7;
					    tmpvar_7.x = _Hue_4;
					    tmpvar_7.y = _Saturation;
					    tmpvar_7.z = _value;
					    highp vec3 RGB_8;
					    RGB_8 = tmpvar_7.zzz;
					    highp float tmpvar_9;
					    tmpvar_9 = (_Hue_4 * 6.0);
					    highp float tmpvar_10;
					    tmpvar_10 = floor(tmpvar_9);
					    highp float tmpvar_11;
					    tmpvar_11 = (_value * (1.0 - _Saturation));
					    highp float tmpvar_12;
					    tmpvar_12 = (_value * (1.0 - (_Saturation * 
					      (tmpvar_9 - tmpvar_10)
					    )));
					    highp float tmpvar_13;
					    tmpvar_13 = (_value * (1.0 - (_Saturation * 
					      (1.0 - (tmpvar_9 - tmpvar_10))
					    )));
					    if ((tmpvar_10 == 0.0)) {
					      highp vec3 tmpvar_14;
					      tmpvar_14.x = tmpvar_7.z;
					      tmpvar_14.y = tmpvar_13;
					      tmpvar_14.z = tmpvar_11;
					      RGB_8 = tmpvar_14;
					    } else {
					      if ((tmpvar_10 == 1.0)) {
					        highp vec3 tmpvar_15;
					        tmpvar_15.x = tmpvar_12;
					        tmpvar_15.y = tmpvar_7.z;
					        tmpvar_15.z = tmpvar_11;
					        RGB_8 = tmpvar_15;
					      } else {
					        if ((tmpvar_10 == 2.0)) {
					          highp vec3 tmpvar_16;
					          tmpvar_16.x = tmpvar_11;
					          tmpvar_16.y = tmpvar_7.z;
					          tmpvar_16.z = tmpvar_13;
					          RGB_8 = tmpvar_16;
					        } else {
					          if ((tmpvar_10 == 3.0)) {
					            highp vec3 tmpvar_17;
					            tmpvar_17.x = tmpvar_11;
					            tmpvar_17.y = tmpvar_12;
					            tmpvar_17.z = tmpvar_7.z;
					            RGB_8 = tmpvar_17;
					          } else {
					            if ((tmpvar_10 == 4.0)) {
					              highp vec3 tmpvar_18;
					              tmpvar_18.x = tmpvar_13;
					              tmpvar_18.y = tmpvar_11;
					              tmpvar_18.z = tmpvar_7.z;
					              RGB_8 = tmpvar_18;
					            } else {
					              highp vec3 tmpvar_19;
					              tmpvar_19.x = tmpvar_7.z;
					              tmpvar_19.y = tmpvar_11;
					              tmpvar_19.z = tmpvar_12;
					              RGB_8 = tmpvar_19;
					            };
					          };
					        };
					      };
					    };
					    xlat_varmod_1.xyz = RGB_8;
					  };
					  gl_FragData[0] = xlat_varmod_1;
					}
					
					
					#endif
}
SubProgram "gles3 hw_tier01 " {

					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _CutOff;
					uniform 	float _Scale;
					uniform 	float _Saturation;
					uniform 	float _value;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					int u_xlati1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat5;
					int u_xlati5;
					bvec2 u_xlatb5;
					vec2 u_xlat9;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat0.w<_CutOff);
					#else
					    u_xlatb1 = u_xlat0.w<_CutOff;
					#endif
					    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = 0.0<u_xlat0.w; u_xlati1 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati1 = int((0.0<u_xlat0.w) ? 0xFFFFFFFFu : uint(0u));
					#endif
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = u_xlat0.w<0.0; u_xlati5 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati5 = int((u_xlat0.w<0.0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					    u_xlati1 = (-u_xlati1) + u_xlati5;
					    u_xlati1 = max(u_xlati1, 0);
					    u_xlat5.xy = sin(vs_TEXCOORD1.yz);
					    u_xlat5.xy = u_xlat5.xy + vs_TEXCOORD1.xy;
					    u_xlat13 = _Time.y * 0.100000001 + vs_TEXCOORD1.z;
					    u_xlat13 = cos(u_xlat13);
					    u_xlat5.x = u_xlat13 + u_xlat5.x;
					    u_xlat13 = _Time.y * 0.100000001 + u_xlat5.x;
					    u_xlat13 = cos(u_xlat13);
					    u_xlat5.y = u_xlat13 + u_xlat5.y;
					    u_xlat13 = sin(u_xlat5.x);
					    u_xlat13 = u_xlat13 + vs_TEXCOORD1.z;
					    u_xlat2.x = _Time.y * 0.100000001 + u_xlat5.y;
					    u_xlat2.x = cos(u_xlat2.x);
					    u_xlat13 = u_xlat13 + u_xlat2.x;
					    u_xlat5.xy = u_xlat5.xy / vec2(vec2(_Scale, _Scale));
					    u_xlat2.xy = u_xlat5.xx + _Time.xz;
					    u_xlat2.xy = sin(u_xlat2.xy);
					    u_xlat5.x = u_xlat2.y + u_xlat2.x;
					    u_xlat2.xy = u_xlat5.yy + _Time.yx;
					    u_xlat2.xy = cos(u_xlat2.xy);
					    u_xlat5.x = u_xlat5.x + u_xlat2.x;
					    u_xlat5.x = u_xlat2.y + u_xlat5.x;
					    u_xlat9.x = u_xlat13 / _Scale;
					    u_xlat9.xy = vec2(u_xlat9.x + _Time.y, u_xlat9.x + _Time.z);
					    u_xlat9.xy = sin(u_xlat9.xy);
					    u_xlat5.x = u_xlat9.x + u_xlat5.x;
					    u_xlat5.x = u_xlat9.y + u_xlat5.x;
					    u_xlat5.x = u_xlat5.x + 6.0;
					    u_xlat9.x = u_xlat5.x * 0.125;
					    u_xlat9.x = floor(u_xlat9.x);
					    u_xlat13 = (-_Saturation) + 1.0;
					    u_xlat2.y = u_xlat13 * _value;
					    u_xlat5.x = u_xlat5.x * 0.125 + (-u_xlat9.x);
					    u_xlat5.z = (-_Saturation) * u_xlat5.x + 1.0;
					    u_xlat5.x = (-u_xlat5.x) + 1.0;
					    u_xlat5.x = (-_Saturation) * u_xlat5.x + 1.0;
					    u_xlat2.xw = u_xlat5.zx * vec2(vec2(_value, _value));
					    u_xlatb5.xy = equal(u_xlat9.xxxx, vec4(0.0, 1.0, 0.0, 0.0)).xy;
					    u_xlat2.z = _value;
					    u_xlat3.xyz = (u_xlatb5.y) ? u_xlat2.xzy : u_xlat2.zyx;
					    u_xlat5.xyz = (u_xlatb5.x) ? u_xlat2.zwy : u_xlat3.xyz;
					    SV_Target0.xyz = (int(u_xlati1) != 0) ? u_xlat5.xyz : u_xlat0.xyz;
					    SV_Target0.w = u_xlat0.w;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier02 " {

					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _CutOff;
					uniform 	float _Scale;
					uniform 	float _Saturation;
					uniform 	float _value;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					int u_xlati1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat5;
					int u_xlati5;
					bvec2 u_xlatb5;
					vec2 u_xlat9;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat0.w<_CutOff);
					#else
					    u_xlatb1 = u_xlat0.w<_CutOff;
					#endif
					    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = 0.0<u_xlat0.w; u_xlati1 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati1 = int((0.0<u_xlat0.w) ? 0xFFFFFFFFu : uint(0u));
					#endif
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = u_xlat0.w<0.0; u_xlati5 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati5 = int((u_xlat0.w<0.0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					    u_xlati1 = (-u_xlati1) + u_xlati5;
					    u_xlati1 = max(u_xlati1, 0);
					    u_xlat5.xy = sin(vs_TEXCOORD1.yz);
					    u_xlat5.xy = u_xlat5.xy + vs_TEXCOORD1.xy;
					    u_xlat13 = _Time.y * 0.100000001 + vs_TEXCOORD1.z;
					    u_xlat13 = cos(u_xlat13);
					    u_xlat5.x = u_xlat13 + u_xlat5.x;
					    u_xlat13 = _Time.y * 0.100000001 + u_xlat5.x;
					    u_xlat13 = cos(u_xlat13);
					    u_xlat5.y = u_xlat13 + u_xlat5.y;
					    u_xlat13 = sin(u_xlat5.x);
					    u_xlat13 = u_xlat13 + vs_TEXCOORD1.z;
					    u_xlat2.x = _Time.y * 0.100000001 + u_xlat5.y;
					    u_xlat2.x = cos(u_xlat2.x);
					    u_xlat13 = u_xlat13 + u_xlat2.x;
					    u_xlat5.xy = u_xlat5.xy / vec2(vec2(_Scale, _Scale));
					    u_xlat2.xy = u_xlat5.xx + _Time.xz;
					    u_xlat2.xy = sin(u_xlat2.xy);
					    u_xlat5.x = u_xlat2.y + u_xlat2.x;
					    u_xlat2.xy = u_xlat5.yy + _Time.yx;
					    u_xlat2.xy = cos(u_xlat2.xy);
					    u_xlat5.x = u_xlat5.x + u_xlat2.x;
					    u_xlat5.x = u_xlat2.y + u_xlat5.x;
					    u_xlat9.x = u_xlat13 / _Scale;
					    u_xlat9.xy = vec2(u_xlat9.x + _Time.y, u_xlat9.x + _Time.z);
					    u_xlat9.xy = sin(u_xlat9.xy);
					    u_xlat5.x = u_xlat9.x + u_xlat5.x;
					    u_xlat5.x = u_xlat9.y + u_xlat5.x;
					    u_xlat5.x = u_xlat5.x + 6.0;
					    u_xlat9.x = u_xlat5.x * 0.125;
					    u_xlat9.x = floor(u_xlat9.x);
					    u_xlat13 = (-_Saturation) + 1.0;
					    u_xlat2.y = u_xlat13 * _value;
					    u_xlat5.x = u_xlat5.x * 0.125 + (-u_xlat9.x);
					    u_xlat5.z = (-_Saturation) * u_xlat5.x + 1.0;
					    u_xlat5.x = (-u_xlat5.x) + 1.0;
					    u_xlat5.x = (-_Saturation) * u_xlat5.x + 1.0;
					    u_xlat2.xw = u_xlat5.zx * vec2(vec2(_value, _value));
					    u_xlatb5.xy = equal(u_xlat9.xxxx, vec4(0.0, 1.0, 0.0, 0.0)).xy;
					    u_xlat2.z = _value;
					    u_xlat3.xyz = (u_xlatb5.y) ? u_xlat2.xzy : u_xlat2.zyx;
					    u_xlat5.xyz = (u_xlatb5.x) ? u_xlat2.zwy : u_xlat3.xyz;
					    SV_Target0.xyz = (int(u_xlati1) != 0) ? u_xlat5.xyz : u_xlat0.xyz;
					    SV_Target0.w = u_xlat0.w;
					    return;
					}
					#endif
}
SubProgram "gles3 hw_tier03 " {

					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _CutOff;
					uniform 	float _Scale;
					uniform 	float _Saturation;
					uniform 	float _value;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					int u_xlati1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat5;
					int u_xlati5;
					bvec2 u_xlatb5;
					vec2 u_xlat9;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat0.w<_CutOff);
					#else
					    u_xlatb1 = u_xlat0.w<_CutOff;
					#endif
					    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = 0.0<u_xlat0.w; u_xlati1 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati1 = int((0.0<u_xlat0.w) ? 0xFFFFFFFFu : uint(0u));
					#endif
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = u_xlat0.w<0.0; u_xlati5 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati5 = int((u_xlat0.w<0.0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					    u_xlati1 = (-u_xlati1) + u_xlati5;
					    u_xlati1 = max(u_xlati1, 0);
					    u_xlat5.xy = sin(vs_TEXCOORD1.yz);
					    u_xlat5.xy = u_xlat5.xy + vs_TEXCOORD1.xy;
					    u_xlat13 = _Time.y * 0.100000001 + vs_TEXCOORD1.z;
					    u_xlat13 = cos(u_xlat13);
					    u_xlat5.x = u_xlat13 + u_xlat5.x;
					    u_xlat13 = _Time.y * 0.100000001 + u_xlat5.x;
					    u_xlat13 = cos(u_xlat13);
					    u_xlat5.y = u_xlat13 + u_xlat5.y;
					    u_xlat13 = sin(u_xlat5.x);
					    u_xlat13 = u_xlat13 + vs_TEXCOORD1.z;
					    u_xlat2.x = _Time.y * 0.100000001 + u_xlat5.y;
					    u_xlat2.x = cos(u_xlat2.x);
					    u_xlat13 = u_xlat13 + u_xlat2.x;
					    u_xlat5.xy = u_xlat5.xy / vec2(vec2(_Scale, _Scale));
					    u_xlat2.xy = u_xlat5.xx + _Time.xz;
					    u_xlat2.xy = sin(u_xlat2.xy);
					    u_xlat5.x = u_xlat2.y + u_xlat2.x;
					    u_xlat2.xy = u_xlat5.yy + _Time.yx;
					    u_xlat2.xy = cos(u_xlat2.xy);
					    u_xlat5.x = u_xlat5.x + u_xlat2.x;
					    u_xlat5.x = u_xlat2.y + u_xlat5.x;
					    u_xlat9.x = u_xlat13 / _Scale;
					    u_xlat9.xy = vec2(u_xlat9.x + _Time.y, u_xlat9.x + _Time.z);
					    u_xlat9.xy = sin(u_xlat9.xy);
					    u_xlat5.x = u_xlat9.x + u_xlat5.x;
					    u_xlat5.x = u_xlat9.y + u_xlat5.x;
					    u_xlat5.x = u_xlat5.x + 6.0;
					    u_xlat9.x = u_xlat5.x * 0.125;
					    u_xlat9.x = floor(u_xlat9.x);
					    u_xlat13 = (-_Saturation) + 1.0;
					    u_xlat2.y = u_xlat13 * _value;
					    u_xlat5.x = u_xlat5.x * 0.125 + (-u_xlat9.x);
					    u_xlat5.z = (-_Saturation) * u_xlat5.x + 1.0;
					    u_xlat5.x = (-u_xlat5.x) + 1.0;
					    u_xlat5.x = (-_Saturation) * u_xlat5.x + 1.0;
					    u_xlat2.xw = u_xlat5.zx * vec2(vec2(_value, _value));
					    u_xlatb5.xy = equal(u_xlat9.xxxx, vec4(0.0, 1.0, 0.0, 0.0)).xy;
					    u_xlat2.z = _value;
					    u_xlat3.xyz = (u_xlatb5.y) ? u_xlat2.xzy : u_xlat2.zyx;
					    u_xlat5.xyz = (u_xlatb5.x) ? u_xlat2.zwy : u_xlat3.xyz;
					    SV_Target0.xyz = (int(u_xlati1) != 0) ? u_xlat5.xyz : u_xlat0.xyz;
					    SV_Target0.w = u_xlat0.w;
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
}
}