import React from "react";
import "./AnimatedAtom.css";

const AnimatedAtom: React.FC = () => (
  <div className="atom-container">
    <svg
      className="atom-svg"
      viewBox="0 0 200 200"
      width="200"
      height="200"
      xmlns="http://www.w3.org/2000/svg"
    >
      {/* Orbit 1: 0deg */}
      <ellipse
        className="orbit orbit1"
        cx="100"
        cy="100"
        rx="80"
        ry="30"
        fill="none"
        stroke="#e9f5f9"
        strokeWidth="4"
      />
      {/* Orbit 2: 60deg */}
      <ellipse
        className="orbit orbit2"
        cx="100"
        cy="100"
        rx="80"
        ry="30"
        fill="none"
        stroke="#e9f5f9"
        strokeWidth="4"
      />
      {/* Orbit 3: 120deg */}
      <ellipse
        className="orbit orbit3"
        cx="100"
        cy="100"
        rx="80"
        ry="30"
        fill="none"
        stroke="#e9f5f9"
        strokeWidth="4"
      />
      {/* Center Text */}
      <text
        x="100"
        y="110"
        textAnchor="middle"
        fontSize="15"
        fontWeight="bold"
        fill="#299ecf"
        fontFamily="sans-serif"
      >
        FOCUS
      </text>
    </svg>
  </div>
);

export default AnimatedAtom; 