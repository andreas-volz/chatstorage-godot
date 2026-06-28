# ChatStorage Godot Reference Application

This repository contains the reference Godot application for the ChatStorage ecosystem.

---

## Overview

This project is the **reference implementation for displaying and interacting with ChatStorage data in a Godot 4.x application**.

The ChatStorage GDExtension is used as an internal integration layer to access the underlying C++ core library, but this project focuses on how ChatStorage data is presented and used at the application level.

---

## Role in the Architecture

ChatStorage (core C++)  
↓  
chatstorage-gdextension (integration layer)  
↓  
chatstorage-godot (reference application)

---

## Dependencies

- Godot 4.x
- ChatStorage GDExtension  
  https://github.com/andreas-volz/chatstorage-gdextension
- ChatStorage core library  
  https://github.com/andreas-volz/chatstorage

---

## Setup

### 1. Clone repository

git clone https://github.com/andreas-volz/chatstorage-godot.git  
cd chatstorage-godot

---

### 2. Build and prepare GDExtension

Ensure the GDExtension is built before running the project:

https://github.com/andreas-volz/chatstorage-gdextension

The compiled library must be available in the expected `bin/<platform>/` directory.

---

### 3. Open in Godot

- Open Godot Engine 4.x
- Import this repository as a project
- Run the main scene

---

## Purpose

This project demonstrates how ChatStorage data is visualized and interacted with inside a Godot application.

It serves as:

- Reference for data presentation and UI patterns
- Validation layer for GDExtension integration
- Runtime test environment for ChatStorage data flow

The GDExtension is only an integration mechanism, not the focus of this repository.

